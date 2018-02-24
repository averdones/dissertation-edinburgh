% bagfile = 'person5_move1_no_occlusion';
% load(['D:/University of Edinburgh/Dissertation/data/final_results/point_clouds/', bagfile, '_pcl.mat']);
% mergedpcl = mergedpcl(35:end);
% 
% pcshow(mergedpcl{21})
% xlabel('X');ylabel('Y');zlabel('Z');
% grid minor
% view(0,90)
% view(-90,0)
% view(0,0)
% view(180,0)
% view(90,0)

% ------------------------------------------------------------------------------------------
% Person1_move1_no_occlusion
p1m1_ind = 1:10:118;
person1_move1_no_occlusion_relbow = nan(3, 118);
person1_move1_no_occlusion_rwrist = nan(3, 118);
person1_move1_no_occlusion_lelbow = nan(3, 118);
person1_move1_no_occlusion_lwrist = nan(3, 118);

p1m1_relbow_manual = [-1.085 -0.36 0.39; -1.08 -0.36 0.39; -1.1 -0.3 0.21; -1.06 -0.31 0.2; ...
    -1.02 -0.34 0.15; -1.01 -0.28 0.2; -0.92 -0.26 0.29; -0.93 -0.21 0.24; -0.94 -0.21 0.24; ...
    -0.96 -0.24 0.28; -0.98 -0.25 0.2; -1 -0.3 0.18]';

p1m1_rwrist_manual = [-0.82 -0.36 0.39; -0.85 -0.37 0.39; -0.9 -0.42 0.3; -0.92 -0.46 0.24; ...
    -0.9 -0.46 0.22; -0.82 -0.34 0.33; -0.75 -0.2 0.35; -0.73 -0.1 0.31; -0.72 -0.13 0.34; ...
    -0.79 -0.22 0.37; -0.84 -0.32 0.36; -0.88 -0.4 0.26]';

p1m1_lelbow_manual = [-1.09 0.56 0.39; -1.05 0.55 0.39; -0.90 0.44 0.40; -0.86 0.37 0.41; ...
    -0.87 0.36 0.43; -0.9 0.4 0.35; -0.93 0.46 0.29; -0.97 0.46 0.2; -0.97 0.4 0.22; ...
    -0.96 0.4 0.3; -0.89 0.37 0.3; -0.87 0.34 0.34]';

p1m1_lwrist_manual = [-0.82 0.565 0.39; -0.8 0.55 0.39; -0.74 0.35 0.46; -0.74 0.24 0.47; ...
    -0.74 0.22 0.45; -0.78 0.34 0.42; -0.82 0.45 0.35; -0.82 0.52 0.28; -0.83 0.47 0.3; ...
    -0.8 0.38 0.4; -0.76 0.3 0.4; -0.76 0.2 0.39]';

person1_move1_no_occlusion_relbow(:,p1m1_ind) = p1m1_relbow_manual;
person1_move1_no_occlusion_rwrist(:,p1m1_ind) = p1m1_rwrist_manual;
person1_move1_no_occlusion_lelbow(:,p1m1_ind) = p1m1_lelbow_manual;
person1_move1_no_occlusion_lwrist(:,p1m1_ind) = p1m1_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person1_move2_horz_cross
p1m2_ind = 1:10:135;
person1_move2_horz_cross_relbow = nan(3, 135);
person1_move2_horz_cross_rwrist = nan(3, 135);
person1_move2_horz_cross_lelbow = nan(3, 135);
person1_move2_horz_cross_lwrist = nan(3, 135);

p1m2_relbow_manual = [NaN NaN NaN; -1.04 -0.35 0.32; -0.89 -0.28 0.31; -0.88 -0.18 0.27; ...
    -0.89 -0.25 0.26; -1.15 -0.25 0.2; -1.2 -0.25 0.2; -0.94 -0.33 0.26; -0.88 -0.2 0.36; ...
    -0.86 -0.16 0.38; -0.91 -0.3 0.3; -0.98 -0.36 0.24; -0.98 -0.36 0.24; -0.92 -0.32 0.25]';

p1m2_rwrist_manual = [NaN NaN NaN; -0.85 -0.35 0.34; -0.73 -0.23 0.31; -0.7 0 0.26; ...
    -0.7 -0.16 0.26; -1.02 -0.36 0.36; -1.2 -0.3 0.42; -0.8 -0.3 0.3; -0.72 -0.03 0.41; ...
    -0.74 -0.15 0.4; -0.74 -0.26 0.33; -0.8 -0.33 0.26; -0.79 -0.33 0.27; -0.79 -0.33 0.26]';

p1m2_lelbow_manual = [NaN NaN NaN; -1.02 0.55 0.32; -0.86 0.42 0.36; -0.77 0.3 0.38; ...
    -0.86 0.38 0.37; -0.89 0.45 0.3; -0.89 0.45 0.32; -0.93 0.48 0.3; -0.85 0.3 0.26; ...
    -0.83 0.32 0.28; -0.94 0.46 0.28; -1.16 0.47 0.25; -1.17 0.52 0.24; -0.96 0.48 0.27]';

p1m2_lwrist_manual = [NaN NaN NaN; -0.84 0.53 0.36; -0.68 0.31 0.41; -0.68 0.1 0.43; ...
    -0.67 0.22 0.37; -0.72 0.36 0.3; -0.72 0.36 0.32; -0.75 0.43 0.3; -0.69 0.13 0.25; ...
    -0.72 0.12 0.26; -0.78 0.4 0.28; -1.06 0.5 0.42; -1.07 0.52 0.4; -0.78 0.44 0.28]';

person1_move2_horz_cross_relbow(:,p1m2_ind) = p1m2_relbow_manual;
person1_move2_horz_cross_rwrist(:,p1m2_ind) = p1m2_rwrist_manual;
person1_move2_horz_cross_lelbow(:,p1m2_ind) = p1m2_lelbow_manual;
person1_move2_horz_cross_lwrist(:,p1m2_ind) = p1m2_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person1_move3_vert_cross
p1m3_ind = 1:10:93;
person1_move3_vert_cross_relbow = nan(3, 93);
person1_move3_vert_cross_rwrist = nan(3, 93);
person1_move3_vert_cross_lelbow = nan(3, 93);
person1_move3_vert_cross_lwrist = nan(3, 93);

p1m3_relbow_manual = [-1.09 -0.28 0.38; -1.09 -0.3 0.37; -0.95 -0.24 0.24; -0.94 -0.18 0.2; ...
    -0.93 -0.2 0.36; -0.93 -0.19 0.38; -0.9 -0.18 0.17; -0.89 -0.19 0.43; -0.84 -0.19 0.25; ...
    -0.9 -0.19 0.16]';

p1m3_rwrist_manual = [-0.86 -0.35 0.38; -0.85 -0.34 0.41; -0.75 -0.115 0.23; -0.78 -0.01 0.2; ...
    -0.78 -0.07 0.46; -0.79 -0.05 0.48; -0.74 -0.06 0.17; -0.71 -0.09 0.52; -0.67 -0.07 0.31; ...
    -0.75 -0.08 0.15]';

p1m3_lelbow_manual = [-1.06 0.54 0.38; -1.04 0.54 0.37; -0.84 0.39 0.35; -0.75 0.3 0.35; ...
    -0.81 0.32 0.2; -0.83 0.32 0.2; -0.8 0.32 0.35; -0.88 0.34 0.2; -0.82 0.35 0.28; ...
    -0.78 0.3 0.37]';

