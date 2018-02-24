function all_metrics = evaluation(thres, path_input, whichpcl)
%{
    Calculate the evaluation metrics of the experiments.

    Inputs:
    - thres: threshold accuracy error (meters).
    - path_input: default path from where to read the bagfiles. Character.
    - whichpcl: character choosing the pcl selected. Merged or separate.
    
    Returns:
    - all_metrics: structure with all the evaluation metrics for all the
    people and all the actions.

%}

% Set default threshold accuracy error
if nargin < 1 || isempty(thres)
     thres = 0.1;
end

% Set default input path
if nargin < 2 || isempty(path_input)
     path_input = 'D:/University of Edinburgh/Dissertation/data/final_results/skeletons/';
end

% Set default pcl
if nargin < 3 || isempty(whichpcl)
     whichpcl = 'merged';
end

% Call to the ground truth
ground_truth

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

% Create final structure with all evaluation metrics
all_metrics = struct();

% Loop through the bagfiles
for i = 1:length(bagfiles)
    % Load the particle filters results
    load([path_input, bagfiles{i}, '_' , whichpcl, '_skeleton.mat']);

    % Load the ground truth
    gt_relbow = eval([bagfiles{i}, '_relbow']);
    gt_rwrist = eval([bagfiles{i}, '_rwrist']);
    gt_lelbow = eval([bagfiles{i}, '_lelbow']);
    gt_lwrist = eval([bagfiles{i}, '_lwrist']);
    
    % Join all joints together
    gt_all = [gt_relbow gt_rwrist gt_lelbow gt_lwrist];
    best_all = [best_rshoulder best_relbow best_lshoulder best_lelbow];
    
    % Calculate error distances
    dist_relbow = sqrt(sum((gt_relbow - best_rshoulder).^2));
    dist_rwrist = sqrt(sum((gt_rwrist - best_relbow).^2));
    dist_lelbow = sqrt(sum((gt_lelbow - best_lshoulder).^2));
    dist_lwrist = sqrt(sum((gt_lwrist - best_lelbow).^2));
    dist_all = sqrt(sum((gt_all - best_all).^2));
    
    % Calcualte distances withouth nans
    dist_relbow_nonan = dist_relbow(find(~isnan(dist_relbow)));
    dist_rwrist_nonan = dist_rwrist(find(~isnan(dist_rwrist)));
    dist_lelbow_nonan = dist_lelbow(find(~isnan(dist_lelbow)));
    dist_lwrist_nonan = dist_lwrist(find(~isnan(dist_lwrist)));
    dist_all_nonan = dist_all(find(~isnan(dist_all)));
    
    % Calculate mean error distances
    mean_relbow = nanmean(dist_relbow);
    mean_rwrist = nanmean(dist_rwrist);
    mean_lelbow = nanmean(dist_lelbow);
    mean_lwrist = nanmean(dist_lwrist);
    mean_all = nanmean(dist_all);
    
    % Calculate standard deviation error distances
    sd_relbow = nanstd(dist_relbow);
    sd_rwrist = nanstd(dist_rwrist);
    sd_lelbow = nanstd(dist_lelbow);
    sd_lwrist = nanstd(dist_lwrist);
    sd_all = nanstd(dist_all);

    % Calculate confidence intervals 1 standard deviation
    ci_relbow_1sd = [mean_relbow - 1*(sd_relbow/sqrt(length(dist_relbow_nonan))), ...
        mean_relbow + 1*(sd_relbow/sqrt(length(dist_relbow_nonan)))];
    ci_rwrist_1sd = [mean_rwrist - 1*(sd_rwrist/sqrt(length(dist_rwrist_nonan))), ...
        mean_rwrist + 1*(sd_rwrist/sqrt(length(dist_rwrist_nonan)))];
    ci_lelbow_1sd = [mean_lelbow - 1*(sd_lelbow/sqrt(length(dist_lelbow_nonan))), ...
        mean_lelbow + 1*(sd_lelbow/sqrt(length(dist_lelbow_nonan)))];
    ci_lwrist_1sd = [mean_lwrist - 1*(sd_lwrist/sqrt(length(dist_lwrist_nonan))), ...
        mean_lwrist + 1*(sd_lwrist/sqrt(length(dist_lwrist_nonan)))];
    ci_all_1sd = [mean_all - 1*(sd_all/sqrt(length(dist_all_nonan))), ...
        mean_all + 1*(sd_all/sqrt(length(dist_all_nonan)))];
    % Assure non-negative numbers
    ci_relbow_1sd(ci_relbow_1sd<0) = 0;
    ci_rwrist_1sd(ci_rwrist_1sd<0) = 0;
    ci_lelbow_1sd(ci_lelbow_1sd<0) = 0;
    ci_lwrist_1sd(ci_lwrist_1sd<0) = 0;
    ci_all_1sd(ci_all_1sd<0) = 0;    
    
    % Calculate confidence intervals 2 standard deviations
    ci_relbow_2sd = [mean_relbow - 2*(sd_relbow/sqrt(length(dist_relbow_nonan))), ...
        mean_relbow + 2*(sd_relbow/sqrt(length(dist_relbow_nonan)))];
    ci_rwrist_2sd = [mean_rwrist - 2*(sd_rwrist/sqrt(length(dist_rwrist_nonan))), ...
        mean_rwrist + 2*(sd_rwrist/sqrt(length(dist_rwrist_nonan)))];
    ci_lelbow_2sd = [mean_lelbow - 2*(sd_lelbow/sqrt(length(dist_lelbow_nonan))), ...
        mean_lelbow + 2*(sd_lelbow/sqrt(length(dist_lelbow_nonan)))];
    ci_lwrist_2sd = [mean_lwrist - 2*(sd_lwrist/sqrt(length(dist_lwrist_nonan))), ...
        mean_lwrist + 2*(sd_lwrist/sqrt(length(dist_lwrist_nonan)))];
    ci_all_2sd = [mean_all - 2*(sd_all/sqrt(length(dist_all_nonan))), ...
        mean_all + 2*(sd_all/sqrt(length(dist_all_nonan)))];
    % Assure non-negative numbers
    ci_relbow_2sd(ci_relbow_2sd<0) = 0;
    ci_rwrist_2sd(ci_rwrist_2sd<0) = 0;
    ci_lelbow_2sd(ci_lelbow_2sd<0) = 0;
    ci_lwrist_2sd(ci_lwrist_2sd<0) = 0;
    ci_all_2sd(ci_all_2sd<0) = 0; 
    
    % Calculate accuracy error distances within a threshold
    acc_relbow = sum(dist_relbow_nonan < thres) / length(dist_relbow_nonan);
    acc_rwrist = sum(dist_rwrist_nonan < thres) / length(dist_rwrist_nonan);
    acc_lelbow = sum(dist_lelbow_nonan < thres) / length(dist_lelbow_nonan);
    acc_lwrist = sum(dist_lwrist_nonan < thres) / length(dist_lwrist_nonan);
    acc_all = sum(dist_all_nonan < thres) / length(dist_all_nonan);
    
    % Calculate missed and false detection rate
    miss_relbow = 0;
    miss_rwrist = 0;
    miss_lelbow = 0;
    miss_lwrist = 0;
      
    false_relbow = 0;
    false_rwrist = 0;
    false_lelbow = 0;
    false_lwrist = 0;
    
    valid_frames = 11:10:size(gt_relbow, 2);
    
    for d = valid_frames
        % Missed detection rate
        if ~isnan(gt_relbow(1,d)) && isnan(best_rshoulder(1,d))
            miss_relbow = miss_relbow + 1;
        end
        if ~isnan(gt_rwrist(1,d)) && isnan(best_relbow(1,d))
            miss_rwrist = miss_rwrist + 1;
        end
        if ~isnan(gt_lelbow(1,d)) && isnan(best_lshoulder(1,d))
            miss_lelbow = miss_lelbow + 1;
        end
        if ~isnan(gt_lwrist(1,d)) && isnan(best_lelbow(1,d))
            miss_rwrist = miss_rwrist + 1;
        end
        % False detection rate
        if isnan(gt_relbow(1,d)) && ~isnan(best_rshoulder(1,d))
            false_relbow = false_relbow + 1;
        end
        if isnan(gt_rwrist(1,d)) && ~isnan(best_relbow(1,d))
            false_rwrist = false_rwrist + 1;
        end
        if isnan(gt_lelbow(1,d)) && ~isnan(best_lshoulder(1,d))
            false_lelbow = false_lelbow + 1;
        end
        if isnan(gt_lwrist(1,d)) && ~isnan(best_lelbow(1,d))
            false_rwrist = false_rwrist + 1;
        end
    end
    
    miss_relbow = miss_relbow / length(valid_frames);
    miss_rwrist = miss_rwrist / length(valid_frames);
    miss_lelbow = miss_lelbow / length(valid_frames);
    miss_lwrist = miss_lwrist / length(valid_frames);
    miss_all = mean([miss_relbow miss_rwrist miss_lelbow miss_lwrist]);
    
    false_relbow = false_relbow / length(valid_frames);
    false_rwrist = false_rwrist / length(valid_frames);
    false_lelbow = false_lelbow / length(valid_frames);
    false_lwrist = false_lwrist / length(valid_frames);
    false_all = mean([false_relbow false_rwrist false_lelbow false_lwrist]);
    
    % Create structure with all metrics to save
    metrics = struct('mean_relbow', mean_relbow, 'mean_rwrist', mean_rwrist, ...
        'mean_lelbow', mean_lelbow, 'mean_lwrist', mean_lwrist, 'mean_all', mean_all, ...
        'sd_relbow', sd_relbow, 'sd_rwrist', sd_rwrist, 'sd_lelbow', sd_lelbow, ...
        'sd_lwrist', sd_lwrist, 'sd_all', sd_all, 'ci_relbow_1sd', ci_relbow_1sd, ...
        'ci_rwrist_1sd', ci_rwrist_1sd, 'ci_lelbow_1sd', ci_lelbow_1sd, ...
        'ci_lwrist_1sd', ci_lwrist_1sd, 'ci_all_1sd', ci_all_1sd, ...
        'ci_relbow_2sd', ci_relbow_2sd, 'ci_rwrist_2sd', ci_rwrist_2sd, ...
        'ci_lelbow_2sd', ci_lelbow_2sd, 'ci_lwrist_2sd', ci_lwrist_2sd, ...
        'ci_all_2sd', ci_all_2sd, 'acc_relbow', acc_relbow, 'acc_rwrist', acc_rwrist, ...
        'acc_lelbow', acc_lelbow, 'acc_lwrist', acc_lwrist, 'acc_all', acc_all, ...
        'miss_relbow', miss_relbow, 'miss_rwrist', miss_rwrist, 'miss_lelbow', miss_lelbow, ...
        'miss_lwrist', miss_lwrist, 'miss_all', miss_all, 'false_relbow', false_relbow, ...
        'false_rwrist', false_rwrist, 'false_lelbow', false_lelbow, 'false_lwrist', false_lwrist, ...
        'false_all', false_all, 'all_error_relbow', dist_relbow_nonan, ...
        'all_error_rwrist', dist_rwrist_nonan, 'all_error_lelbow', dist_lelbow_nonan, ...
        'all_error_lwrist', dist_lwrist_nonan, 'all_error_all', dist_all_nonan);
    
    % Add metrics to the final structure
    all_metrics.(bagfiles{i}) = metrics;
end












