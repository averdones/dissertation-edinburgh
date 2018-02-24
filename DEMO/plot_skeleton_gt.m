function plot_skeleton_gt(bagfile, mergedpcl, relbow, rwrist, lelbow, lwrist, path_output, ...
    frames, plotSkeleton, plotSurface, plotSkeletonGt, plotBonesGt, plotSurfaceGt, show_plots, ...
    save_plots, namefile, type_plot, az_view, el_view, perc_down, col_joint, ms, col_bone, bw, ...
    col_joint_gt, ms_gt, col_bone_gt, bw_gt, chest2neck, neck2head)
%{
    Plot the skeleton.

    Inputs:
    - mergedpcl: merged point cloud with the four kinects.
    - whichpcl: character choosing the pcl selected. Merged or separate.
    - path_input_pcl: input path of the point clouds.
    - path_input_skel: input path of the predicted skeletons.
    - load_pcl_skel: false to not load the point clouds and skeleton to
    speed up (they have to be loaded previously then.
    - path_output: path to save plots.
    - frames: frames to plot.
    - plotSkeleton: true if want the skeleton to show.
    - plotSurface: true if want the surface to show.
    - plotSkeletonGt: true if want the ground truth skeleton to show.
    - plotBonesGt: true if want the ground truth bones to show.   
    - plotSurfaceGt: true if want the ground truth surface to show.   
    - show_plots: false to not show the plots and save plots faster.
    - save_plots: true to save plots as png.
    - namefile: name for the png files.
    - type_plot: choose between using 'pcshow' or 'scatter3'. Character.
    - az_view: azimuth of the camera viewpoint.
    - el_view: elevation of the camera viewpoint.
    - perc_down: percentage downsample the point cloud (to visualize better).
    - col_joint: colors of the joints. Character or cell for a 
    different color for every joint.
    - ms: marker size of joints.
    - col_bone: colors of the bones. Character or cell for a 
    different color for every bone.
    - bw: bone width.
    - col_joint_gt: colors of the ground truth joints. Character or cell for a 
    different color for every joint.
    - ms_gt: marker size of ground truth joints.
    - col_bone_gt: colors of the ground truth bones. Character or cell for a 
    different color for every bone.
    - bw_gt:  ground truth bone width.
    - chest2neck: translation from chest to neck.
    - neck2head: translation from neck to head.

    Returns:
%}

% Load ground truth
ground_truth

% Number of joints
n_joints = 9;

% Set default output path
if nargin < 7 || isempty(path_output)
     path_output = 'D:/University of Edinburgh/Dissertation/data/final_results/skeleton_pictures/';
end

% Set default frames to plot
frames_was_empty = false;
if nargin < 8 || isempty(frames)
     frames = 1:length(mergedpcl);
     frames_was_empty = true;
end

% Set default plot_skeleton behavior
if nargin < 9 || isempty(plotSkeleton)
     plotSkeleton = true;
end

% Set default plot_surface behavior
if nargin < 10 || isempty(plotSurface)
     plotSurface = true;
end

% Set default plot_skeleton behavior
if nargin < 11 || isempty(plotSkeletonGt)
     plotSkeletonGt = true;
end

% Set default plot_surface behavior
if nargin < 12 || isempty(plotBonesGt)
     plotBonesGt = true;
end

% Set default show plot behavior
if nargin < 13 || isempty(plotSurfaceGt)
     plotSurfaceGt = false;
end

% Set default show plot behavior
if nargin < 14 || isempty(show_plots)
     show_plots = true;
end

% Set default save plot behavior
if nargin < 15 || isempty(save_plots)
     save_plots = false;
end

% Set default name for saved files
if nargin < 16 || isempty(namefile)
     namefile = datestr(clock, 'dd-mmmm-yyyy_HH-MM-SS');
end

% Set default type of plot
if nargin < 17 || isempty(type_plot)
     type_plot = 'pcshow';
end

% Set default azimuth viewpoint
if nargin < 18 || isempty(az_view)
     az_view = 60;
end

% Set default elevation viewpoint
if nargin < 19 || isempty(el_view)
     el_view = 20;
end

% Set default percentage to downsample in pcshow
if nargin < 20 || isempty(perc_down)
     perc_down = 0.4;
end

% Set default joint colors
def_joint_color = 'red';
if nargin < 21|| isempty(col_joint)
    col_joint = repmat({def_joint_color}, 1, n_joints);
elseif ~iscell(col_joint) && size(col_joint, 1) == 1
    col_joint = repmat({col_joint}, 1, n_joints);
elseif iscell(col_joint) && length(col_joint) ~= n_joints
    col_joint = repmat(col_joint(1), 1, n_joints);
end

% Set default joint size
if nargin < 22 || isempty(ms)
     ms = 50;
end

% Set default bone colors
def_bone_color = 'yellow';
if nargin < 23 || isempty(col_bone)
    col_bone = repmat({def_bone_color}, 1, n_joints);
elseif ~iscell(col_bone) && size(col_bone, 1) == 1
    col_bone = repmat({col_bone}, 1, n_joints);
elseif iscell(col_bone) && length(col_bone) ~= n_joints
    col_bone = repmat(col_bone(1), 1, n_joints);
end

% Set default bone width
if nargin < 24 || isempty(bw)
     bw = 4;
end

% Set default ground truth joint colors
def_joint_color_gt = 'blue';
if nargin < 25 || isempty(col_joint_gt)
    col_joint_gt = repmat({def_joint_color_gt}, 1, n_joints);
elseif ~iscell(col_joint_gt) && size(col_joint_gt, 1) == 1
    col_joint_gt = repmat({col_joint_gt}, 1, n_joints);
elseif iscell(col_joint_gt) && length(col_joint_gt) ~= n_joints
    col_joint_gt = repmat(col_joint_gt(1), 1, n_joints);
end

% Set default ground truth joint size
if nargin < 26 || isempty(ms_gt)
     ms_gt = 50;
end

% Set default ground truth bone colors
def_bone_color_gt = 'green';
if nargin < 27 || isempty(col_bone)
    col_bone_gt = repmat({def_bone_color_gt}, 1, n_joints);
elseif ~iscell(col_bone_gt) && size(col_bone_gt, 1) == 1
    col_bone_gt = repmat({col_bone_gt}, 1, n_joints);
elseif iscell(col_bone_gt) && length(col_bone_gt) ~= n_joints
    col_bone_gt = repmat(col_bone_gt(1), 1, n_joints);
end

% Set default ground truth bone width
if nargin < 28 || isempty(bw_gt)
     bw_gt = 4;
end

% Set default translation to right shoulder
if nargin < 29 || isempty(chest2neck)
     chest2neck = [-0.05 -0.02 0.15];
end

% Set default translation to left shoulder
if nargin < 30 || isempty(neck2head)
     neck2head = [0.01 0 0.1];
end

% ------------------------------------------------------------------------------------
if contains(bagfile,'person1_move6')
    mergedpcl = mergedpcl(27:end);
    if frames_was_empty
        frames = frames(1:end-27+1);
    end
end
if contains(bagfile,'person2_move6')
    mergedpcl = mergedpcl(23:end);
    if frames_was_empty
        frames = frames(1:end-23+1);
    end
end
if contains(bagfile,'person3_move6')
    mergedpcl = mergedpcl(25:end);
    if frames_was_empty
        frames = frames(1:end-25+1);
    end
end
if contains(bagfile,'person4_move6')
    mergedpcl = mergedpcl(20:end);
    if frames_was_empty
        frames = frames(1:end-20+1);
    end
end
if contains(bagfile,'person5_move6')
    mergedpcl = mergedpcl(35:end);
    if frames_was_empty
        frames = frames(1:end-35+1);
    end
end
if contains(bagfile,'person1')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-inf,0.42]);
    chest2rshoulder = [-0.03 -0.18 0.08];
    chest2lshoulder = [-0.03 0.19 0.08];
