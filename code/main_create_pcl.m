function [mergedpcl, separatepcl, rotindices2pcl] = main_create_pcl(bagfile, write, path_output)
%{
    Wrapper to read the bagfile, detect the person and create the merged
    and separate point clouds.

    Inputs:
    - bagfile: name of the bagfile to read. Character.
    - write: flag to choose if write a mat file. True or false.
    - path_output: default path where to (optionally) write the mat file. Character.

    Returns:
    - mergedpcl: merged point cloud.
    - separatepcl: separate point clouds.
    - rotindices2pcl: indices to go back to the color image for separate point clouds.
%}

% Set default write behavior
if nargin < 2 || isempty(write)
     write = true;
end

% Set default output path
if nargin < 3 || isempty(path_output)
     path_output = 'D:/University of Edinburgh/Dissertation/data/final_results/point_clouds/';
end

% Read bagfile
[cam, dm, ~, ~, pcl, ~] = read_pcl(bagfile);

% Differentiate between color or no color detection
if contains(bagfile,'no_color')
    % Detect person
    person = personDetectionAllFramesNoColorBack(dm);    
else
    % Detect person
    person = personDetectionAllFrames(cam, dm, [], [], [], [], [], [], true);
end

% Calculate new point clouds using masks
[pclperson, indices2pcl] = mask2pcl(person, pcl);

% Create merged point cloud
[mergedpcl, separatepcl, rotindices2pcl] = rotateCleanPcl(pclperson, indices2pcl, bagfile);

% Write results
if write
    save([path_output, bagfile, '_pcl', '.mat'], 'mergedpcl', 'separatepcl', 'rotindices2pcl', '-v7.3');
end







