function [cam, dm, xyz, rgb, pcl, are_diff_frames] = read_pcl(bagfile, kinects, write, ...
    path_input, path_output)
%{
    Reads a rosbag file. Optionally writes the variables with the color
    information, depth information and the pointcloud.

    % If the number of frames in each kinect is different, then frames at
    the start are removed from kinects with more frames. There is no
    problem because the start pose is maintained for a few seconds.

    Inputs:
    - bagfile: name of the file containing the rosbag. Character without '.bag'.
    - kinects: kinects to read. Integer from 1 to 4.
    - path_input: default path from where to read the bagfile. Character.
    - write: flag to choose if write a mat file. True or false.
    - path_output: default path where to (optionally) write the mat file. Character.
    - are_diff_frames: Boolean. True if number of frames were different for each kinect.
%}

% Set default kinects to read
if nargin < 2 || isempty(kinects)
     kinects = 1:4;
end

% Set default writing behavior
if nargin < 3 || isempty(write)
     write = false;
end

% Set default input path
if nargin < 4 || isempty(path_input)
     path_input = 'D:/University of Edinburgh/Dissertation/data/bags/';
end

% Set default output path
if nargin < 5 || isempty(path_output)
     path_output = 'D:/University of Edinburgh/Dissertation/data/output/';
end

% Read rosbag
bag = rosbag([path_input, bagfile, '.bag']);

% Read kinects
for ki = kinects
    % Read timestamps
    ts_msgs = timeseries(select(bag,'topic',sprintf('/kinect_%d/sd/points',ki))).Time;
    ts_imgs = timeseries(select(bag,'topic',sprintf('/kinect_%d/sd/image_color_rect',ki))).Time;
    ts_dmaps = timeseries(select(bag,'topic',sprintf('/kinect_%d/sd/image_depth_rect',ki))).Time;
    ts = {ts_msgs ts_imgs ts_dmaps};
    
    % Read msgs
    msgs = readMessages(select(bag,'topic',sprintf('/kinect_%d/sd/points',ki)));
    imgs = readMessages(select(bag,'topic',sprintf('/kinect_%d/sd/image_color_rect',ki)));
    dmaps = readMessages(select(bag,'topic',sprintf('/kinect_%d/sd/image_depth_rect',ki)));
    ros = {msgs imgs dmaps};
    
    % Synchronize timestamps from more frames to less
%     [~,si] = sort([length(ts_msgs) length(ts_imgs) length(ts_dmaps)]);
    % Synchronize timestamps of depth and pcl. Then color.
    si = [1 3 2];
    [ts1,ts2,a_ind1,b_ind1] = sync(ts{si(1)}, ts{si(2)});
    % Assign si(1)
    if si(1) == 1
        msgs = ros{si(1)}(a_ind1);
    elseif si(1) == 2
        imgs = ros{si(1)}(a_ind1);
    elseif si(1) == 3
        dmaps = ros{si(1)}(a_ind1);
    end
    % Assign si(2)
    if si(2) == 1
        msgs = ros{si(2)}(b_ind1);
    elseif si(2) == 2
        imgs = ros{si(2)}(b_ind1);
    elseif si(2) == 3
        dmaps = ros{si(2)}(b_ind1);
    end
    
    % Synchronize s(3) (we allow repeated frames for now)
    ts_mean = mean([ts1 ts2], 2);
    mdist = pdist2(ts{si(3)}, ts_mean);
    [~,ind3] = min(mdist, [], 1);
    % Assign si(3)
    if si(3) == 1
        msgs = ros{si(3)}(ind3);
    elseif si(3) == 2
        imgs = ros{si(3)}(ind3);
    elseif si(3) == 3
        dmaps = ros{si(3)}(ind3);
    end
        
    % Parse ROS data for every selected frame after synchronization
    for t = 1:length(msgs)
        cam{ki}{t} = readImage(imgs{t});
        dm{ki}{t} = readImage(dmaps{t});
        xyz{ki}{t} = readXYZ(msgs{t});
        rgb{ki}{t} = readRGB(msgs{t});
        pcl{ki}{t} = pointCloud(xyz{ki}{t},'Color',rgb{ki}{t});
    end
    
    % Save number of frames in each kinect
    n_frames{ki} = length(cam{ki});
    
    % Free java buffer
    clear msgs imgs dmaps ros;
end

% Equal number of frames
are_diff_frames = false;
min_frames = n_frames{kinects(1)};
for ki = kinects(2:end)
    % Check if number frames is different
    if n_frames{kinects(1)} ~= n_frames{ki}
        are_diff_frames = true;
    end
    % Store minimum number of frames
    if n_frames{ki} < min_frames
        min_frames = n_frames{ki};
    end
end

if are_diff_frames
    for ki = kinects
        cam{ki} = cam{ki}(length(cam{ki}) - min_frames + 1:end);
        dm{ki} = dm{ki}(length(dm{ki}) - min_frames + 1:end);
        xyz{ki} = xyz{ki}(length(xyz{ki}) - min_frames + 1:end);
        rgb{ki} = rgb{ki}(length(rgb{ki}) - min_frames + 1:end);
        pcl{ki} = pcl{ki}(length(pcl{ki}) - min_frames + 1:end);
    end
end
        
% Optionally write a mat file
if write
    save([path_output, 'mat/', bagfile, '.mat'], 'cam', 'dm', 'xyz', 'rgb', 'pcl', '-v7.3');
end

    

