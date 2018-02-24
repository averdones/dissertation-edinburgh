function [mergedpclclean, pclpersonclean, indices2pcl] = rotateCleanPcl(pclperson, indices2pcl, ...
    bagfile, path_input)
%{
    Rotates the 4 point clouds to have standard axes:
    - X-axis: crosses the body horizontally.
    - Y-axis: crosses the body vertically.
    - -axis: crosses the top of the head and the navel.
    Then, cleans the point clouds from points too far and outliers.
    
    Antonio Verdone, June 2016, Matlab R2017a.
    
    Inputs:
    - pclperson: cell containing the point clouds. Cell of size 4
    corresponding to each kinect.
    - indices2pcl: indices to go back to the color image.
    - bagfile: name of the file containing the rosbag. Character without '.bag'.
    - path_input: default path from where to read the bagfile. Character.

    Returns:
    - mergedpclclean: rotated and denoised merged point cloud.
    - pclpersonclean: the 4 separate point clouds rotated but not denoised.
    - indices2pcl: indices to come back to the color image of the separate point clouds.
%}

% Set default input path
if nargin < 4 || isempty(path_input)
     path_input = 'D:/University of Edinburgh/Dissertation/data/bags/';
end

% Read rosbag
bag = rosbag([path_input, bagfile, '.bag']);

% Read transformation messages
tf = readMessages(select(bag,'topic','/tf'));