p1m3_lwrist_manual = [-0.84 0.53 0.38; -0.8 0.53 0.39; -0.68 0.23 0.42; -0.65 0.14 0.47; ...
    -0.67 0.14 0.24; -0.67 0.15 0.26; -0.71 0.17 0.48; -0.79 0.15 0.24; -0.78 0.14 0.35; ...
    -0.69 0.15 0.52]';

person1_move3_vert_cross_relbow(:,p1m3_ind) = p1m3_relbow_manual;
person1_move3_vert_cross_rwrist(:,p1m3_ind) = p1m3_rwrist_manual;
person1_move3_vert_cross_lelbow(:,p1m3_ind) = p1m3_lelbow_manual;
person1_move3_vert_cross_lwrist(:,p1m3_ind) = p1m3_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person1_move4_high_five
p1m4_ind = 1:10:92;
person1_move4_high_five_relbow = nan(3, 92);
person1_move4_high_five_rwrist = nan(3, 92);
person1_move4_high_five_lelbow = nan(3, 92);
person1_move4_high_five_lwrist = nan(3, 92);

p1m4_relbow_manual = [-1.08 -0.42 0.39; -1.08 -0.42 0.39; -0.94 -0.27 0.26; -0.91 -0.15 0.19; ...
    -0.92 -0.15 0.16; -0.92 -0.14 0.2; -0.92 -0.16 0.22; -0.92 -0.14 0.18; -0.92 -0.16 0.15; ...
    -0.92 -0.17 0.14]';

p1m4_rwrist_manual = [-0.87 -0.43 0.39; -0.87 -0.43 0.39; -0.76 -0.2 0.34; -0.76 -0.03 0.27; ...
    -0.73 -0.03 0.1; -0.75 -0.02 0.28; -0.77 -0.04 0.26; -0.72 0.03 0.28; -0.75 -0.05 0.19; ...
    -0.74 -0.04 0.1]';

p1m4_lelbow_manual = [-1.09 0.5 0.39; -1.09 0.5 0.39; -0.9 0.37 0.26; -0.91 0.26 0.19; ...
    -0.92 0.27 0.2; -0.92 0.25 0.2; -0.92 0.28 0.18; -0.92 0.26 0.18; -0.91 0.26 0.22; ...
    -0.92 0.27 0.19]';

p1m4_lwrist_manual = [-0.89 0.49 0.39; -0.89 0.49 0.39; -0.77 0.28 0.34; -0.76 0.11 0.27; ...
    -0.75 0.14 0.28; -0.75 0.12 0.28; -0.74 0.18 0.14; -0.72 0.13 0.28; -0.75 0.13 0.28; ...
    -0.76 0.135 0.27]';

person1_move4_high_five_relbow(:,p1m4_ind) = p1m4_relbow_manual;
person1_move4_high_five_rwrist(:,p1m4_ind) = p1m4_rwrist_manual;
person1_move4_high_five_lelbow(:,p1m4_ind) = p1m4_lelbow_manual;
person1_move4_high_five_lwrist(:,p1m4_ind) = p1m4_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person1_move5_arms_together
p1m5_ind = 1:10:77;
person1_move5_arms_together_relbow = nan(3, 77);
person1_move5_arms_together_rwrist = nan(3, 77);
person1_move5_arms_together_lelbow = nan(3, 77);
person1_move5_arms_together_lwrist = nan(3, 77);

p1m5_relbow_manual = [NaN NaN NaN; -1 -0.34 0.36; -0.89 -0.22 0.3; -0.88 -0.2 0.28; ...
    -1.04 -0.3 0.34; -1.03 -0.36 0.37; -0.84 -0.19 0.37; -0.88 -0.21 0.36]';

p1m5_rwrist_manual = [NaN NaN NaN; -0.79 -0.33 0.36; -0.74 -0.06 0.3; -0.76 -0.01 0.28; ...
    -0.79 -0.32 0.34; -0.81 -0.34 0.37; -0.77 0 0.37; -0.76 0 0.36]';

p1m5_lelbow_manual = [NaN NaN NaN; -0.95 0.43 0.4; -0.82 0.26 0.36; -0.82 0.26 0.34; ...
    -1.04 0.45 0.36; -0.98 0.44 0.33; -0.82 0.23 0.3; -0.83 0.27 0.3]';

p1m5_lwrist_manual = [NaN NaN NaN; -0.8 0.38 0.43; -0.76 0.04 0.42; -0.76 0.02 0.34; ...
    -0.83 0.42 0.36; -0.79 0.36 0.33; -0.76 0.04 0.3; -0.76 0.08 0.3]';

person1_move5_arms_together_relbow(:,p1m5_ind) = p1m5_relbow_manual;
person1_move5_arms_together_rwrist(:,p1m5_ind) = p1m5_rwrist_manual;
person1_move5_arms_together_lelbow(:,p1m5_ind) = p1m5_lelbow_manual;
person1_move5_arms_together_lwrist(:,p1m5_ind) = p1m5_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person1_move6_no_color
p1m6_ind = 1:10:89;
person1_move6_no_color_relbow = nan(3, 89);
person1_move6_no_color_rwrist = nan(3, 89);
person1_move6_no_color_lelbow = nan(3, 89);
person1_move6_no_color_lwrist = nan(3, 89);

p1m6_relbow_manual = [-1.08 -0.32 0.38; -0.98 -0.28 0.35; -0.86 -0.11 0.28; -1 -0.3 0.28; ...
    -1.04 -0.32 0.28; -0.92 -0.19 0.33; -0.85 -0.11 0.34; -0.98 -0.28 0.28; -1.06 -0.3 0.28]';

p1m6_rwrist_manual = [-0.83 -0.32 0.495; -0.73 -0.18 0.36; -0.78 0.1 0.28; -0.72 -0.24 0.32; ...
    -0.8 -0.32 0.38; -0.73 -0.02 0.38; -0.77 0.1 0.38; -0.72 -0.18 0.32; -0.82 -0.33 0.32]';

p1m6_lelbow_manual = [-1.08 0.52 0.38; -0.93 0.45 0.4; -0.82 0.27 0.37; -0.97 0.46 0.32; ...
    -1.02 0.48 0.31; -0.87 0.35 0.27; -0.84 0.3 0.25; -0.98 0.47 0.28; -1.06 0.52 0.28]';

p1m6_lwrist_manual = [-0.85 0.55 0.48; -0.74 0.31 0.46; -0.77 0.02 0.43; -0.77 0.4 0.38; ...
    -0.79 0.46 0.31; -0.73 0.12 0.26; -0.77 0.1 0.25; -0.77 0.41 0.32; -0.82 0.5 0.32]';

person1_move6_no_color_relbow(:,p1m6_ind) = p1m6_relbow_manual;
person1_move6_no_color_rwrist(:,p1m6_ind) = p1m6_rwrist_manual;
person1_move6_no_color_lelbow(:,p1m6_ind) = p1m6_lelbow_manual;
person1_move6_no_color_lwrist(:,p1m6_ind) = p1m6_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person2_move1_no_occlusion
p2m1_ind = 1:10:80;
person2_move1_no_occlusion_relbow = nan(3, 80);
person2_move1_no_occlusion_rwrist = nan(3, 80);
person2_move1_no_occlusion_lelbow = nan(3, 80);
person2_move1_no_occlusion_lwrist = nan(3, 80);

