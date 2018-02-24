function [cam, dm, xyz, rgb, pcl] = load_pcl(matfile, path_input)
%{
    Loads the mat file containing the variables with color, depth and
    pointcloud information.

    Inputs:
    - matfile: name of the file containing the information. Character without '.mat'.
    - path_input: default path from where to read the bagfile. Character.
%}

% Set default input path
if nargin < 2 || isempty(path_input)
     path_input = 'D:/University of Edinburgh/Dissertation/data/output/mat/';
end

% Load the mat file
data = load([path_input, matfile, '.mat']);

% Assign variables from the structure data
cam = data.cam;
dm = data.dm;
xyz = data.xyz;
rgb = data.rgb;
pcl = data.pcl;