% Create transformation matrices for each kinect
flag = ones(1, 4);   % When all elements are zero, break the loop
for i = 1:length(tf)
    % Terminate loop if flag equals 4
    if sum(flag) == 0
        break
    end   
    
    % Transformation of kinect 1
    if flag(1) == 1 && strcmp(tf{i}.Transforms.ChildFrameId, 'kinect_1_ir_optical_frame')
        % Save translation
        trans1 = [tf{i}.Transforms.Transform.Translation.X, ...
            tf{i}.Transforms.Transform.Translation.Y, ...
            tf{i}.Transforms.Transform.Translation.Z];
        
        % Save rotation
        rot1 = [tf{i}.Transforms.Transform.Rotation.W, ...
            tf{i}.Transforms.Transform.Rotation.X, ...
            tf{i}.Transforms.Transform.Rotation.Y, ...
            tf{i}.Transforms.Transform.Rotation.Z];
    
        % Create rotation matrix
        rotm1 = quat2rotm(rot1);
        
        % Create translation matrix
        tform1 = [rotm1 trans1'; [0 0 0 1]];
        
        % Set flag to zero on according element
        flag(1) = 0;

    % Transformation of kinect 2
    elseif flag(2) == 1 && strcmp(tf{i}.Transforms.ChildFrameId, 'kinect_2_ir_optical_frame')
        % Save translation
        trans2 = [tf{i}.Transforms.Transform.Translation.X, ...
            tf{i}.Transforms.Transform.Translation.Y, ...
            tf{i}.Transforms.Transform.Translation.Z];
        
        % Save rotation
        rot2 = [tf{i}.Transforms.Transform.Rotation.W, ...
            tf{i}.Transforms.Transform.Rotation.X, ...
            tf{i}.Transforms.Transform.Rotation.Y, ...
            tf{i}.Transforms.Transform.Rotation.Z];
    
        % Create rotation matrix
        rotm2 = quat2rotm(rot2);
        
        % Create translation matrix
        tform2 = [rotm2 trans2'; [0 0 0 1]];
        
        % Set flag to zero on according element
        flag(2) = 0;
        
    % Transformation of kinect 3
    elseif flag(3) == 1 && strcmp(tf{i}.Transforms.ChildFrameId, 'kinect_3_ir_optical_frame')
        % Save translation
        trans3 = [tf{i}.Transforms.Transform.Translation.X, ...
            tf{i}.Transforms.Transform.Translation.Y, ...
            tf{i}.Transforms.Transform.Translation.Z];
        
        % Save rotation
        rot3 = [tf{i}.Transforms.Transform.Rotation.W, ...
            tf{i}.Transforms.Transform.Rotation.X, ...
            tf{i}.Transforms.Transform.Rotation.Y, ...
            tf{i}.Transforms.Transform.Rotation.Z];
    
        % Create rotation matrix
        rotm3 = quat2rotm(rot3);
        
        % Create translation matrix
        tform3 = [rotm3 trans3'; [0 0 0 1]];
        
        % Set flag to zero on according element
        flag(3) = 0;
        
    % Transformation of kinect 4
    elseif flag(4) == 1 && strcmp(tf{i}.Transforms.ChildFrameId, 'kinect_4_ir_optical_frame')
        % Save translation
        trans4 = [tf{i}.Transforms.Transform.Translation.X, ...
            tf{i}.Transforms.Transform.Translation.Y, ...
            tf{i}.Transforms.Transform.Translation.Z];
        
        % Save rotation
        rot4 = [tf{i}.Transforms.Transform.Rotation.W, ...
            tf{i}.Transforms.Transform.Rotation.X, ...
            tf{i}.Transforms.Transform.Rotation.Y, ...
            tf{i}.Transforms.Transform.Rotation.Z];
    
        % Create rotation matrix
        rotm4 = quat2rotm(rot4);
        
        % Create translation matrix
        tform4 = [rotm4 trans4'; [0 0 0 1]];
        
        % Set flag to zero on according element
        flag(4) = 0;
    end
end

% Rotate additional -pi/2 to get axes correctly
% tt = axang2tform([1 0 0 -pi/2]);

% Apply transformation to point clouds
for ki = 1:length(pclperson)
    for t = 1:length(pclperson{ki})
        pc = pclperson{ki}{t};
        if ki == 1
            % Remove far points (different for each kinect)
            keeppoints = find(pc.Location(:,3) < 2);
            pc = select(pc, keeppoints);
            % Keep track of indices to go back to color image
            indices2pcl{ki}{t} = indices2pcl{ki}{t}(keeppoints);
            % Augment to get homogenous points
            hompoints = [pc.Location ones(size(pc.Location, 1), 1)]';
            % Tranform and remove trailing ones in the last row
            transfpcl = tform1 * hompoints;
            transfpcl = transfpcl(1:end-1,:)';
        elseif ki == 2
            % Remove far points (different for each kinect)
            keeppoints = find(pc.Location(:,3) < 2);
            pc = select(pc, keeppoints);
            % Keep track of indices to go back to color image
            indices2pcl{ki}{t} = indices2pcl{ki}{t}(keeppoints);
            % Augment to get homogenous points
            hompoints = [pc.Location ones(size(pc.Location, 1), 1)]';
            % Tranform and remove trailing ones in the last row
            transfpcl = tform2 * hompoints;
            transfpcl = transfpcl(1:end-1,:)';
        elseif ki == 3
            % Remove far points (different for each kinect)
            keeppoints = find(pc.Location(:,3) < 2.7 & pc.Location(:,3) > 1);
            pc = select(pc, keeppoints);
            % Keep track of indices to go back to color image
            indices2pcl{ki}{t} = indices2pcl{ki}{t}(keeppoints);
            % Augment to get homogenous points
            hompoints = [pc.Location ones(size(pc.Location, 1), 1)]';
            % Tranform and remove trailing ones in the last row
            transfpcl = tform3 * hompoints;
            transfpcl = transfpcl(1:end-1,:)';            
        elseif ki == 4
            % Remove far points (different for each kinect)
            keeppoints = find(pc.Location(:,3) < 2.7 & pc.Location(:,3) > 1);
            pc = select(pc, keeppoints);
            % Keep track of indices to go back to color image
            indices2pcl{ki}{t} = indices2pcl{ki}{t}(keeppoints);
            % Augment to get homogenous points
            hompoints = [pc.Location ones(size(pc.Location, 1), 1)]';
            % Tranform and remove trailing ones in the last row
            transfpcl = tform4 * hompoints;
            transfpcl = transfpcl(1:end-1,:)';            
        end
        % Save transformed point cloud
        pclpersonclean{ki}{t} = pointCloud(transfpcl,'Color',pc.Color);
    end
end

% Create merged point cloud
for t = 1:length(pclpersonclean{ki})
    loc = [];
    col = [];
    for ki = 1:length(pclpersonclean)
        loc = [loc; pclpersonclean{ki}{t}.Location];
        col = [col; pclpersonclean{ki}{t}.Color];
    end
    mergedpcl{t} = pointCloud(loc,'Color',col);
end

% Clean and denoise merged point cloud
for t = 1:length(mergedpcl)
    if mergedpcl{t}.Count > 1000
        mergedpclclean{t} = pcdenoise(mergedpcl{t}, 'Threshold', 0.4);
    end
end