p2m1_relbow_manual = [-1.15 -0.28 0.42; -1.06 -0.26 0.36; -1.1 -0.24 0.28; -1.05 -0.22 0.26; ...
    -0.96 -0.16 0.3; -0.91 -0.08 0.34; -0.98 -0.19 0.3; -1 -0.18 0.16]';

p2m1_rwrist_manual = [-0.93 -0.24 0.42; -0.86 -0.18 0.39; -0.84 -0.32 0.34; -0.84 -0.28 0.3; ...
    -0.8 -0.01 0.39; -0.81 0.13 0.4; -0.76 -0.11 0.37; -0.82 -0.22 0.16]';

p2m1_lelbow_manual = [-1.15 0.66 0.42; -1.06 0.59 0.36; -0.92 0.44 0.42; -0.9 0.37 0.4; ...
    -0.98 0.54 0.3; -1.06 0.55 0.18; -0.94 0.44 0.33; -0.88 0.34 0.34]';

p2m1_lwrist_manual = [-0.9 0.59 0.42; -0.85 0.5 0.39; -0.73 0.24 0.48; -0.71 0.21 0.45; ...
    -0.8 0.46 0.39; -0.84 0.6 0.22; -0.72 0.3 0.43; -0.7 0.09 0.34]';

person2_move1_no_occlusion_relbow(:,p2m1_ind) = p2m1_relbow_manual;
person2_move1_no_occlusion_rwrist(:,p2m1_ind) = p2m1_rwrist_manual;
person2_move1_no_occlusion_lelbow(:,p2m1_ind) = p2m1_lelbow_manual;
person2_move1_no_occlusion_lwrist(:,p2m1_ind) = p2m1_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person2_move2_horz_cross
p2m2_ind = 1:10:58;
person2_move2_horz_cross_relbow = nan(3, 58);
person2_move2_horz_cross_rwrist = nan(3, 58);
person2_move2_horz_cross_lelbow = nan(3, 58);
person2_move2_horz_cross_lwrist = nan(3, 58);

p2m2_relbow_manual = [-1.15 -0.27 0.4; -0.93 -0.17 0.47; -1.03 -0.25 0.46; -1.16 -0.22 0.4; ...
    -0.9 -0.08 0.39; -0.98 -0.2 0.38]';

p2m2_rwrist_manual = [-0.89 -0.28 0.4; -0.75 0 0.52; -0.86 -0.12 0.56; -1.03 -0.19 0.58; ...
    -0.79 0.12 0.41; -0.8 0 0.4]';

p2m2_lelbow_manual = [-1.14 0.65 0.4; -0.91 0.47 0.4; -0.92 0.46 0.37; -0.88 0.44 0.34; ...
    -0.9 0.44 0.32; -1.24 0.56 0.37]';

p2m2_lwrist_manual = [-0.85 0.64 0.4; -0.73 0.3 0.35; -0.74 0.2 0.31; -0.74 0.25 0.31; ....
    -0.76 0.26 0.3; -1.16 0.53 0.56]';

person2_move2_horz_cross_relbow(:,p2m2_ind) = p2m2_relbow_manual;
person2_move2_horz_cross_rwrist(:,p2m2_ind) = p2m2_rwrist_manual;
person2_move2_horz_cross_lelbow(:,p2m2_ind) = p2m2_lelbow_manual;
person2_move2_horz_cross_lwrist(:,p2m2_ind) = p2m2_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person2_move3_vert_cross
p2m3_ind = 1:10:80;
person2_move3_vert_cross_relbow = nan(3, 80);
person2_move3_vert_cross_rwrist = nan(3, 80);
person2_move3_vert_cross_lelbow = nan(3, 80);
person2_move3_vert_cross_lwrist = nan(3, 80);

p2m3_relbow_manual = [-1.15 -0.28 0.42; -1.14 -0.26 0.41; -0.9 -0.16 0.36; -0.91 -0.15 0.35; ...
    -0.92 -0.13 0.22; -0.89 -0.15 0.37; -0.92 -0.15 0.33; -0.93 -0.14 0.17]';

p2m3_rwrist_manual = [-0.94 -0.26 0.42; -0.85 -0.24 0.41; -0.7 0.02 0.42; -0.72 0.02 0.44; ...
    -0.71 0.03 0.16; -0.71 0.02 0.46; -0.7 -0.04 0.38; -0.74 0.02 0.12]';

p2m3_lelbow_manual = [-1.16 0.66 0.42; -1.12 0.65 0.41; -0.88 0.45 0.32; -0.89 0.45 0.27; ...
    -0.88 0.46 0.43; -0.88 0.41 0.26; -0.87 0.43 0.28; -0.85 0.44 0.46]';

p2m3_lwrist_manual = [-0.9 0.63 0.42; -0.83 0.53 0.41; -0.68 0.24 0.32; -0.73 0.23 0.27; ...
    -0.74 0.28 0.57; -0.74 0.22 0.26; -0.73 0.23 0.28; -0.72 0.23 0.6]';

person2_move3_vert_cross_relbow(:,p2m3_ind) = p2m3_relbow_manual;
person2_move3_vert_cross_rwrist(:,p2m3_ind) = p2m3_rwrist_manual;
person2_move3_vert_cross_lelbow(:,p2m3_ind) = p2m3_lelbow_manual;
person2_move3_vert_cross_lwrist(:,p2m3_ind) = p2m3_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person2_move4_high_five
p2m4_ind = 1:10:69;
person2_move4_high_five_relbow = nan(3, 69);
person2_move4_high_five_rwrist = nan(3, 69);
person2_move4_high_five_lelbow = nan(3, 69);
person2_move4_high_five_lwrist = nan(3, 69);

p2m4_relbow_manual = [-1.15 -0.29 0.44; -0.94 -0.15 0.26; -0.94 -0.12 0.22; -0.94 -0.15 0.28; ...
    -0.95 -0.08 0.27; -0.96 -0.1 0.24; -0.96 -0.11 0.26]';

p2m4_rwrist_manual = [-0.95 -0.27 0.44; -0.76 0 0.39; -0.7 0.14 0.14; -0.8 0 0.38; ...
    -0.8 0.06 0.34; -0.73 0.07 0.26; -0.8 0.03 0.38]';

p2m4_lelbow_manual = [-1.15 0.64 0.44; -0.87 0.4 0.26; -0.87 0.42 0.3; -0.92 0.44 0.21; ...
    -0.94 0.40 0.27; -0.888 0.37 0.26; -0.87 0.37 0.26]';

p2m4_lwrist_manual = [-0.92 0.6 0.44; -0.74 0.28 0.39; -0.77 0.27 0.43; -0.72 0.24 0.18; ...
    -0.77 0.19 0.34; -0.77 0.22 0.36; -0.75 0.23 0.31]';

person2_move4_high_five_relbow(:,p2m4_ind) = p2m4_relbow_manual;
person2_move4_high_five_rwrist(:,p2m4_ind) = p2m4_rwrist_manual;
person2_move4_high_five_lelbow(:,p2m4_ind) = p2m4_lelbow_manual;
person2_move4_high_five_lwrist(:,p2m4_ind) = p2m4_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person2_move5_arms_together
p2m5_ind = 1:10:51;
person2_move5_arms_together_relbow = nan(3, 51);
person2_move5_arms_together_rwrist = nan(3, 51);
person2_move5_arms_together_lelbow = nan(3, 51);
person2_move5_arms_together_lwrist = nan(3, 51);

