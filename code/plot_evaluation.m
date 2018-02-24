
% Colors
blue = [0 0.4470 0.7410];
red = [0.8500 0.3250 0.0980];
yellow = [0.9290 0.6940 0.1250];
purple = [0.4940 0.1840 0.5560];
green = [0.4660 0.6740 0.1880];
cyan = [0.3010 0.7450 0.9330];
magenta = [0.6350 0.0780 0.1840];

% Load metrics
all_metrics = evaluation_all(0.1);

% ----------------------------------------------------------------------------------
% Plot total accuracy 
acc = [];
for field = fieldnames(all_metrics)'
    suma = 0;
    for subfield = fieldnames(all_metrics.(field{1}))'
        suma = suma + all_metrics.(field{1}).(subfield{1}).acc_all;
    end
    acc = [acc suma / length(fieldnames(all_metrics.(field{1}))')];
end

x_part_50 = [0.01 0.1 0.2 0.3];
x_part_30 = [0.01 0.1 0.2 0.3];
x_part_10 = [0.01 0.1 0.2 0.3];

y_part_50 = acc([3 2 1 10]);
y_part_30 = acc([9 8 7 12]);
y_part_10 = acc([6 5 4 11]);

p50 = plot(x_part_50, y_part_50, '.-', 'MarkerSize', 20);
hold on
p30 = plot(x_part_30, y_part_30, '.-', 'MarkerSize', 20);
p10 = plot(x_part_10, y_part_10, '.-', 'MarkerSize', 20);

leg = legend([p50, p30, p10], '50 particles', '30 particles', '10 particles', ...
    'Location', 'southeast');
% ylim([0 1])
yticks(0:0.1:1)
xlabel('Motion model noise (radians)')
ylabel('Accuracy')
title({'Accuracy of experiments'; '{\fontsize{16}(threshold = 10cm)}'})
set(gca,'FontSize', 18)
grid on
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/accvsnoise','-dpng','-r200')


% ----------------------------------------------------------------------------------
% Plot total error 
acc = [];
for field = fieldnames(all_metrics)'
    suma = 0;
    for subfield = fieldnames(all_metrics.(field{1}))'
        suma = suma + all_metrics.(field{1}).(subfield{1}).mean_all;
    end
    acc = [acc suma / length(fieldnames(all_metrics.(field{1}))')];
end

x_part_50 = [0.01 0.1 0.2 0.3];
x_part_30 = [0.01 0.1 0.2 0.3];
x_part_10 = [0.01 0.1 0.2 0.3];

y_part_50 = acc([3 2 1 10]);
y_part_30 = acc([9 8 7 12]);
y_part_10 = acc([6 5 4 11]);

p50 = plot(x_part_50, y_part_50*1000, '.-', 'MarkerSize', 20);
hold on
p30 = plot(x_part_30, y_part_30*1000, '.-', 'MarkerSize', 20);
p10 = plot(x_part_10, y_part_10*1000, '.-', 'MarkerSize', 20);

leg = legend([p50, p30, p10], '50 particles', '30 particles', '10 particles', ...
    'Location', 'northeast');
yticks(50:25:200)

xlabel('Motion model noise (radians)')
ylabel('Average error (mm)')
title('Average error of experiments')
set(gca,'FontSize', 18)
grid on
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/errorvsnoise','-dpng','-r200')

% ----------------------------------------------------------------------------------
% Plot total missed rate 
acc = [];
for field = fieldnames(all_metrics)'
    suma = 0;
    for subfield = fieldnames(all_metrics.(field{1}))'
        suma = suma + all_metrics.(field{1}).(subfield{1}).miss_all;
    end
    acc = [acc suma / length(fieldnames(all_metrics.(field{1}))')];
end

x_part_50 = [0.01 0.1 0.2 0.3];
x_part_30 = [0.01 0.1 0.2 0.3];
x_part_10 = [0.01 0.1 0.2 0.3];


y_part_50 = acc([3 2 1 10]);
y_part_30 = acc([9 8 7 12]);
y_part_10 = acc([6 5 4 11]);


p50 = plot(x_part_50, y_part_50, '.-', 'MarkerSize', 20);
hold on
p30 = plot(x_part_30, y_part_30, '.-', 'MarkerSize', 20);
p10 = plot(x_part_10, y_part_10, '.-', 'MarkerSize', 20);

leg = legend([p50, p30, p10], '50 particles', '30 particles', '10 particles', ...
    'Location', 'northeast');
yticks(0:0.1:0.6)

xlabel('Motion model noise (radians)')
ylabel('Miss detection rate')
title('Miss detection rate of experiments')
set(gca,'FontSize', 18)
grid on
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/missrateexp','-dpng','-r200')

% ----------------------------------------------------------------------------------
% Plot change in accuracy threshold (one line)

th = 0:0.01:0.3;
acct = zeros(1, length(th));
for i = 1:length(th)
    all_metrics = evaluation_all(th(i));

    % Accuracy
    suma = 0;
    for field = fieldnames(all_metrics.n_particles_50_move_noise_0_2)'
        suma = suma + all_metrics.n_particles_50_move_noise_0_2.(field{1}).acc_all;
    end
    acct(i) = suma / length(fieldnames(all_metrics.n_particles_50_move_noise_0_2));
end

plot(th*1000, acct, '.-', 'MarkerSize', 20)
xlabel('Threshold (mm)')
ylabel('Accuracy')
% title('Accuracy vs Threshold')
title({'Accuracy vs Threshold';'{\fontsize{12}(50 particles, 0.2 noise})'})
set(gca,'FontSize', 14)

% ----------------------------------------------------------------------------------
% Plot change in accuracy threshold (all lines)
all_metrics = evaluation_all();
th = 0:0.01:0.3;
acc_all = zeros(length(fieldnames(all_metrics)), length(th));
for j = 1:length(th)
    all_metrics = evaluation_all(th(j));

    % Accuracy
    i = 0;
    for field = fieldnames(all_metrics)'
        suma = 0;
        i = i + 1;
        for subfield = fieldnames(all_metrics.(field{1}))'
            suma = suma + all_metrics.(field{1}).(subfield{1}).acc_all;
        end
        acc_all(i,j) = suma / length(fieldnames(all_metrics.(field{1})));
    end
end


fig = figure(1);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.4])
colors = {blue; blue; blue; red; red; red; yellow; yellow; yellow; blue; yellow; red};
lines = {'-', '--', ':', '-', '--', ':', '-', '--', ':', '-.', '-.', '-.'};
figure(1);
hold on
plots = [];
chosen_lines = 1:size(acc_all,1);
chosen_lines = [1 2 3 10]; % 50 particles
chosen_lines = [4 5 6 12]; % 10 particles
% chosen_lines = [7 8 9 11]; % 30 particles
% chosen_lines = [1 11 4]; % 30 particles
for i = chosen_lines
    plots = [plots, plot(th*1000, acc_all(i,:), lines{i}, 'Color', colors{i}, 'LineWidth', 2)];
end
% leg = legend([plots(1), plots(2), plots(3)], '50 particles', '30 particles', '10 particles', ...
%     'Location', 'southeast');
leg2 = legend([plots(4), plots(1), plots(2), plots(3)], '0.3', '0.2', '0.1', '0.01', ...
    'Location', 'southeast');
title(leg2, 'Motion noise')
% leg3 = legend([plots(1), plots(2), plots(3)], '50 particles - 0.2 noise', '30 particles - 0.3 noise', ...
%     '10 particles - 0.2 noise', 'Location', 'southeast');
% ax2 = axes('position', get(gca,'position'), 'visible', 'off');
% leg2 = legend(ax2, [plots(4), plots(2), plots(7)], '0.2 noise', '0.1 noise', '0.01 noise', ...
%     'Location', 'northwest');
xticks(0:50:300)
yticks(0:0.1:1)
xlabel('Threshold (mm)')
ylabel('Accuracy')
title({'Accuracy vs Threshold'; '(10 particles)'})
set(gca,'FontSize', 24)
grid on
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/accvsthres_10part','-dpng','-r200')


% ----------------------------------------------------------------------------------
% ----------------------------------------------------------------------------------
% Bars with average error and confidence intervals of one model
all_metrics = evaluation_all(0.1);

means = [];
cis = [];
for field = fieldnames(all_metrics.n_particles_50_move_noise_0_2)'
    means = [means; all_metrics.n_particles_50_move_noise_0_2.(field{1}).mean_all];
    cis = [cis; all_metrics.n_particles_50_move_noise_0_2.(field{1}).ci_all_2sd];
end

% Reshape to group person
means = reshape(means, 6, 5)';
cis = reshape(cis, 6, 5, 2);
cis = permute(cis, [2 1 3]);

fig = figure(1);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
barwitherr((cis(:,:,2)-means)*1000, means*1000)
xlabel('Subject Id')
ylabel('Error (mm)')
legend('Action 1', 'Action 2', 'Action 3', 'Action 4', 'Action 5', 'Action 6', ...
    'Location', 'bestoutside')
title({'Average Error of all Videos'; '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
set(gca,'FontSize', 24)
grid on
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/errorbest','-dpng','-r200')


% ----------------------------------------------------------------------------------
% Bars with accuracy of one model
all_metrics = evaluation_all(0.1);

means = [];
for field = fieldnames(all_metrics.n_particles_50_move_noise_0_2)'
    means = [means; all_metrics.n_particles_50_move_noise_0_2.(field{1}).acc_all];
end

% Reshape to group person
means = reshape(means, 6, 5)';

fig = figure(1);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
bar(means)
yticks(0:0.1:1)
xlabel('Subject Id')
ylabel('Accuracy')
legend('Action 1', 'Action 2', 'Action 3', 'Action 4', 'Action 5', 'Action 6', ...
    'Location', 'bestoutside')
set(gca,'FontSize', 24)
grid on
title({'Accuracy of all Videos'; '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/accbest','-dpng','-r200')


% ----------------------------------------------------------------------------------
% Accuracy per person and total
% Igual que y_part_50(3)
mean(means(:))

% Without bad actions
aux = means(:);
aux(aux < 0.7) = [];
mean(aux)

% ----------------------------------------------------------------------------------
% Wrist and elbows error
all_metrics = evaluation_all(0.1);

error_relbow = [];
error_rwrist = [];
error_lelbow = [];
error_lwrist = [];
ci_relbow = [];
ci_rwrist = [];
ci_lelbow = [];
ci_lwrist = [];
sd_relbow = [];
sd_rwrist = [];
sd_lelbow = [];
sd_lwrist = [];


for field = fieldnames(all_metrics.n_particles_50_move_noise_0_2)'
    error_relbow = [error_relbow; all_metrics.n_particles_50_move_noise_0_2.(field{1}).mean_relbow];
    error_rwrist = [error_rwrist; all_metrics.n_particles_50_move_noise_0_2.(field{1}).mean_rwrist];
    error_lelbow = [error_lelbow; all_metrics.n_particles_50_move_noise_0_2.(field{1}).mean_lelbow];
    error_lwrist = [error_lwrist; all_metrics.n_particles_50_move_noise_0_2.(field{1}).mean_lwrist];
    
    ci_relbow = [ci_relbow; all_metrics.n_particles_50_move_noise_0_2.(field{1}).ci_relbow_2sd];
    ci_rwrist = [ci_rwrist; all_metrics.n_particles_50_move_noise_0_2.(field{1}).ci_rwrist_2sd];
    ci_lelbow = [ci_lelbow; all_metrics.n_particles_50_move_noise_0_2.(field{1}).ci_lelbow_2sd];
    ci_lwrist = [ci_lwrist; all_metrics.n_particles_50_move_noise_0_2.(field{1}).ci_lwrist_2sd];
    
    sd_relbow = [sd_relbow; all_metrics.n_particles_50_move_noise_0_2.(field{1}).sd_relbow];
    sd_rwrist = [sd_rwrist; all_metrics.n_particles_50_move_noise_0_2.(field{1}).sd_rwrist];
    sd_lelbow = [sd_lelbow; all_metrics.n_particles_50_move_noise_0_2.(field{1}).sd_lelbow];
    sd_lwrist = [sd_lwrist; all_metrics.n_particles_50_move_noise_0_2.(field{1}).sd_lwrist];
end

mean_error_relbow = mean(error_relbow);
mean_error_rwrist = mean(error_rwrist);
mean_error_lelbow = mean(error_lelbow);
mean_error_lwrist = mean(error_lwrist);
means_error_all = [mean_error_lelbow; mean_error_lwrist; mean_error_relbow; mean_error_rwrist];

% Wrong
% mean_ci_relbow = mean(ci_relbow);
% mean_ci_rwrist = mean(ci_rwrist);
% mean_ci_lelbow = mean(ci_lelbow);
% mean_ci_lwrist = mean(ci_lwrist);
% means_ci_all = [mean_ci_lelbow; mean_ci_lwrist; mean_ci_relbow; mean_ci_rwrist];

sd_final_relbow = sqrt(mean(sd_relbow.^2));
sd_final_rwrist = sqrt(mean(sd_rwrist.^2));
sd_final_lelbow = sqrt(mean(sd_lelbow.^2));
sd_final_lwrist = sqrt(mean(sd_lwrist.^2));

ci_final_relbow = [mean_error_relbow - 2 * (sd_final_relbow / sqrt(length(error_relbow))), ...
    mean_error_relbow + 2 * (sd_final_relbow / sqrt(length(error_relbow)))];
ci_final_rwrist = [mean_error_rwrist - 2 * (sd_final_rwrist / sqrt(length(error_rwrist))), ...
    mean_error_rwrist + 2 * (sd_final_rwrist / sqrt(length(error_rwrist)))];
ci_final_lelbow = [mean_error_lelbow - 2 * (sd_final_lelbow / sqrt(length(error_lelbow))), ...
    mean_error_lelbow + 2 * (sd_final_lelbow / sqrt(length(error_lelbow)))];
ci_final_lwrist = [mean_error_lwrist - 2 * (sd_final_lwrist / sqrt(length(error_lwrist))), ...
    mean_error_lwrist + 2 * (sd_final_lwrist / sqrt(length(error_lwrist)))];
ci_final_all = [ci_final_lelbow; ci_final_lwrist; ci_final_relbow; ci_final_rwrist];

% X-axis values
x_cat = categorical({'Left elbow', 'Left wrist', 'Right elbow', 'Right wrist'});

% Plot graph
fig = figure(2);
ax = axes('parent', fig);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
hold(ax, 'on')
colors = parula(numel(means_error_all));
for i = 1:numel(means_error_all)
    bar(x_cat(i), means_error_all(i)*1000, 'parent', ax, 'facecolor', colors(i,:));
end
set(gca,'FontSize', 24)
grid on
xlabel('Joint')
ylabel('Error (mm)')
title({'Average error of joints'; '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
e = errorbar(x_cat, means_error_all*1000, (ci_final_all(:,2)-means_error_all)*1000, '.k');
e.CapSize = 25;
e.LineWidth = 3;
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/error_joints','-dpng','-r200')


% ----------------------------------------------------------------------------------
% Wrist and elbows accuracy
all_metrics = evaluation_all(0.1);

acc_relbow = [];
acc_rwrist = [];
acc_lelbow = [];
acc_lwrist = [];

for field = fieldnames(all_metrics.n_particles_50_move_noise_0_2)'
    acc_relbow = [acc_relbow; all_metrics.n_particles_50_move_noise_0_2.(field{1}).acc_relbow];
    acc_rwrist = [acc_rwrist; all_metrics.n_particles_50_move_noise_0_2.(field{1}).acc_rwrist];
    acc_lelbow = [acc_lelbow; all_metrics.n_particles_50_move_noise_0_2.(field{1}).acc_lelbow];
    acc_lwrist = [acc_lwrist; all_metrics.n_particles_50_move_noise_0_2.(field{1}).acc_lwrist];
end

mean_acc_relbow = mean(acc_relbow);
mean_acc_rwrist = mean(acc_rwrist);
mean_acc_lelbow = mean(acc_lelbow);
mean_acc_lwrist = mean(acc_lwrist);
means_acc_all = [mean_acc_lelbow mean_acc_lwrist mean_acc_relbow mean_acc_rwrist];

% X-axis values
x_cat = categorical({'Left elbow', 'Left wrist', 'Right elbow', 'Right wrist'});

% Plot graph
fig = figure(1);
ax = axes('parent', fig);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
hold(ax, 'on')
colors = parula(numel(means_acc_all));
for i = 1:numel(means_acc_all)
    bar(x_cat(i), means_acc_all(i), 'parent', ax, 'facecolor', colors(i,:));
end
ylim([0.5 1])
set(gca,'FontSize', 24)
grid on
xlabel('Joint')
ylabel('Accuracy')
title({'Accuracy of joints'; '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/acc_joints','-dpng','-r200')


% ----------------------------------------------------------------------------------
% ----------------------------------------------------------------------------------
% ----------------------------------------------------------------------------------
% Merged vs separate point clouds error
all_metrics = evaluation_all(0.1);

% Plot total accuracy 
error = [];
sd = [];
ci = [];

for field = fieldnames(all_metrics)'
    suma = 0;
    suma_sd = 0;
    for subfield = fieldnames(all_metrics.(field{1}))'
        suma = suma + all_metrics.(field{1}).(subfield{1}).mean_all;
        suma_sd = suma_sd + (all_metrics.(field{1}).(subfield{1}).sd_all).^2;
    end
    error = [error; suma / length(fieldnames(all_metrics.(field{1}))')];
    sd = [sd; sqrt(suma_sd / length(fieldnames(all_metrics.(field{1}))'))];
    ci = [ci; suma / length(fieldnames(all_metrics.(field{1}))') - ...
        2 * (sqrt(suma_sd / length(fieldnames(all_metrics.(field{1}))')) / ...
        length(fieldnames(all_metrics.(field{1}))')), ...
        suma / length(fieldnames(all_metrics.(field{1}))') + ...
        2 * (sqrt(suma_sd / length(fieldnames(all_metrics.(field{1}))')) / ...
        length(fieldnames(all_metrics.(field{1}))'))];
end

% Select only the merged and separate 50 particles and 0.2 motion noise
error = error([1 13 14 15 16]);
sd = sd([1 13 14 15 16]);
ci = ci([1 13 14 15 16],:);

% X-axis values
x_cat = categorical({'Merged', 'Kinect 1', 'Kinect 2', 'Kinect 3', 'Kinect 4'});

fig = figure(1);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
bar(x_cat, error*1000);
hold on
e = errorbar(x_cat, error*1000, (ci(:,2)-error)*1000,'.k');
e.CapSize = 25;
e.LineWidth = 3;
grid on
xlabel('Point cloud source')
ylabel('Error (mm)')
title({'Error of merged vs separate point clouds'; '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
set(gca,'FontSize', 24)
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/error_merged_vs_separate','-dpng','-r200')


% ----------------------------------------------------------------------------------
% Merged vs separate point clouds accuracy
all_metrics = evaluation_all(0.1);

% Plot total accuracy 
acc = [];
for field = fieldnames(all_metrics)'
    suma = 0;
    for subfield = fieldnames(all_metrics.(field{1}))'
        suma = suma + all_metrics.(field{1}).(subfield{1}).acc_all;
    end
    acc = [acc suma / length(fieldnames(all_metrics.(field{1}))')];
end

acc = acc([1 13 14 15 16]);

% X-axis values
x_cat = categorical({'Merged', 'Kinect 1', 'Kinect 2', 'Kinect 3', 'Kinect 4'});

fig = figure(1);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
bar(x_cat, acc);
grid on
xlabel('Point cloud source')
ylabel('Accuracy')
title({'Accuracy of merged vs separate point clouds'; '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
ylim([0.5 1])
set(gca,'FontSize', 24)
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/acc_merged_vs_separate','-dpng','-r200')

% ----------------------------------------------------------------------------------
% Missed rate separate point clouds
all_metrics = evaluation_all(0.1);

miss = [];
for field = fieldnames(all_metrics)'
    suma = 0;
    for subfield = fieldnames(all_metrics.(field{1}))'
        suma = suma + all_metrics.(field{1}).(subfield{1}).miss_all;
    end
    miss = [miss suma / length(fieldnames(all_metrics.(field{1}))')];
end

miss = miss([1 13 14 15 16]);

% X-axis values
x_cat = categorical({'Merged', 'Kinect 1', 'Kinect 2', 'Kinect 3', 'Kinect 4'});

fig = figure(1);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
colors = parula(4);
colors = colors(2,:);
bar(x_cat, miss, 'FaceColor', colors);
grid on
xlabel('Point cloud source')
ylabel('Miss detection rate')
title({'Miss detection rate of merged vs separate pcls'; '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
set(gca,'FontSize', 24)
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/missrate_separate','-dpng','-r200')

% ----------------------------------------------------------------------------------
% Kinect 1, 2, 3, 4 error
all_metrics = evaluation_all(0.1);

error = [];
cis = [];
ki = 4;
for field = fieldnames(eval(strcat('all_metrics.n_particles_50_move_noise_0_2_kinect_' , ...
        num2str(ki))))'
    error = [error; eval(strcat('all_metrics.n_particles_50_move_noise_0_2_kinect_' , ...
        num2str(ki),'.(field{1}).mean_all'))];
    cis = [cis; eval(strcat('all_metrics.n_particles_50_move_noise_0_2_kinect_' , ...
        num2str(ki),'.(field{1}).ci_all_2sd'))];
end

% Reshape to group person
error = reshape(error, 6, 5)';
cis = reshape(cis, 6, 5, 2);
cis = permute(cis, [2 1 3]);

fig = figure(ki);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
barwitherr((cis(:,:,2)-error)*1000, error*1000)
yticks(0:50:350)
xlabel('Subject Id')
ylabel('Error (mm)')
legend('Action 1', 'Action 2', 'Action 3', 'Action 4', 'Action 5', 'Action 6', ...
    'Location', 'bestoutside')
set(gca,'FontSize', 24)
grid on
title({'Average error of all Videos'; 'using point clouds from Kinect 4'; ...
    '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/errorbest_ki4','-dpng','-r200')


% ----------------------------------------------------------------------------------
% Kinect 1, 2, 3, 4 accuracy
all_metrics = evaluation_all(0.1);

means = [];
ki = 4;
for field = fieldnames(eval(strcat('all_metrics.n_particles_50_move_noise_0_2_kinect_' , ...
        num2str(ki))))'
    means = [means; eval(strcat('all_metrics.n_particles_50_move_noise_0_2_kinect_' , ...
        num2str(ki),'.(field{1}).acc_all'))];
end

% Reshape to group person
means = reshape(means, 6, 5)';

fig = figure(ki);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
bar(means)
yticks(0:0.1:1)
xlabel('Subject Id')
ylabel('Accuracy')
legend('Action 1', 'Action 2', 'Action 3', 'Action 4', 'Action 5', 'Action 6', ...
    'Location', 'bestoutside')
set(gca,'FontSize', 24)
grid on
title({'Accuracy of all Videos'; 'using point clouds from Kinect 4'; ...
    '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/accbest_ki4','-dpng','-r200')


% ----------------------------------------------------------------------------------
% Wrist and elbows error separate point clouds
all_metrics = evaluation_all(0.1);

error_relbow = [];
error_rwrist = [];
error_lelbow = [];
error_lwrist = [];
ci_relbow = [];
ci_rwrist = [];
ci_lelbow = [];
ci_lwrist = [];
sd_relbow = [];
sd_rwrist = [];
sd_lelbow = [];
sd_lwrist = [];


for field = fieldnames(all_metrics.n_particles_50_move_noise_0_2)'
    error_relbow = [error_relbow; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).mean_relbow];
    error_rwrist = [error_rwrist; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).mean_rwrist];
    error_lelbow = [error_lelbow; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).mean_lelbow];
    error_lwrist = [error_lwrist; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).mean_lwrist];
    
    ci_relbow = [ci_relbow; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).ci_relbow_2sd];
    ci_rwrist = [ci_rwrist; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).ci_rwrist_2sd];
    ci_lelbow = [ci_lelbow; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).ci_lelbow_2sd];
    ci_lwrist = [ci_lwrist; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).ci_lwrist_2sd];
    
    sd_relbow = [sd_relbow; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).sd_relbow];
    sd_rwrist = [sd_rwrist; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).sd_rwrist];
    sd_lelbow = [sd_lelbow; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).sd_lelbow];
    sd_lwrist = [sd_lwrist; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).sd_lwrist];
end

mean_error_relbow = nanmean(error_relbow);
mean_error_rwrist = nanmean(error_rwrist);
mean_error_lelbow = nanmean(error_lelbow);
mean_error_lwrist = nanmean(error_lwrist);
means_error_all = [mean_error_lelbow; mean_error_lwrist; mean_error_relbow; mean_error_rwrist];

% Wrong
% mean_ci_relbow = mean(ci_relbow);
% mean_ci_rwrist = mean(ci_rwrist);
% mean_ci_lelbow = mean(ci_lelbow);
% mean_ci_lwrist = mean(ci_lwrist);
% means_ci_all = [mean_ci_lelbow; mean_ci_lwrist; mean_ci_relbow; mean_ci_rwrist];

sd_final_relbow = sqrt(nanmean(sd_relbow.^2));
sd_final_rwrist = sqrt(nanmean(sd_rwrist.^2));
sd_final_lelbow = sqrt(nanmean(sd_lelbow.^2));
sd_final_lwrist = sqrt(nanmean(sd_lwrist.^2));

ci_final_relbow = [mean_error_relbow - 2 * (sd_final_relbow / sqrt(length(error_relbow))), ...
    mean_error_relbow + 2 * (sd_final_relbow / sqrt(length(error_relbow)))];
ci_final_rwrist = [mean_error_rwrist - 2 * (sd_final_rwrist / sqrt(length(error_rwrist))), ...
    mean_error_rwrist + 2 * (sd_final_rwrist / sqrt(length(error_rwrist)))];
ci_final_lelbow = [mean_error_lelbow - 2 * (sd_final_lelbow / sqrt(length(error_lelbow))), ...
    mean_error_lelbow + 2 * (sd_final_lelbow / sqrt(length(error_lelbow)))];
ci_final_lwrist = [mean_error_lwrist - 2 * (sd_final_lwrist / sqrt(length(error_lwrist))), ...
    mean_error_lwrist + 2 * (sd_final_lwrist / sqrt(length(error_lwrist)))];
ci_final_all = [ci_final_lelbow; ci_final_lwrist; ci_final_relbow; ci_final_rwrist];

% X-axis values
x_cat = categorical({'Left elbow', 'Left wrist', 'Right elbow', 'Right wrist'});

% Plot graph
fig = figure(2);
ax = axes('parent', fig);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
hold(ax, 'on')
colors = parula(numel(means_error_all));
for i = 1:numel(means_error_all)
    bar(x_cat(i), means_error_all(i)*1000, 'parent', ax, 'facecolor', colors(i,:));
end
set(gca,'FontSize', 24)
grid on
xlabel('Joint')
ylabel('Error (mm)')
title({'Average error of joints'; 'using point clouds from Kinect 4';...
    '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
e = errorbar(x_cat, means_error_all*1000, (ci_final_all(:,2)-means_error_all)*1000, '.k');
e.CapSize = 25;
e.LineWidth = 3;
print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/error_joints_ki4','-dpng','-r200')

% ----------------------------------------------------------------------------------
% Wrist and elbows accuracy separate point clouds
all_metrics = evaluation_all(0.1);

acc_relbow = [];
acc_rwrist = [];
acc_lelbow = [];
acc_lwrist = [];

for field = fieldnames(all_metrics.n_particles_50_move_noise_0_2)'
    acc_relbow = [acc_relbow; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).acc_relbow];
    acc_rwrist = [acc_rwrist; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).acc_rwrist];
    acc_lelbow = [acc_lelbow; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).acc_lelbow];
    acc_lwrist = [acc_lwrist; all_metrics.n_particles_50_move_noise_0_2_kinect_4.(field{1}).acc_lwrist];
end

mean_acc_relbow = nanmean(acc_relbow);
mean_acc_rwrist = nanmean(acc_rwrist);
mean_acc_lelbow = nanmean(acc_lelbow);
mean_acc_lwrist = nanmean(acc_lwrist);
means_acc_all = [mean_acc_lelbow mean_acc_lwrist mean_acc_relbow mean_acc_rwrist];

% X-axis values
x_cat = categorical({'Left elbow', 'Left wrist', 'Right elbow', 'Right wrist'});

% Plot graph
fig = figure(1);
ax = axes('parent', fig);
pos = get(fig,'position');
set(fig,'position',[pos(1:2)/2 pos(3:4)*1.5])
hold(ax, 'on')
colors = parula(numel(means_acc_all));
for i = 1:numel(means_acc_all)
    bar(x_cat(i), means_acc_all(i), 'parent', ax, 'facecolor', colors(i,:));
end
set(gca,'FontSize', 24)
grid on
yticks(0:0.1:1)
xlabel('Joint')
ylabel('Accuracy')
title({'Accuracy of joints'; 'using point clouds from Kinect 4';...
    '{\fontsize{20}(50 particles - 0.2 motion noise)}'})
% print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/acc_joints_ki4','-dpng','-r200')


% ----------------------------------------------------------------------------------
% Histogram of wrist and elbows errors
all_metrics = evaluation_all(0.1);

error_relbow = [];
error_rwrist = [];
error_lelbow = [];
error_lwrist = [];
error = [];


for field = fieldnames(all_metrics.n_particles_50_move_noise_0_2)'
    error_relbow = [error_relbow all_metrics.n_particles_50_move_noise_0_2.(field{1}).all_error_relbow];
    error_rwrist = [error_rwrist all_metrics.n_particles_50_move_noise_0_2.(field{1}).all_error_rwrist];
    error_lelbow = [error_lelbow all_metrics.n_particles_50_move_noise_0_2.(field{1}).all_error_lelbow];
    error_lwrist = [error_lwrist all_metrics.n_particles_50_move_noise_0_2.(field{1}).all_error_lwrist];
    error = [error all_metrics.n_particles_50_move_noise_0_2.(field{1}).all_error_all]; 
end

colors = parula(4);

histogram(error_lelbow*1000, 'BinMethod', 'fd', 'FaceColor', colors(1,:))
xlabel('Error (mm)')
ylabel('Frequency')
title({'Histogram of errors'; 'Left elbow'; '{\fontsize{16}(50 particles - 0.2 motion noise)}'})
grid on
set(gca,'FontSize', 18)
print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/hist_errors_lelbow','-dpng','-r200')

histogram(error_lwrist*1000, 'BinMethod', 'fd', 'FaceColor', colors(2,:))
xlabel('Error (mm)')
ylabel('Frequency')
title({'Histogram of errors'; 'Left wrist'; '{\fontsize{16}(50 particles - 0.2 motion noise)}'})
grid on
set(gca,'FontSize', 18)
xticks(0:100:600)
print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/hist_errors_lwrist','-dpng','-r200')

histogram(error_relbow*1000, 'BinMethod', 'fd', 'FaceColor', colors(3,:))
xlabel('Error (mm)')
ylabel('Frequency')
title({'Histogram of errors'; 'Right elbow'; '{\fontsize{16}(50 particles - 0.2 motion noise)}'})
grid on
set(gca,'FontSize', 18)
print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/hist_errors_relbow','-dpng','-r200')

histogram(error_rwrist*1000, 'BinMethod', 'fd', 'FaceColor', colors(4,:))
xlabel('Error (mm)')
ylabel('Frequency')
title({'Histogram of errors'; 'Right wrist'; '{\fontsize{16}(50 particles - 0.2 motion noise)}'})
grid on
set(gca,'FontSize', 18)
print('D:/Google Drive/University of Edinburgh/Courses/Dissertation/Plots/hist_errors_rwrist','-dpng','-r200')











