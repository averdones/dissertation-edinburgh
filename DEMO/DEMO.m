
% DEMO for the project:
% Tracking People and Arms in Robot Surgery Workcell Using Multiple RGB-D Sensors

% ----------------------------------------------------------------
% ----------------------------------------------------------------
% INSTRUCTIONS: in order for this demo to work, the following 4 files should be 
% stored in the same folder:
% plot_skeleton_gt.m
% ground_truth.m
% person4_move2_horz_cross_pcl.mat
% person4_move2_horz_cross_merged_skeleton.mat

% --------------------------------------------------------------
% DO NOT CHANGE THIS
bagfile = 'person4_move2_horz_cross';
load([bagfile, '_pcl.mat']);
load([bagfile, '_merged_skeleton.mat']);
% --------------------------------------------------------------
% --------------------------------------------------------------
% --------------------------------------------------------------

% Choose the frame or frames to show. 
% YOU CAN CHANGE THIS NUMBER (the maximum value is the length of mergedpcl, in this case 122)
frames = 122;

plot_skeleton_gt(bagfile, mergedpcl, best_rshoulder, best_relbow, best_lshoulder, best_lelbow, ...
    [], frames)


















% --------------------------------------------------------------