p2m5_relbow_manual = [-1.15 -0.28 0.42; -1.03 -0.27 0.44; -0.86 -0.06 0.39; -0.88 -0.15 0.37; ...
    -0.86 -0.09 0.38; -0.9 -0.14 0.36]';

p2m5_rwrist_manual = [-0.95 -0.27 0.42; -0.84 -0.155 0.44; -0.8 0.15 0.42; -0.67 -0.03 0.43; ...
    -0.84 0.14 0.41; -0.64 -0.14 0.34]';

p2m5_lelbow_manual = [-1.15 0.63 0.42; -0.9 0.49 0.42; -0.84 0.35 0.33; -0.85 0.42 0.36; ...
    -0.83 0.36 0.32; -0.9 0.42 0.36]';

p2m5_lwrist_manual = [-0.9 0.58 0.42; -0.78 0.36 0.42; -0.79 0.11 0.32; -0.64 0.26 0.36; ...
    -0.8 0.14 0.32; -0.62 0.37 0.32]';

person2_move5_arms_together_relbow(:,p2m5_ind) = p2m5_relbow_manual;
person2_move5_arms_together_rwrist(:,p2m5_ind) = p2m5_rwrist_manual;
person2_move5_arms_together_lelbow(:,p2m5_ind) = p2m5_lelbow_manual;
person2_move5_arms_together_lwrist(:,p2m5_ind) = p2m5_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person2_move6_no_color
p2m6_ind = 1:10:40;
person2_move6_no_color_relbow = nan(3, 40);
person2_move6_no_color_rwrist = nan(3, 40);
person2_move6_no_color_lelbow = nan(3, 40);
person2_move6_no_color_lwrist = nan(3, 40);

p2m6_relbow_manual = [-1.15 -0.31 0.38; -0.91 -0.18 0.38; -0.95 -0.23 0.38; -0.9 -0.13 0.34]';

p2m6_rwrist_manual = [-0.89 -0.3 0.42; -0.7 0.01 0.42; -0.69 -0.13 0.42; -0.68 0.07 0.4]';

p2m6_lelbow_manual = [-1.15 0.6 0.39; -0.88 0.39 0.36; -0.92 0.46 0.37; -0.88 0.35 0.33]';

p2m6_lwrist_manual = [-0.85 0.52 0.42; -0.66 0.18 0.36; -0.68 0.38 0.37; -0.65 0.15 0.32]';

person2_move6_no_color_relbow(:,p2m6_ind) = p2m6_relbow_manual;
person2_move6_no_color_rwrist(:,p2m6_ind) = p2m6_rwrist_manual;
person2_move6_no_color_lelbow(:,p2m6_ind) = p2m6_lelbow_manual;
person2_move6_no_color_lwrist(:,p2m6_ind) = p2m6_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person3_move1_no_occlusion
p3m1_ind = 1:10:66;
person3_move1_no_occlusion_relbow = nan(3, 66);
person3_move1_no_occlusion_rwrist = nan(3, 66);
person3_move1_no_occlusion_lelbow = nan(3, 66);
person3_move1_no_occlusion_lwrist = nan(3, 66);

p3m1_relbow_manual = [NaN NaN NaN; -1.14 -0.3 0.3; -0.85 -0.18 0.38; -0.9 -0.16 0.27; ...
    -0.86 -0.16 0.25; -0.86 -0.15 0.38; -0.88 -0.1 0.13]';

p3m1_rwrist_manual = [NaN NaN NaN; -0.89 -0.3 0.33; -0.68 -0.14 0.45; -0.68 -0.13 0.34; ...
    -0.7 -0.14 0.3; -0.67 -0.08 0.44; -0.7 -0.1 0.15]';

p3m1_lelbow_manual = [NaN NaN NaN; -1.05 0.64 0.3; -0.81 0.4 0.24; -0.85 0.43 0.34; ...
    -0.85 0.4 0.32; -0.81 0.34 0.18; -0.85 0.39 0.38]';

p3m1_lwrist_manual = [NaN NaN NaN; -0.882 0.58 0.33; -0.65 0.36 0.28; -0.66 0.35 0.42; ...
    -0.66 0.32 0.38; -0.64 0.27 0.25; -0.65 0.28 0.47]';

person3_move1_no_occlusion_relbow(:,p3m1_ind) = p3m1_relbow_manual;
person3_move1_no_occlusion_rwrist(:,p3m1_ind) = p3m1_rwrist_manual;
person3_move1_no_occlusion_lelbow(:,p3m1_ind) = p3m1_lelbow_manual;
person3_move1_no_occlusion_lwrist(:,p3m1_ind) = p3m1_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person3_move2_horz_cross
p3m2_ind = 1:10:84;
person3_move2_horz_cross_relbow = nan(3, 84);
person3_move2_horz_cross_rwrist = nan(3, 84);
person3_move2_horz_cross_lelbow = nan(3, 84);
person3_move2_horz_cross_lwrist = nan(3, 84);

p3m2_relbow_manual = [NaN NaN NaN; -1.09 -0.27 0.3; -0.87 -0.14 0.26; -0.88 -0.17 0.26; ...
    -1.34 -0.15 0.2; -1.22 -0.21 0.24; -0.8 -0.08 0.28; -0.79 -0.1 0.26; -0.84 -0.16 0.26]';

p3m2_rwrist_manual = [NaN NaN NaN; -0.86 -0.28 0.34; -0.66 -0.02 0.28; -0.66 -0.07 0.28; ...
    -1.33 -0.3 0.3; -1.04 -0.34 0.37; -0.63 0.04 0.31; -0.61 0 0.28; -0.64 -0.08 0.3]';

p3m2_lelbow_manual = [NaN NaN NaN; -0.95 0.61 0.3; -0.81 0.38 0.3; -0.82 0.38 0.3; ...
    -0.788 0.4 0.3; -0.79 0.41 0.29; -0.76 0.34 0.23; -1.25 0.48 0.17; -0.85 0.51 0.28]';

p3m2_lwrist_manual = [NaN NaN NaN; -0.78 0.56 0.37; -0.6 0.24 0.36; -0.6 0.23 0.35; ...
    -0.6 0.26 0.32; -0.6 0.26 0.31; -0.58 0.16 0.22; -1.24 0.6 0.26; -0.68 0.44 0.32]';

person3_move2_horz_cross_relbow(:,p3m2_ind) = p3m2_relbow_manual;
person3_move2_horz_cross_rwrist(:,p3m2_ind) = p3m2_rwrist_manual;
person3_move2_horz_cross_lelbow(:,p3m2_ind) = p3m2_lelbow_manual;
person3_move2_horz_cross_lwrist(:,p3m2_ind) = p3m2_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person3_move3_vert_cross
p3m3_ind = 1:10:80;
person3_move3_vert_cross_relbow = nan(3, 80);
person3_move3_vert_cross_rwrist = nan(3, 80);
person3_move3_vert_cross_lelbow = nan(3, 80);
person3_move3_vert_cross_lwrist = nan(3, 80);