elseif contains(bagfile,'person2')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.05,0.38;-inf,0.49]);
    chest2rshoulder = [-0.08 -0.18 0.1];
    chest2lshoulder = [-0.08 0.19 0.1];
elseif contains(bagfile,'person3')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;0,0.38;-inf,0.41]);
    chest2rshoulder = [-0.01 -0.20 0.06];
    chest2lshoulder = [0.0 0.15 0.06];
elseif contains(bagfile,'person4')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.06,0.32;-inf,0.41]);
    chest2rshoulder = [-0.03 -0.16 0.08];
    chest2lshoulder = [-0.03 0.19 0.08];
elseif contains(bagfile,'person5')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.09,0.27;-inf,0.39]);
    chest2rshoulder = [0.02 -0.13 0.02];
    chest2lshoulder = [0.02 0.14 0.02];
end
if contains(bagfile,'person1_move5')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-inf,0.42]);
    chest2rshoulder = [0.02 -0.13 0.08];
    chest2lshoulder = [0.02 0.14 0.08];
end
if contains(bagfile,'person3_move3')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-inf,0.42]);
    chest2rshoulder = [-0.03 -0.21 0.08];
    chest2lshoulder = [-0.03 0.10 0.08];
end
if contains(bagfile,'person4_move5')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-inf,0.42]);
    chest2rshoulder = [-0.03 -0.15 0.08];
    chest2lshoulder = [-0.03 0.13 0.08];
