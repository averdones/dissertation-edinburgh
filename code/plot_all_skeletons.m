function plot_all_skeletons(path_input_pcl, path_input_skel, whichpcl, path_output)
%{
    Save the pngs of all the skeletons for every person and action.

    Inputs:
    - path_input_pcl: input path of the point clouds.
    - path_input_skel: input path of the predicted skeletons.
    - whichpcl: character choosing the pcl selected. Merged or separate.
    - path_output: output path.

    Returns:
%}

% Set default input path of point clouds
if nargin < 1 || isempty(path_input_pcl)
     path_input_pcl = 'D:/University of Edinburgh/Dissertation/data/final_results/point_clouds/';
end

% Set default input path of skeletons
if nargin < 2 || isempty(path_input_skel)
     path_input_skel = 'D:/University of Edinburgh/Dissertation/data/final_results/skeletons/';
end

% Set default pcl
if nargin < 3 || isempty(whichpcl)
     whichpcl = 'merged';
end

% Set default output path
if nargin < 4 || isempty(path_output)
     path_output = 'D:/University of Edinburgh/Dissertation/data/final_results/skeleton_pictures/';
end

% Name of the bagfiles
bagfiles = {'person1_move1_no_occlusion', 'person1_move2_horz_cross', 'person1_move3_vert_cross',...
    'person1_move4_high_five', 'person1_move5_arms_together', 'person1_move6_no_color',...
    'person2_move1_no_occlusion', 'person2_move2_horz_cross', 'person2_move3_vert_cross',...
    'person2_move4_high_five', 'person2_move5_arms_together', 'person2_move6_no_color',...
    'person3_move1_no_occlusion', 'person3_move2_horz_cross', 'person3_move3_vert_cross',...
    'person3_move4_high_five', 'person3_move5_arms_together', 'person3_move6_no_color',...
    'person4_move1_no_occlusion', 'person4_move2_horz_cross', 'person4_move3_vert_cross',...
    'person4_move4_high_five', 'person4_move5_arms_together', 'person4_move6_no_color',...
    'person5_move1_no_occlusion', 'person5_move2_horz_cross', 'person5_move3_vert_cross',...
    'person5_move4_high_five', 'person5_move5_arms_together', 'person5_move6_no_color'};

% Loop through all the results
for i = 1:length(bagfiles)
    
    % Load point clouds
    load([path_input_pcl, bagfiles{i}, '_pcl.mat']);

    % Load predicted skeletons
    load([path_input_skel, bagfiles{i}, '_', whichpcl, '_skeleton.mat']);

    % Create output path
    mkdir([path_output, bagfiles{i}])
    
    % Save pngs
    plot_skeleton_gt(bagfiles{i}, mergedpcl, best_rshoulder, best_relbow, best_lshoulder, ...
        best_lelbow, [path_output, bagfiles{i}, '/'], [], [], [], [], [], [], false, true, [], ...
        'asdf')
end