p3m3_relbow_manual = [NaN NaN NaN; -1.1 -0.31 0.28; -0.92 -0.2 0.24; -0.88 -0.16 0.34; ...
    -0.9 -0.15 0.22; -0.88 -0.17 0.32; -0.88 -0.16 0.15; -0.82 -0.15 0.31]';

p3m3_rwrist_manual = [NaN NaN NaN; -0.88 -0.33 0.3; -0.8 -0.03 0.27; -0.66 -0.04 0.41; ...
    -0.65 -0.005 0.22; -0.69 -0.01 0.39; -0.74 -0.01 0.15; -0.65 -0.04 0.38]';

p3m3_lelbow_manual = [NaN NaN NaN; -0.96 0.56 0.28; -0.85 0.33 0.28; -0.9 0.35 0.2; ...
    -0.84 0.38 0.3; -0.82 0.36 0.24; -0.9 0.38 0.32; -0.9 0.35 0.2]';

p3m3_lwrist_manual = [NaN NaN NaN; -0.75 0.46 0.32; -0.58 0.21 0.34; -0.71 0.18 0.24; ...
    -0.71 0.22 0.44; -0.59 0.2 0.24; -0.68 0.24 0.47; -0.68 0.22 0.21]';

person3_move3_vert_cross_relbow(:,p3m3_ind) = p3m3_relbow_manual;
person3_move3_vert_cross_rwrist(:,p3m3_ind) = p3m3_rwrist_manual;
person3_move3_vert_cross_lelbow(:,p3m3_ind) = p3m3_lelbow_manual;
person3_move3_vert_cross_lwrist(:,p3m3_ind) = p3m3_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person3_move4_high_five
p3m4_ind = 1:10:60;
person3_move4_high_five_relbow = nan(3, 60);
person3_move4_high_five_rwrist = nan(3, 60);
person3_move4_high_five_lelbow = nan(3, 60);
person3_move4_high_five_lwrist = nan(3, 60);

p3m4_relbow_manual = [NaN NaN NaN; -1.05 -0.27 0.28; -0.89 -0.07 0.19; -0.9 -0.13 0.14; ...
    -0.9 -0.1 0.19; -0.91 -0.18 0.25]';

p3m4_rwrist_manual = [NaN NaN NaN; -0.84 -0.27 0.3; -0.66 0.04 0.29; -0.66 0.02 0.12; ...
    -0.7 0.04 0.3; -0.73 -0.1 0.38]';

p3m4_lelbow_manual = [NaN NaN NaN; -0.94 0.57 0.28; -0.86 0.34 0.19; -0.85 0.4 0.27; ...
    -0.86 0.34 0.19; -0.86 0.37 0.16]';

p3m4_lwrist_manual = [NaN NaN NaN; -0.71 0.46 0.32; -0.66 0.14 0.29; -0.7 0.29 0.42; ...
    -0.7 0.16 0.3; -0.66 0.24 0.14]';

person3_move4_high_five_relbow(:,p3m4_ind) = p3m4_relbow_manual;
person3_move4_high_five_rwrist(:,p3m4_ind) = p3m4_rwrist_manual;
person3_move4_high_five_lelbow(:,p3m4_ind) = p3m4_lelbow_manual;
person3_move4_high_five_lwrist(:,p3m4_ind) = p3m4_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person3_move5_arms_together
p3m5_ind = 1:10:56;
person3_move5_arms_together_relbow = nan(3, 56);
person3_move5_arms_together_rwrist = nan(3, 56);
person3_move5_arms_together_lelbow = nan(3, 56);
person3_move5_arms_together_lwrist = nan(3, 56);

p3m5_relbow_manual = [NaN NaN NaN; -0.94 -0.25 0.36; -0.85 -0.1 0.33; -0.91 -0.24 0.26; ...
    -0.85 -0.11 0.33; -0.87 -0.2 0.33]';

p3m5_rwrist_manual = [NaN NaN NaN; -0.72 -0.12 0.36; -0.72 0.15 0.33; -0.63 -0.22 0.26; ...
    -0.75 0.15 0.33; -0.63 -0.06 0.34]';

p3m5_lelbow_manual = [NaN NaN NaN; -0.84 0.49 0.38; -0.75 0.33 0.4; -0.8 0.49 0.3; ...
    -0.74 0.35 0.28; -0.8 0.48 0.33]';

p3m5_lwrist_manual = [NaN NaN NaN; -0.7 0.32 0.43; -0.72 0.05 0.4; -0.6 0.44 0.3; ...
    -0.75 0.1 0.26; -0.63 0.38 0.33]';

person3_move5_arms_together_relbow(:,p3m5_ind) = p3m5_relbow_manual;
person3_move5_arms_together_rwrist(:,p3m5_ind) = p3m5_rwrist_manual;
person3_move5_arms_together_lelbow(:,p3m5_ind) = p3m5_lelbow_manual;
person3_move5_arms_together_lwrist(:,p3m5_ind) = p3m5_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person3_move6_no_color
p3m6_ind = 1:10:40;
person3_move6_no_color_relbow = nan(3, 40);
person3_move6_no_color_rwrist = nan(3, 40);
person3_move6_no_color_lelbow = nan(3, 40);
person3_move6_no_color_lwrist = nan(3, 40);

p3m6_relbow_manual = [NaN NaN NaN; -0.81 -0.11 0.27; -0.94 -0.25 0.28; -0.77 -0.05 0.28]';

p3m6_rwrist_manual = [NaN NaN NaN; -0.62 0.06 0.27; -0.66 -0.19 0.33; -0.62 0.15 0.32]';

p3m6_lelbow_manual = [NaN NaN NaN; -0.77 0.36 0.29; -0.82 0.5 0.28; -0.73 0.29 0.23]';

p3m6_lwrist_manual = [NaN NaN NaN; -0.62 0.15 0.35; -0.63 0.41 0.33; -0.63 0.08 0.22]';

person3_move6_no_color_relbow(:,p3m6_ind) = p3m6_relbow_manual;
person3_move6_no_color_rwrist(:,p3m6_ind) = p3m6_rwrist_manual;
person3_move6_no_color_lelbow(:,p3m6_ind) = p3m6_lelbow_manual;
person3_move6_no_color_lwrist(:,p3m6_ind) = p3m6_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person4_move1_no_occlusion
p4m1_ind = 1:10:75;
person4_move1_no_occlusion_relbow = nan(3, 75);
person4_move1_no_occlusion_rwrist = nan(3, 75);
person4_move1_no_occlusion_lelbow = nan(3, 75);
person4_move1_no_occlusion_lwrist = nan(3, 75);

p4m1_relbow_manual = [NaN NaN NaN; -1.13 -0.27 0.37; -0.87 -0.19 0.43; -0.89 -0.225 0.39; ...
    -0.91 -0.21 0.2; -0.92 -0.23 0.25; -0.87 -0.14 0.4; -0.87 -0.19 0.36]';

p4m1_rwrist_manual = [NaN NaN NaN; -0.88 -0.3 0.38; -0.67 -0.06 0.5; -0.69 -0.13 0.47; ...
    -0.69 -0.16 0.26; -0.7 -0.15 0.33; -0.69 0 0.49; -0.67 -0.11 0.44]';

p4m1_lelbow_manual = [NaN NaN NaN; -1.05 0.57 0.36; -1 0.47 0.14; -0.86 0.45 0.27; ...
    -0.81 0.36 0.42; -0.84 0.4 0.38; -0.9 0.4 0.18; -0.83 0.42 0.3]';