end
if contains(bagfile,'person1_move6')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-0.02,0.42]);
    chest2rshoulder = [-0.03 -0.15 0.08];
    chest2lshoulder = [-0.03 0.13 0.08];
end
if contains(bagfile,'person2_move6')
    indices = findPointsInROI(mergedpcl{1},[-inf,-0.95;-0.05,0.38;-0.1,0.49]);
    chest2rshoulder = [-0.08 -0.21 0.12];
    chest2lshoulder = [-0.08 0.16 0.12];
end
if contains(bagfile,'person3_move6')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;0,0.38;0,0.41]);
    chest2rshoulder = [-0.01 -0.20 0.06];
    chest2lshoulder = [0.0 0.15 0.06];
end
if contains(bagfile,'person4_move6')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.06,0.32;0,0.41]);
    chest2rshoulder = [-0.06 -0.17 0.08];
    chest2lshoulder = [-0.06 0.13 0.08];
end
if contains(bagfile,'person5_move6')
    indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.18,0.22;-0.01,0.41]);
    chest2rshoulder = [0.0 -0.13 0.04];
    chest2lshoulder = [0.0 0.15 0.04];
end

pcChest = select(mergedpcl{1}, indices);
chest = mean(pcChest.Location, 1);

% Temporal correction to center the point clouds for the video
% It is necessary to subtract centroid chest from the point clouds 
% and joints
% chest = [0 0 0];

