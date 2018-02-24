function all_metrics = evaluation_all(thres, path_input, nkinects)
%{
    Calculate the evaluation metrics of all the experiments.

    Inputs:
    - thres: threshold accuracy error.
    - path_input: default path from where to read the bagfiles. Character.
    - nkinects: number of kinects. used for separate point clouds
    
    Returns:
    - all_metrics: structure with all the evaluation metrics for all the
    people and all the actions in all the experiments.

%}
% Set default threshold accuracy error
if nargin < 1 || isempty(thres)
     thres = 0.1;
end

% Set default input path
if nargin < 2 || isempty(path_input)
     path_input = 'D:/University of Edinburgh/Dissertation/data/final_results/skeletons/';
end

% Set default number of kinects
if nargin < 3 || isempty(nkinects)
     nkinects = 4;
end

% Name of the paths with the different experiments
paths = {'5 - n_particles_50 - move_noise_0_2', '6 - n_particles_50 - move_noise_0_1', ...
    '7 - n_particles_50 - move_noise_0_01', '8 - n_particles_10 - move_noise_0_2', ...
    '9 - n_particles_10 - move_noise_0_1', '10 - n_particles_10 - move_noise_0_01', ...
    '11 - n_particles_30 - move_noise_0_2', '12 - n_particles_30 - move_noise_0_1', ...
    '13 - n_particles_30 - move_noise_0_01', '14 - n_particles_50 - move_noise_0_3', ...
    '15 - n_particles_30 - move_noise_0_3', '16 - n_particles_10 - move_noise_0_3', ...
    '18 - n_particles_50 - move_noise_0_2 - separate'};

namepaths = {'n_particles_50_move_noise_0_2', 'n_particles_50_move_noise_0_1', ...
    'n_particles_50_move_noise_0_01', 'n_particles_10_move_noise_0_2', ...
    'n_particles_10_move_noise_0_1', 'n_particles_10_move_noise_0_01', ...
    'n_particles_30_move_noise_0_2', 'n_particles_30_move_noise_0_1', ...
    'n_particles_30_move_noise_0_01', 'n_particles_50_move_noise_0_3', ...
    'n_particles_30_move_noise_0_3', 'n_particles_10_move_noise_0_3', ...
    'n_particles_50_move_noise_0_2'};

% Calculate evaluation metrics on all experiments
all_metrics = struct();
for i = 1:length(paths)
    % Separate point clouds
    if contains(paths{i}, 'separate')
        for ki = 1:nkinects
            try
                all_metrics.(strcat(namepaths{i}, '_kinect_', num2str(ki))) = evaluation(thres, ...
                    [path_input, paths{i}, '/'], strcat('kinect_', num2str(ki)));
            catch ME
                fprintf('ERROR: %s\n', ME.message);
            end
        end
    % merged point clouds
    else
        all_metrics.(namepaths{i}) = evaluation(thres, [path_input, paths{i}, '/']);
    end
end








