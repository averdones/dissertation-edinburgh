
% List of bagfiles to read
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

% Create pcl for every bagfile
for i = 1:length(bagfiles)
    fprintf('Current bag: %s\n', bagfiles{i});
    try
        main_create_pcl(bagfiles{i});
    catch ME
        fprintf('ERROR: %s\n', ME.message);
    end
end

%% -------------------------------------------------------------------------------
% Tracking part

% Number of particles
n_particles = 50;

% Motion noise
move_noise = 0.2;

% Path output
path_output = 'D:/University of Edinburgh/Dissertation/data/final_results/skeletons/a19 - n_particles_30 - move_noise_1/';

for i = 1:length(bagfiles)
    bagfile = bagfiles{i}

    load(['D:/University of Edinburgh/Dissertation/data/final_results/point_clouds/', bagfile, '_pcl.mat']);

    if contains(bagfile,'person1_move6')
        mergedpcl = mergedpcl(27:end);
        for ki = 1:length(separatepcl)
            separatepcl{ki} = separatepcl{ki}(27:end);
        end        
    end
    if contains(bagfile,'person2_move6')
        mergedpcl = mergedpcl(23:end);
        for ki = 1:length(separatepcl)
            separatepcl{ki} = separatepcl{ki}(23:end);
        end    
    end
    if contains(bagfile,'person3_move6')
        mergedpcl = mergedpcl(25:end);
        for ki = 1:length(separatepcl)
            separatepcl{ki} = separatepcl{ki}(25:end);
        end    
    end
    if contains(bagfile,'person4_move6')
        mergedpcl = mergedpcl(20:end);
        for ki = 1:length(separatepcl)
            separatepcl{ki} = separatepcl{ki}(20:end);
        end    
    end
    if contains(bagfile,'person5_move6')
        mergedpcl = mergedpcl(35:end);
        for ki = 1:length(separatepcl)
            separatepcl{ki} = separatepcl{ki}(35:end);
        end    
    end
    
    if contains(bagfile,'person1')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-inf,0.42]);
        chest2rshoulder = [-0.03 -0.18 0.08]; % Translation vector to get the RIGHT shoulder from the chest
        chest2lshoulder = [-0.03 0.19 0.08]; % Translation vector to get the LEFT shoulder from the chest 
        uparm_dist = 0.27; % Bone length of upper arm
        loarm_dist = 0.27; % Bone length of forearm
    elseif contains(bagfile,'person2')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.05,0.38;-inf,0.49]);
        chest2rshoulder = [-0.08 -0.18 0.1];
        chest2lshoulder = [-0.08 0.19 0.1];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    elseif contains(bagfile,'person3')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;0,0.38;-inf,0.41]);
        chest2rshoulder = [-0.01 -0.20 0.06];
        chest2lshoulder = [0.0 0.15 0.06];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    elseif contains(bagfile,'person4')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.06,0.32;-inf,0.41]);
        chest2rshoulder = [-0.03 -0.16 0.08];
        chest2lshoulder = [-0.03 0.19 0.08];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    elseif contains(bagfile,'person5')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.09,0.27;-inf,0.39]);
        chest2rshoulder = [0.02 -0.13 0.02];
        chest2lshoulder = [0.02 0.14 0.02];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end
    if contains(bagfile,'person1_move5')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-inf,0.42]);
        chest2rshoulder = [0.02 -0.13 0.08];
        chest2lshoulder = [0.02 0.14 0.08];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end
    if contains(bagfile,'person3_move3')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-inf,0.42]);
        chest2rshoulder = [-0.03 -0.21 0.08];
        chest2lshoulder = [-0.03 0.10 0.08];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end
    if contains(bagfile,'person4_move5')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-inf,0.42]);
        chest2rshoulder = [-0.03 -0.15 0.08];
        chest2lshoulder = [-0.03 0.13 0.08];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end
    if contains(bagfile,'person1_move6')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.1,0.3;-0.02,0.42]);
        chest2rshoulder = [-0.03 -0.15 0.08];
        chest2lshoulder = [-0.03 0.13 0.08];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end
    if contains(bagfile,'person2_move6')
        indices = findPointsInROI(mergedpcl{1},[-inf,-0.95;-0.05,0.38;-0.1,0.49]);
        chest2rshoulder = [-0.08 -0.21 0.12];
        chest2lshoulder = [-0.08 0.16 0.12];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end
    if contains(bagfile,'person3_move6')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;0,0.38;0,0.41]);
        chest2rshoulder = [-0.01 -0.20 0.06];
        chest2lshoulder = [0.0 0.15 0.06];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end
    if contains(bagfile,'person4_move6')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.06,0.32;0,0.41]);
        chest2rshoulder = [-0.06 -0.17 0.08];
        chest2lshoulder = [-0.06 0.13 0.08];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end
    if contains(bagfile,'person5_move6')
        indices = findPointsInROI(mergedpcl{1},[-inf,inf;-0.18,0.22;-0.01,0.41]);
        chest2rshoulder = [0.0 -0.13 0.04];
        chest2lshoulder = [0.0 0.15 0.04];
        uparm_dist = 0.27;
        loarm_dist = 0.27;
    end

    pcChest = select(mergedpcl{1}, indices);
    centroid_chest = mean(pcChest.Location, 1);

    % -------------------------------------------------------------------------------
    % Particle filter
    try
        main_particle_filter(bagfiles{i}, mergedpcl, 'merged', centroid_chest, chest2rshoulder, ...
            chest2lshoulder, uparm_dist, loarm_dist, n_particles, move_noise, true, path_output)

%         for ki = 1:length(separatepcl)
%             main_particle_filter(bagfiles{i}, separatepcl{ki}, ['kinect_', num2str(ki)], ...
%                 centroid_chest, chest2rshoulder, chest2lshoulder, uparm_dist, loarm_dist)
%         end
    catch ME
        fprintf('ERROR: %s\n', ME.message);
    end
end


% -------------------------------------------------------------------------------
% Plot skeleton
path_input_skel = 'D:/University of Edinburgh/Dissertation/data/final_results/skeletons/5 - n_particles_50 - move_noise_0_2/';
path_output = 'D:/University of Edinburgh/Dissertation/data/final_results/skeleton_pictures/5 - n_particles_50 - move_noise_0_2/';
plot_all_skeletons([], path_input_skel, [], path_output);

bagfile = 'person1_move1_no_occlusion';
plot_skeleton_gt(bagfile, 'merged')


% -------------------------------------------------------------------------------
% Evaluation metrics
path = 'D:/University of Edinburgh/Dissertation/data/final_results/skeletons/5 - n_particles_50 - move_noise_0_2/';


all_metrics = evaluation([], path);

all_metrics.person2_move1_no_occlusion


all_metrics = evaluation_all();