p4m1_lwrist_manual = [NaN NaN NaN; -0.82 0.44 0.39; -0.78 0.45 0.2; -0.74 0.42 0.38; ...
    -0.66 0.19 0.53; -0.66 0.26 0.48; -0.67 0.35 0.26; -0.66 0.33 0.38]';

person4_move1_no_occlusion_relbow(:,p4m1_ind) = p4m1_relbow_manual;
person4_move1_no_occlusion_rwrist(:,p4m1_ind) = p4m1_rwrist_manual;
person4_move1_no_occlusion_lelbow(:,p4m1_ind) = p4m1_lelbow_manual;
person4_move1_no_occlusion_lwrist(:,p4m1_ind) = p4m1_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person4_move2_horz_cross
p4m2_ind = 1:10:122;
person4_move2_horz_cross_relbow = nan(3, 122);
person4_move2_horz_cross_rwrist = nan(3, 122);
person4_move2_horz_cross_lelbow = nan(3, 122);
person4_move2_horz_cross_lwrist = nan(3, 122);

p4m2_relbow_manual = [-1.15 -0.3 0.4; -1.03 -0.3 0.4; -0.85 -0.1 0.3; -0.86 -0.14 0.32; ...
    -0.99 -0.28 0.32; -1.3 -0.15 0.26; -1.1 -0.28 0.3; -0.89 -0.17 0.36; -0.83 -0.09 0.36; ...
    -0.9 -0.18 0.3; -0.93 -0.22 0.27; -0.93 -0.22 0.3; -0.85 -0.17 0.3]';

p4m2_rwrist_manual = [-0.92 -0.33 0.4; -0.82 -0.3 0.4; -0.66 0.09 0.3; -0.65 0 0.32; ...
    -0.73 -0.25 0.37; -1.28 -0.37 0.47; -0.91 -0.3 0.47; -0.67 -0.06 0.44; -0.66 0.07 0.41; ...
    -0.66 -0.1 0.35; -0.66 -0.15 0.32; -0.68 0.15 0.32; -0.64 -0.1 0.32]';

p4m2_lelbow_manual = [-1.07 0.62 0.4; -0.93 0.48 0.4; -0.86 0.315 0.39; -0.87 0.35 0.38; ...
    -0.92 0.46 0.34; -0.92 0.47 0.36; -0.89 0.47 0.36; -0.85 0.35 0.3; -0.8 0.3 0.27; ...
    -0.98 0.52 0.28; -1.27 0.52 0.3; -1.01 0.55 0.28; -0.84 0.38 0.28]';

p4m2_lwrist_manual = [-0.87 0.54 0.4; -0.78 0.48 0.46; -0.66 0.11 0.46; -0.65 0.17 0.47; ...
    -0.69 0.41 0.4; -0.7 0.46 0.39; -0.68 0.43 0.38; -0.62 0.2 0.3; -0.65 0.1 0.24; ...
    -0.8 0.46 0.43; -1.3 0.56 0.46; -0.89 0.48 0.46; -0.62 0.27 0.32]';

person4_move2_horz_cross_relbow(:,p4m2_ind) = p4m2_relbow_manual;
person4_move2_horz_cross_rwrist(:,p4m2_ind) = p4m2_rwrist_manual;
person4_move2_horz_cross_lelbow(:,p4m2_ind) = p4m2_lelbow_manual;
person4_move2_horz_cross_lwrist(:,p4m2_ind) = p4m2_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person4_move3_vert_cross
p4m3_ind = 1:10:87;
person4_move3_vert_cross_relbow = nan(3, 87);
person4_move3_vert_cross_rwrist = nan(3, 87);
person4_move3_vert_cross_lelbow = nan(3, 87);
person4_move3_vert_cross_lwrist = nan(3, 87);

p4m3_relbow_manual = [NaN NaN NaN; -1.01 -0.3 0.38; -0.8 -0.18 0.36; -0.8 -0.19 0.2; ...
    -0.78 -0.19 0.34; -0.81 -0.18 0.36; -0.85 -0.22 0.24; -0.79 -0.18 0.3; -0.83 -0.24 0.32]';

p4m3_rwrist_manual = [NaN NaN NaN; -0.79 -0.28 0.41; -0.62 -0.08 0.45; -0.58 -0.05 0.2; ...
    -0.59 -0.07 0.42; -0.65 -0.05 0.48; -0.68 -0.08 0.24; -0.59 -0.05 0.34; -0.66 -0.12 0.43]';

p4m3_lelbow_manual = [NaN NaN NaN; -0.96 0.54 0.38; -0.82 0.4 0.26; -0.82 0.38 0.36; ...
    -0.82 0.4 0.27; -0.8 0.35 0.24; -0.8 0.34 0.38; -0.83 0.38 0.36; -0.82 0.42 0.3]';

p4m3_lwrist_manual = [NaN NaN NaN; -0.74 0.42 0.41; -0.65 0.23 0.3; -0.71 0.2 0.51; ...
    -0.67 0.2 0.37; -0.6 0.175 0.24; -0.62 0.2 0.5; -0.7 0.2 0.45; -0.63 0.28 0.32]';

person4_move3_vert_cross_relbow(:,p4m3_ind) = p4m3_relbow_manual;
person4_move3_vert_cross_rwrist(:,p4m3_ind) = p4m3_rwrist_manual;
person4_move3_vert_cross_lelbow(:,p4m3_ind) = p4m3_lelbow_manual;
person4_move3_vert_cross_lwrist(:,p4m3_ind) = p4m3_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person4_move4_high_five
p4m4_ind = 1:10:78;
person4_move4_high_five_relbow = nan(3, 78);
person4_move4_high_five_rwrist = nan(3, 78);
person4_move4_high_five_lelbow = nan(3, 78);
person4_move4_high_five_lwrist = nan(3, 78);

p4m4_relbow_manual = [NaN NaN NaN; -1 -0.28 0.38; -0.85 -0.1 0.26; -0.85 -0.1 0.2; ...
    -0.9 -0.13 0.17; -0.86 -0.07 0.23; -0.88 -0.17 0.36; -0.89 -0.19 0.38]';

p4m4_rwrist_manual = [NaN NaN NaN; -0.8 -0.26 0.42; -0.66 0.01 0.36; -0.66 0.03 0.28; ...
    -0.68 0 0.1; -0.69 0.05 0.32; -0.66 -0.05 0.43; -0.67 -0.08 0.44]';

p4m4_lelbow_manual = [NaN NaN NaN; -0.94 0.51 0.38; -0.82 0.37 0.26; -0.84 0.36 0.33; ...
    -0.88 0.37 0.38; -0.84 0.33 0.23; -0.86 0.375 0.2; -0.85 0.39 0.3]';

p4m4_lwrist_manual = [NaN NaN NaN; -0.76 0.44 0.42; -0.66 0.21 0.36; -0.67 0.2 0.38; ...
    -0.67 0.2 0.49; -0.67 0.15 0.32; -0.67 0.28 0.17; -0.66 0.31 0.3]';

person4_move4_high_five_relbow(:,p4m4_ind) = p4m4_relbow_manual;
person4_move4_high_five_rwrist(:,p4m4_ind) = p4m4_rwrist_manual;
person4_move4_high_five_lelbow(:,p4m4_ind) = p4m4_lelbow_manual;
person4_move4_high_five_lwrist(:,p4m4_ind) = p4m4_lwrist_manual;