% Replicate chest
chest = repmat(chest', 1, length(mergedpcl));

% ------------------------------------------------------------------------------------

% Assign color joints
col_chest = col_joint{1};
col_rshoulder = col_joint{2};
col_relbow = col_joint{3};
col_rwrist = col_joint{4};
col_lshoulder = col_joint{5};
col_lelbow = col_joint{6};
col_lwrist = col_joint{7};
col_neck = col_joint{8};
col_head = col_joint{9};

% Assign color bones
col_cbr = col_bone{1};
col_ubr = col_bone{2};
col_lbr = col_bone{3};
col_cbl = col_bone{4};
col_ubl = col_bone{5};
col_lbl = col_bone{6};
col_nb = col_bone{7};
col_hb = col_bone{8};

% Assign ground truth color joints
col_chest_gt = col_joint_gt{1};
col_rshoulder_gt = col_joint_gt{2};
col_relbow_gt = col_joint_gt{3};
col_rwrist_gt = col_joint_gt{4};
col_lshoulder_gt = col_joint_gt{5};
col_lelbow_gt = col_joint_gt{6};
col_lwrist_gt = col_joint_gt{7};
col_neck_gt = col_joint_gt{8};
col_head_gt = col_joint_gt{9};

% Assign ground truth color bones
col_cbr_gt = col_bone_gt{1};
col_ubr_gt = col_bone_gt{2};
col_lbr_gt = col_bone_gt{3};
col_cbl_gt = col_bone_gt{4};
col_ubl_gt = col_bone_gt{5};
col_lbl_gt = col_bone_gt{6};
col_nb_gt = col_bone_gt{7};
col_hb_gt = col_bone_gt{8};

% ------------------------------------------------------------

% Right shoulder
rshoulder = chest + chest2rshoulder';

% Left shoulder
lshoulder = chest + chest2lshoulder';

% Neck
neck = chest + chest2neck';

% Head
head = neck + neck2head';

% Head cylinder centers
head_center1 = neck + [0 0 -0.01]';
head_center2 = head + [0 0 0.15]';

% Chest box
% Surface 1
chest_x = [chest(1,1)+0.07 chest(1,1)-0.2 chest(1,1)-0.2 chest(1,1)+0.07 chest(1,1)+0.07 chest(1,1)+0.07; ...
    chest(1,1)+0.07 chest(1,1)+0.07 chest(1,1)-0.2 chest(1,1)-0.2 chest(1,1)+0.07 chest(1,1)+0.07; ...
    chest(1,1)+0.07 chest(1,1)+0.07 chest(1,1)-0.2 chest(1,1)-0.2 chest(1,1)-0.2 chest(1,1)-0.2; ...
    chest(1,1)+0.07 chest(1,1)-0.2 chest(1,1)-0.2 chest(1,1)+0.07 chest(1,1)-0.2 chest(1,1)-0.2];

chest_y = [chest(2,1)-0.18 chest(2,1)-0.18 chest(2,1)+0.19 chest(2,1)+0.19 chest(2,1)-0.18 chest(2,1)-0.18; ...
    chest(2,1)+0.19 chest(2,1)-0.18 chest(2,1)-0.18 chest(2,1)+0.19 chest(2,1)+0.19 chest(2,1)+0.19; ...
    chest(2,1)+0.19 chest(2,1)-0.18 chest(2,1)-0.18 chest(2,1)+0.19 chest(2,1)+0.19 chest(2,1)+0.19; ...
    chest(2,1)-0.18 chest(2,1)-0.18 chest(2,1)+0.19 chest(2,1)+0.19 chest(2,1)-0.18 chest(2,1)-0.18];

chest_z = [chest(3,1)-0.22 chest(3,1)-0.22 chest(3,1)-0.22 chest(3,1)-0.22 chest(3,1)+0.13 chest(3,1)-0.22; ...
    chest(3,1)-0.22 chest(3,1)-0.22 chest(3,1)-0.22 chest(3,1)-0.22 chest(3,1)+0.13 chest(3,1)-0.22; ...
    chest(3,1)+0.13 chest(3,1)+0.13 chest(3,1)+0.13 chest(3,1)+0.13 chest(3,1)+0.13 chest(3,1)-0.22; ...
    chest(3,1)+0.13 chest(3,1)+0.13 chest(3,1)+0.13 chest(3,1)+0.13 chest(3,1)+0.13 chest(3,1)-0.22];

% --------------------------------------------------------------

% Assign ground truth
relbow_gt = eval([bagfile, '_relbow']);
rwrist_gt = eval([bagfile, '_rwrist']);
lelbow_gt = eval([bagfile, '_lelbow']);
lwrist_gt = eval([bagfile, '_lwrist']);

for i = frames
    if ~show_plots
        clf;
        set(gcf,'Visible','off');
    else
        figure(i);
        set(gcf,'Visible','on');
    end    
    
    % Plot point cloud with pcshow or scatter3
    if strcmp(type_plot, 'pcshow')
        % Downsample point cloud
        pcPlot = pcdownsample(mergedpcl{i},'random',perc_down);
        fig = pcshow(pcPlot, 'MarkerSize', 20);
        xlabel('X');ylabel('Y');zlabel('Z');
        hold on
    else
        xyz = mergedpcl{i}.Location;
        fig = scatter3(xyz(:,1), xyz(:,2), xyz(:,3), 5, ...
            double(mergedpcl{i}.Color)/255, 'filled', 'MarkerFaceAlpha', 0.2);
        xlabel('X');ylabel('Y');zlabel('Z');
        hold on
    end
    
    if plotSkeleton
        % Plot joints
        plot3(chest(1,i), chest(2,i), chest(3,i), '.', 'Color', col_chest, 'MarkerSize', ms)
        plot3(rshoulder(1,i), rshoulder(2,i), rshoulder(3,i), '.', 'Color', col_rshoulder, 'MarkerSize', ms)
        plot3(relbow(1,i), relbow(2,i), relbow(3,i), '.', 'Color', col_relbow, 'MarkerSize', ms)
        plot3(rwrist(1,i), rwrist(2,i), rwrist(3,i), '.', 'Color', col_rwrist, 'MarkerSize', ms)
        plot3(lshoulder(1,i), lshoulder(2,i), lshoulder(3,i), '.', 'Color', col_lshoulder, 'MarkerSize', ms)
        plot3(lelbow(1,i), lelbow(2,i), lelbow(3,i), '.', 'Color', col_lelbow, 'MarkerSize', ms)
        plot3(lwrist(1,i), lwrist(2,i), lwrist(3,i), '.', 'Color', col_lwrist, 'MarkerSize', ms)
        plot3(neck(1,i), neck(2,i), neck(3,i), '.', 'Color', col_neck, 'MarkerSize', ms)
        plot3(head(1,i), head(2,i), head(3,i), '.', 'Color', col_head, 'MarkerSize', ms)

        % Create bone lines
        chest_bone_right = horzcat(chest(:,i), rshoulder(:,i));
        uparm_bone_right = horzcat(rshoulder(:,i), relbow(:,i));
        loarm_bone_right = horzcat(relbow(:,i), rwrist(:,i));
        chest_bone_left = horzcat(chest(:,i), lshoulder(:,i));
        uparm_bone_left = horzcat(lshoulder(:,i), lelbow(:,i));
        loarm_bone_left = horzcat(lelbow(:,i), lwrist(:,i));
        chest_neck_bone = horzcat(chest(:,i), neck(:,i));
        neck_head_bone = horzcat(neck(:,i), head(:,i));

        % Plot bones
        line(chest_bone_right(1,:), chest_bone_right(2,:), chest_bone_right(3,:), 'Color', col_cbr, 'LineWidth', bw)
        line(uparm_bone_right(1,:), uparm_bone_right(2,:), uparm_bone_right(3,:), 'Color', col_ubr, 'LineWidth', bw)
        line(loarm_bone_right(1,:), loarm_bone_right(2,:), loarm_bone_right(3,:), 'Color', col_lbr, 'LineWidth', bw)
        line(chest_bone_left(1,:), chest_bone_left(2,:), chest_bone_left(3,:), 'Color', col_cbl, 'LineWidth', bw)
        line(uparm_bone_left(1,:), uparm_bone_left(2,:), uparm_bone_left(3,:), 'Color', col_ubl, 'LineWidth', bw)
        line(loarm_bone_left(1,:), loarm_bone_left(2,:), loarm_bone_left(3,:), 'Color', col_lbl, 'LineWidth', bw)
        line(chest_neck_bone(1,:), chest_neck_bone(2,:), chest_neck_bone(3,:), 'Color', col_nb, 'LineWidth', bw)
        line(neck_head_bone(1,:), neck_head_bone(2,:), neck_head_bone(3,:), 'Color', col_hb, 'LineWidth', bw)
    
    end
    
    if plotSurface
        % Create surfaces
        if ~isnan(rshoulder(1,i)) && ~isnan(relbow(1,i))
            uparm_cyl_right = cylinderModel([rshoulder(1,i), rshoulder(2,i), rshoulder(3,i), ...
                relbow(1,i), relbow(2,i), relbow(3,i), 0.05]);
            plot(uparm_cyl_right)
        end
        if ~isnan(lshoulder(1,i)) && ~isnan(lelbow(1,i))
            uparm_cyl_left = cylinderModel([lshoulder(1,i), lshoulder(2,i), lshoulder(3,i), ...
                lelbow(1,i), lelbow(2,i), lelbow(3,i), 0.05]);
            plot(uparm_cyl_left)
        end
        if ~isnan(relbow(1,i)) && ~isnan(rwrist(1,i))
            loarm_cyl_right = cylinderModel([relbow(1,i), relbow(2,i), relbow(3,i), ...
                rwrist(1,i), rwrist(2,i), rwrist(3,i), 0.05]);
            plot(loarm_cyl_right)
        end
        if ~isnan(lelbow(1,i)) && ~isnan(lwrist(1,i))
            loarm_cyl_left = cylinderModel([lelbow(1,i), lelbow(2,i), lelbow(3,i), ...
                lwrist(1,i), lwrist(2,i), lwrist(3,i), 0.05]);
            plot(loarm_cyl_left)
        end
        % Head
        head_cyl = cylinderModel([head_center1(1,i), head_center1(2,i), head_center1(3,i), ...
            head_center2(1,i), head_center2(2,i), head_center2(3,i), 0.11]);
        plot(head_cyl)
        
        % Torso
        for ii=1:6
            patch(chest_x(:,ii),chest_y(:,ii),chest_z(:,ii),'b');
        end
        
        % Set transparency
        alpha 0.2
        
        % Set viewpoint
        view(az_view,el_view)
    end
    
    % Plot ground truth
    if plotSkeletonGt
        if ~isnan(relbow_gt(1,i))
            plot3(chest(1,i), chest(2,i), chest(3,i), '.', 'Color', col_chest_gt, 'MarkerSize', ms_gt)
            plot3(rshoulder(1,i), rshoulder(2,i), rshoulder(3,i), '.', 'Color', col_rshoulder_gt, 'MarkerSize', ms_gt)
            plot3(relbow_gt(1,i), relbow_gt(2,i), relbow_gt(3,i), '.', 'Color', col_relbow_gt, 'MarkerSize', ms_gt)
            plot3(rwrist_gt(1,i), rwrist_gt(2,i), rwrist_gt(3,i), '.', 'Color', col_rwrist_gt, 'MarkerSize', ms_gt)
            plot3(lshoulder(1,i), lshoulder(2,i), lshoulder(3,i), '.', 'Color', col_lshoulder_gt, 'MarkerSize', ms_gt)
            plot3(lelbow_gt(1,i), lelbow_gt(2,i), lelbow_gt(3,i), '.', 'Color', col_lelbow_gt, 'MarkerSize', ms_gt)
            plot3(lwrist_gt(1,i), lwrist_gt(2,i), lwrist_gt(3,i), '.', 'Color', col_lwrist_gt, 'MarkerSize', ms_gt)
            plot3(neck(1,i), neck(2,i), neck(3,i), '.', 'Color', col_neck_gt, 'MarkerSize', ms_gt)
            plot3(head(1,i), head(2,i), head(3,i), '.', 'Color', col_head_gt, 'MarkerSize', ms_gt)
        end
    end
    if plotBonesGt
        if ~isnan(relbow_gt(1,i))
            % Create bone lines
            chest_bone_right_gt = horzcat(chest(:,i), rshoulder(:,i));
            uparm_bone_right_gt = horzcat(rshoulder(:,i), relbow_gt(:,i));
            loarm_bone_right_gt = horzcat(relbow_gt(:,i), rwrist_gt(:,i));
            chest_bone_left_gt = horzcat(chest(:,i), lshoulder(:,i));
            uparm_bone_left_gt = horzcat(lshoulder(:,i), lelbow_gt(:,i));
            loarm_bone_left_gt = horzcat(lelbow_gt(:,i), lwrist_gt(:,i));
            chest_neck_bone_gt = horzcat(chest(:,i), neck(:,i));
            neck_head_bone_gt = horzcat(neck(:,i), head(:,i));

            % Plot bones
            line(chest_bone_right_gt(1,:), chest_bone_right_gt(2,:), chest_bone_right_gt(3,:), 'Color', col_cbr_gt, 'LineWidth', bw_gt)
            line(uparm_bone_right_gt(1,:), uparm_bone_right_gt(2,:), uparm_bone_right_gt(3,:), 'Color', col_ubr_gt, 'LineWidth', bw_gt)
            line(loarm_bone_right_gt(1,:), loarm_bone_right_gt(2,:), loarm_bone_right_gt(3,:), 'Color', col_lbr_gt, 'LineWidth', bw_gt)
            line(chest_bone_left_gt(1,:), chest_bone_left_gt(2,:), chest_bone_left_gt(3,:), 'Color', col_cbl_gt, 'LineWidth', bw_gt)
            line(uparm_bone_left_gt(1,:), uparm_bone_left_gt(2,:), uparm_bone_left_gt(3,:), 'Color', col_ubl_gt, 'LineWidth', bw_gt)
            line(loarm_bone_left_gt(1,:), loarm_bone_left_gt(2,:), loarm_bone_left_gt(3,:), 'Color', col_lbl_gt, 'LineWidth', bw_gt)
            line(chest_neck_bone_gt(1,:), chest_neck_bone_gt(2,:), chest_neck_bone_gt(3,:), 'Color', col_nb_gt, 'LineWidth', bw_gt)
            line(neck_head_bone_gt(1,:), neck_head_bone_gt(2,:), neck_head_bone_gt(3,:), 'Color', col_hb_gt, 'LineWidth', bw_gt)
        end
    end
    if plotSurfaceGt
        % Create surfaces
        if ~isnan(rshoulder(1,i)) && ~isnan(relbow_gt(1,i))
            uparm_cyl_right_gt = cylinderModel([rshoulder(1,i), rshoulder(2,i), rshoulder(3,i), ...
                relbow_gt(1,i), relbow_gt(2,i), relbow_gt(3,i), 0.05]);
            plot(uparm_cyl_right_gt)
        end
        if ~isnan(lshoulder(1,i)) && ~isnan(lelbow_gt(1,i))
            uparm_cyl_left_gt = cylinderModel([lshoulder(1,i), lshoulder(2,i), lshoulder(3,i), ...
                lelbow_gt(1,i), lelbow_gt(2,i), lelbow_gt(3,i), 0.05]);
            plot(uparm_cyl_left_gt)
        end
        if ~isnan(relbow_gt(1,i)) && ~isnan(rwrist_gt(1,i))
            loarm_cyl_right_gt = cylinderModel([relbow_gt(1,i), relbow_gt(2,i), relbow_gt(3,i), ...
                rwrist_gt(1,i), rwrist_gt(2,i), rwrist_gt(3,i), 0.05]);
            plot(loarm_cyl_right_gt)
        end
        if ~isnan(lelbow_gt(1,i)) && ~isnan(lwrist_gt(1,i))
            loarm_cyl_left_gt = cylinderModel([lelbow_gt(1,i), lelbow_gt(2,i), lelbow_gt(3,i), ...
                lwrist_gt(1,i), lwrist_gt(2,i), lwrist_gt(3,i), 0.05]);
            plot(loarm_cyl_left_gt)
        end
    end
    
%     grid minor
%     axis off

    if save_plots
        saveas(fig, strcat(path_output, namefile, '_skeleton_', num2str(i), '.png'))
    end
    
    hold off
end

