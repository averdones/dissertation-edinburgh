
path_output = 'D:/University of Edinburgh/Dissertation/data/video/';
bagfile = 'person5_move5_arms_together';

% -----------------------------------------------------------------------------------
% Point clouds
load(['D:/University of Edinburgh/Dissertation/data/final_results/point_clouds/', bagfile, '_pcl.mat']);
load(['D:/University of Edinburgh/Dissertation/data/final_results/skeletons/5 - n_particles_50 - move_noise_0_2/',...
    bagfile, '_merged_skeleton.mat']);

% Center pcl
% for ii = 1:length(mergedpcl)
%     xyz = mergedpcl{ii}.Location - centroid_chest;
%     rgb = mergedpcl{ii}.Color;
%     mergedpcl{ii} = pointCloud(xyz,'Color',rgb);
% end
% best_rshoulder = best_rshoulder - centroid_chest';
% best_relbow = best_relbow - centroid_chest';
% best_lshoulder = best_lshoulder - centroid_chest';
% best_lelbow = best_lelbow - centroid_chest';

path_output_pcl = [path_output, 'pcl/'];

az_view_inf = 60;
az_view_sup = 120;
el_view_inf = 10;
el_view_sup = 50;
frames = 1:length(mergedpcl);
% frames = frames(35:end);
% frames = 60:61;
az_view = linspace(az_view_inf, az_view_sup, length(frames));
el_view = linspace(el_view_inf, el_view_sup, length(frames));


for fr = 1:length(frames)
    plot_skeleton_gt(bagfile, mergedpcl, best_rshoulder, best_relbow, best_lshoulder, best_lelbow, ...
        path_output_pcl, frames(fr), true, true, false, false, [], false, true, 'video1_pcl_', 'pcshow', ...
        az_view(fr), el_view(fr), 0.4)
end


% -----------------------------------------------------------------------------------
% Color images
bag = rosbag(['D:/University of Edinburgh/Dissertation/data/bags/', bagfile, '.bag']);
path_output_col = [path_output, 'color/'];
path_output_dep = [path_output, 'depth/'];


for ki = 1:4
    imgs = readMessages(select(bag,'topic',sprintf('/kinect_%d/sd/image_color_rect',ki)));
    dmaps = readMessages(select(bag,'topic',sprintf('/kinect_%d/sd/image_depth_rect',ki)));

    for fr = 1:length(frames)
        cam = readImage(imgs{frames(fr)});
        dm = readImage(dmaps{frames(fr)});
        
        imwrite((cam), [path_output_col, 'color_ki', num2str(ki), 'fr_', num2str(fr), '.png'])
        
        set(gcf,'Visible','off');
        imagesc(dm)
        print([path_output_dep, 'depth_ki', num2str(ki), 'fr_', num2str(fr)],'-dpng')
%         imwrite(double(dm), parula(255), [path_output_dep, 'depth_ki', num2str(ki), 'fr_', num2str(fr), '.png'])
    end
end