% ------------------------------------------------------------------------------------------
% Person4_move5_arms_together
p4m5_ind = 1:10:79;
person4_move5_arms_together_relbow = nan(3, 79);
person4_move5_arms_together_rwrist = nan(3, 79);
person4_move5_arms_together_lelbow = nan(3, 79);
person4_move5_arms_together_lwrist = nan(3, 79);

p4m5_relbow_manual = [NaN NaN NaN; -0.95 -0.26 0.44; -0.77 -0.1 0.36; -0.78 -0.13 0.38; ...
    -0.9 -0.24 0.34; -0.82 -0.2 0.32; -0.79 -0.09 0.3; -0.83 -0.2 0.3]';

p4m5_rwrist_manual = [NaN NaN NaN; -0.74 -0.21 0.44; -0.7 0.1 0.36; -0.71 0.06 0.38; ...
    -0.68 -0.15 0.36; -0.66 -0.08 0.34; -0.72 0.16 0.3; -0.65 -0.05 0.32]';

p4m5_lelbow_manual = [NaN NaN NaN; -0.88 0.47 0.42; -0.75 0.33 0.29; -0.79 0.38 0.3; ...
    -0.9 0.42 0.34; -0.85 0.43 0.39; -0.75 0.3 0.37; -0.82 0.43 0.37]';

p4m5_lwrist_manual = [NaN NaN NaN; -0.72 0.38 0.42; -0.69 0.1 0.29; -0.71 0.11 0.3; ...
    -0.68 0.36 0.36; -0.67 0.28 0.43; -0.72 0.05 0.37; -0.63 0.235 0.43]';

person4_move5_arms_together_relbow(:,p4m5_ind) = p4m5_relbow_manual;
person4_move5_arms_together_rwrist(:,p4m5_ind) = p4m5_rwrist_manual;
person4_move5_arms_together_lelbow(:,p4m5_ind) = p4m5_lelbow_manual;
person4_move5_arms_together_lwrist(:,p4m5_ind) = p4m5_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person4_move6_no_color
p4m6_ind = 1:10:68;
person4_move6_no_color_relbow = nan(3, 68);
person4_move6_no_color_rwrist = nan(3, 68);
person4_move6_no_color_lelbow = nan(3, 68);
person4_move6_no_color_lwrist = nan(3, 68);

p4m6_relbow_manual = [NaN NaN NaN; -1.01 -0.33 0.42; -0.79 -0.14 0.31; -0.82 -0.17 0.31; ...
    -0.96 -0.31 0.34; -0.79 -0.09 0.38; -0.82 -0.17 0.38]';

p4m6_rwrist_manual = [NaN NaN NaN; -0.75 -0.27 0.42; -0.66 0.04 0.29; -0.65 -0.02 0.3; ...
    -0.7 -0.23 0.35; -0.65 0.1 0.38; -0.63 0.025 0.42]';

p4m6_lelbow_manual = [NaN NaN NaN; -0.97 0.46 0.46; -0.78 0.25 0.4; -0.81 0.27 0.42; ...
    -0.89 0.42 0.37; -0.78 0.22 0.27; -0.82 0.31 0.31]';

p4m6_lwrist_manual = [NaN NaN NaN; -0.75 0.33 0.48; -0.66 0.04 0.43; -0.66 0.09 0.44; ...
    -0.67 0.3 0.4; -0.63 0.04 0.27; -0.63 0.15 0.31]';

person4_move6_no_color_relbow(:,p4m6_ind) = p4m6_relbow_manual;
person4_move6_no_color_rwrist(:,p4m6_ind) = p4m6_rwrist_manual;
person4_move6_no_color_lelbow(:,p4m6_ind) = p4m6_lelbow_manual;
person4_move6_no_color_lwrist(:,p4m6_ind) = p4m6_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person5_move1_no_occlusion
p5m1_ind = 1:10:60;
person5_move1_no_occlusion_relbow = nan(3, 60);
person5_move1_no_occlusion_rwrist = nan(3, 60);
person5_move1_no_occlusion_lelbow = nan(3, 60);
person5_move1_no_occlusion_lwrist = nan(3, 60);

p5m1_relbow_manual = [NaN NaN NaN; -0.88 -0.25 0.29; -0.84 -0.18 0.21; -0.86 -0.2 0.34; ...
    -0.88 -0.2 0.3; -0.87 -0.2 0.24]';

p5m1_rwrist_manual = [NaN NaN NaN; -0.62 -0.22 0.38; -0.57 -0.16 0.27; -0.62 -0.15 0.42; ...
    -0.62 -0.16 0.4; -0.59 -0.16 0.28]';

p5m1_lelbow_manual = [NaN NaN NaN; -0.83 0.38 0.29; -0.87 0.325 0.38; -0.82 0.32 0.24; ...
    -0.82 0.33 0.29; -0.88 0.33 0.39]';

p5m1_lwrist_manual = [NaN NaN NaN; -0.62 0.33 0.38; -0.67 0.24 0.51; -0.6 0.29 0.34; ...
    -0.63 0.32 0.37; -0.68 0.265 0.51]';

person5_move1_no_occlusion_relbow(:,p5m1_ind) = p5m1_relbow_manual;
person5_move1_no_occlusion_rwrist(:,p5m1_ind) = p5m1_rwrist_manual;
person5_move1_no_occlusion_lelbow(:,p5m1_ind) = p5m1_lelbow_manual;
person5_move1_no_occlusion_lwrist(:,p5m1_ind) = p5m1_lwrist_manual;


% ------------------------------------------------------------------------------------------
% Person5_move2_horz_cross
p5m2_ind = 1:10:69;
person5_move2_horz_cross_relbow = nan(3, 69);
person5_move2_horz_cross_rwrist = nan(3, 69);
person5_move2_horz_cross_lelbow = nan(3, 69);
person5_move2_horz_cross_lwrist = nan(3, 69);

p5m2_relbow_manual = [NaN NaN NaN; -1.01 -0.27 0.34; -0.82 -0.07 0.38; -1.1 -0.26 0.24; ...
    -0.96 -0.26 0.22; -0.8 -0.115 0.22; -1 -0.3 0.2]';

p5m2_rwrist_manual = [NaN NaN NaN; -0.74 -0.32 0.38; -0.62 0.08 0.45; -1.3 -0.28 0.46; ...
    -0.7 -0.3 0.27; -0.55 0.03 0.21; -0.74 -0.32 0.24]';

p5m2_lelbow_manual = [NaN NaN NaN; -0.94 0.43 0.34; -0.8 0.2 0.21; -0.79 0.4 0.26; ...
    -0.8 0.36 0.34; -0.77 0.24 0.34; -1.29 0.46 0.2]';

p5m2_lwrist_manual = [NaN NaN NaN; -0.72 0.45 0.38; -0.56 0.04 0.2; -0.61 0.38 0.24; ...
    -0.57 0.32 0.4; -0.55 0.07 0.41; -1.27 0.44 0.4]';

person5_move2_horz_cross_relbow(:,p5m2_ind) = p5m2_relbow_manual;
person5_move2_horz_cross_rwrist(:,p5m2_ind) = p5m2_rwrist_manual;
person5_move2_horz_cross_lelbow(:,p5m2_ind) = p5m2_lelbow_manual;
person5_move2_horz_cross_lwrist(:,p5m2_ind) = p5m2_lwrist_manual;


