function main_particle_filter(bagfile, pcl, whichpcl, centroid_chest, chest2rshoulder, ...
    chest2lshoulder, uparm_dist, loarm_dist, n_particles, move_noise, write, path_output)
%{
    Compute every particle filter.

    Inputs:
    - bagfile: name of the bagfile to read. Character.
    - pcl: point cloud to compute. Either the merged one or one of the separate ones.
    - whichpcl: character choosing the pcl selected. Merged or separate.
    - centroid_chest: joint of the chest. Fixed.
    - chest2rshoulder: distance to get the right shoulder from the chest.
    - chest2lshoulder: distance to get the left shoulder from the chest.
    - uparm_dist: distance of upper arm.
    - loarm_dist: distance of lower arm.
    - n_particles: number of particles in the particle filter.
    - move_noise: noise of the motion model of the particle filter.
    - write: flag to choose if write a mat file. True or false.
    - path_output: default path where to (optionally) write the mat file. Character.

    Returns:

%}
    
% Set default number of particles
if nargin < 11 || isempty(n_particles)
     n_particles = 50;
end

% Set default motion noise
if nargin < 11 || isempty(move_noise)
     move_noise = 0.2;
end

% Set default write behavior
if nargin < 11 || isempty(write)
     write = true;
end

% Set default output path
if nargin < 12 || isempty(path_output)
     path_output = 'D:/University of Edinburgh/Dissertation/data/final_results/skeletons/';
end

% Different limits for person
if contains(bagfile,'person2')
    inf_lim_el = -pi/6;
else
    inf_lim_el = [];
end

if contains(bagfile,'person5')
    inf_lim_el = -pi/8;
    sup_lim_az = pi/12;
else
    inf_lim_el = [];
    sup_lim_az = [];
end

% Different limits for person
if contains(bagfile,'move5') || contains(bagfile,'move6')
    sup_lim_az_relbow = pi/2;
    inf_lim_az_lelbow = -pi/2;
else
    sup_lim_az_relbow = [];
    inf_lim_az_lelbow = [];
end

% Particle filter chest
% best_chest = particle_filter_chest(pcl, centroid_chest);
best_chest = [];

% Particle filter right shoulder
[best_rshoulder, particles_rshoulder, weights_rshoulder] = particle_filter_rshoulder(pcl, ...
    best_chest, centroid_chest, chest2rshoulder, uparm_dist, n_particles, [], move_noise, [], ...
    [], [], [], sup_lim_az, inf_lim_el);

% Particle filter right elbow 
[best_relbow, particles_relbow, weights_relbow] = particle_filter_relbow(pcl, best_rshoulder, ...
    loarm_dist, n_particles, [], move_noise, [], [], [], [], sup_lim_az_relbow);

% Particle filter left shoulder
[best_lshoulder, particles_lshoulder, weights_lshoulder] = particle_filter_lshoulder(pcl, ...
    best_chest, centroid_chest, chest2lshoulder, uparm_dist, n_particles, [], move_noise, [], ...
    [], [], [], [], inf_lim_el);

% Particle filter left elbow 
[best_lelbow, particles_lelbow, weights_lelbow] = particle_filter_lelbow(pcl, best_lshoulder, ...
    loarm_dist, n_particles, [], move_noise, [], [], [], inf_lim_az_lelbow);

% Write results
if write
    save([path_output, bagfile, '_', whichpcl, '_skeleton', '.mat'], 'centroid_chest', ...
        'best_rshoulder', 'best_relbow', 'best_lshoulder', 'best_lelbow', 'particles_rshoulder', ...
        'particles_relbow', 'particles_lshoulder', 'particles_lelbow', 'weights_rshoulder', ...
        'weights_relbow', 'weights_lshoulder', 'weights_lelbow', '-v7.3');
end