% ------------------------------------------------------------------------------------------
% Person5_move3_vert_cross
p5m3_ind = 1:10:82;
person5_move3_vert_cross_relbow = nan(3, 82);
person5_move3_vert_cross_rwrist = nan(3, 82);
person5_move3_vert_cross_lelbow = nan(3, 82);
person5_move3_vert_cross_lwrist = nan(3, 82);

p5m3_relbow_manual = [NaN NaN NaN; -0.91 -0.29 0.32; -0.8 -0.18 0.26; -0.84 -0.23 0.33; ...
    -0.84 -0.23 0.29; -0.75 -0.22 0.35; -0.78 -0.2 0.34; -0.81 -0.275 0.27; -0.79 -0.24 0.34]';

p5m3_rwrist_manual = [NaN NaN NaN; -0.66 -0.28 0.39; -0.54 -0.06 0.26; -0.69 -0.05 0.42; ...
    -0.76 -0.02 0.24; -0.61 -0.005 0.38; -0.59 -0.03 0.36; -0.72 -0.01 0.27; -0.67 -0.07 0.38]';

p5m3_lelbow_manual = [NaN NaN NaN; -0.85 0.38 0.24; -0.88 0.39 0.34; -0.82 0.34 0.24; ...
    -0.78 0.32 0.33; -0.82 0.4 0.29; -0.81 0.39 0.28; -0.72 0.33 0.31; -0.77 0.37 0.22]';

p5m3_lwrist_manual = [NaN NaN NaN; -0.64 0.3 0.24; -0.71 0.18 0.38; -0.61 0.2 0.24; ...
    -0.59 0.12 0.38; -0.73 0.15 0.28; -0.73 0.135 0.25; -0.58 0.1 0.38; -0.66 0.11 0.22]';

person5_move3_vert_cross_relbow(:,p5m3_ind) = p5m3_relbow_manual;
person5_move3_vert_cross_rwrist(:,p5m3_ind) = p5m3_rwrist_manual;
person5_move3_vert_cross_lelbow(:,p5m3_ind) = p5m3_lelbow_manual;
person5_move3_vert_cross_lwrist(:,p5m3_ind) = p5m3_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person5_move4_high_five
p5m4_ind = 1:10:68;
person5_move4_high_five_relbow = nan(3, 68);
person5_move4_high_five_rwrist = nan(3, 68);
person5_move4_high_five_lelbow = nan(3, 68);
person5_move4_high_five_lwrist = nan(3, 68);

p5m4_relbow_manual = [NaN NaN NaN; -1 -0.26 0.25; -0.93 -0.18 0.18; -0.92 -0.2 0.18; ...
    -0.9 -0.17 0.19; -0.9 -0.23 0.26; -0.92 -0.17 0.2]';

p5m4_rwrist_manual = [NaN NaN NaN; -0.8 -0.27 0.31; -0.74 -0.01 0.28; -0.73 -0.08 0.15; ...
    -0.76 -0.025 0.3; -0.72 -0.12 0.31; -0.72 -0.03 0.32]';

p5m4_lelbow_manual = [NaN NaN NaN; -0.96 0.44 0.25; -0.89 0.26 0.18; -0.88 0.38 0.32; ...
    -0.9 0.28 0.19; -0.88 0.3 0.17; -0.9 0.26 0.2]';

p5m4_lwrist_manual = [NaN NaN NaN; -0.81 0.4 0.31; -0.74 0.14 0.28; -0.74 0.29 0.36; ...
    -0.76 0.14 0.3; -0.73 0.2 0.16; -0.72 0.12 0.32]';

person5_move4_high_five_relbow(:,p5m4_ind) = p5m4_relbow_manual;
person5_move4_high_five_rwrist(:,p5m4_ind) = p5m4_rwrist_manual;
person5_move4_high_five_lelbow(:,p5m4_ind) = p5m4_lelbow_manual;
person5_move4_high_five_lwrist(:,p5m4_ind) = p5m4_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person5_move5_arms_together
p5m5_ind = 1:10:47;
person5_move5_arms_together_relbow = nan(3, 47);
person5_move5_arms_together_rwrist = nan(3, 47);
person5_move5_arms_together_lelbow = nan(3, 47);
person5_move5_arms_together_lwrist = nan(3, 47);

p5m5_relbow_manual = [NaN NaN NaN; -0.9 -0.28 0.32; -0.85 -0.2 0.34; -0.86 -0.25 0.24; ...
    -0.82 -0.19 0.26]';

p5m5_rwrist_manual = [NaN NaN NaN; -0.7 -0.17 0.36; -0.7 0.03 0.34; -0.64 -0.13 0.24; ...
    -0.68 0.01 0.26]';

p5m5_lelbow_manual = [NaN NaN NaN; -0.82 0.35 0.21; -0.8 0.3 0.26; -0.86 0.35 0.33; ...
    -0.78 0.27 0.33]';

p5m5_lwrist_manual = [NaN NaN NaN; -0.63 0.23 0.21; -0.7 0.05 0.24; -0.64 0.19 0.4; ...
    -0.74 0.05 0.37]';

person5_move5_arms_together_relbow(:,p5m5_ind) = p5m5_relbow_manual;
person5_move5_arms_together_rwrist(:,p5m5_ind) = p5m5_rwrist_manual;
person5_move5_arms_together_lelbow(:,p5m5_ind) = p5m5_lelbow_manual;
person5_move5_arms_together_lwrist(:,p5m5_ind) = p5m5_lwrist_manual;

% ------------------------------------------------------------------------------------------
% Person5_move6_no_color
p5m6_ind = 1:10:57;
person5_move6_no_color_relbow = nan(3, 57);
person5_move6_no_color_rwrist = nan(3, 57);
person5_move6_no_color_lelbow = nan(3, 57);
person5_move6_no_color_lwrist = nan(3, 57);

p5m6_relbow_manual = [NaN NaN NaN; -1.12 -0.32 0.4; -0.81 -0.19 0.4; -1 -0.36 0.36; ...
    -0.79 -0.16 0.32; -0.82 -0.19 0.3]';

p5m6_rwrist_manual = [NaN NaN NaN; -0.9 -0.34 0.4; -0.69 -0.01 0.46; -0.76 -0.34 0.38; ...
    -0.68 0.05 0.34; -0.65 -0.02 0.3]';

p5m6_lelbow_manual = [NaN NaN NaN; -1.1 0.42 0.34; -0.81 0.24 0.31; -0.97 0.43 0.31; ...
    -0.82 0.23 0.44; -0.82 0.25 0.42]';

p5m6_lwrist_manual = [NaN NaN NaN; -0.84 0.44 0.32; -0.64 0.07 0.29; -0.71 0.45 0.28; ...
    -0.68 0.06 0.52; -0.65 0.075 0.44]';

person5_move6_no_color_relbow(:,p5m6_ind) = p5m6_relbow_manual;
person5_move6_no_color_rwrist(:,p5m6_ind) = p5m6_rwrist_manual;
person5_move6_no_color_lelbow(:,p5m6_ind) = p5m6_lelbow_manual;
person5_move6_no_color_lwrist(:,p5m6_ind) = p5m6_lwrist_manual;
