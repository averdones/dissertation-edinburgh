function [best_chest, particles, weights, elapsed_time] = particle_filter_chest(mergedpcl, ...
    centroid_chest, n_particles, init_noise, move_noise, obs_noise, box_chest, cyl_head, verbose)
%{
    Particle filter of the chest.

    Inputs:
    - mergedpcl: merged point cloud with the four kinects.
    - centroid_chest: 3-dimensioanl point corresponding to the chest joint.
    - n_particles: number of particles in the particle filter.
    - init_noise: initial noise in the particles.
    - move_nosie: noise for the motion model of the particles.
    - obs_noise: noise for the observation model of the particles.
    - box_chest: dimensions of the box shape for the chest. 6-dim vector.
    - cyl_head: semiradius for the cylinder of the head. 2-dim vector.
    - verbose: if true outputs the number of actual particle.
    
    Returns:
    - best_chest: best particle for each frame.
    - particles: all the particles for every frame.
    - weights: weights of each particle.
    - elapsed_time: time employed to run the whole function.
%}

% Start timer
tic

% Set default number of particles
if nargin < 3 || isempty(n_particles)
     n_particles = 50;
end

% Set default initial noise of particles
if nargin < 4 || isempty(init_noise)
     init_noise = 0.02;
end

% Set default motion noise of particles
if nargin < 5 || isempty(move_noise)
     move_noise = 0.01;
end

% Set default observation noise of particles
if nargin < 6 || isempty(obs_noise)
     obs_noise = 0.5;
end

% Set default box chest
if nargin < 7 || isempty(box_chest)
    box_chest = [0.2, 0.13, 0.19, 0.19, 0.35, 0.15];
    x_lim_left = box_chest(1);
    x_lim_right = box_chest(2);
    y_lim_left = box_chest(3);
    y_lim_right = box_chest(4);
    z_lim_down = box_chest(5);
    z_lim_up = box_chest(6);
end

% Set default head cylinder
if nargin < 8 || isempty(cyl_head)
    cyl_head = [0.12, 0.12];
    x_semiradius = cyl_head(1);
    y_semiradius = cyl_head(2);
end

% Set default behavior of verbose
if nargin < 9 || isempty(verbose)
    verbose = true;
end

% Number of dimensions (3-dim)
n_dim = length(centroid_chest);

% Number of frames
n_frames = length(mergedpcl);

% Initialize particles and weights to zero
particles = zeros(n_dim, n_particles, n_frames);
weights = zeros(n_particles, n_frames);

% Initialize first frame weights to 1/N
weights(:,1) = 1/n_particles;

% Initialize first frame particles close to the chest
init = unifrnd(repmat((centroid_chest - init_noise)', 1, n_particles), ...
    repmat((centroid_chest + init_noise)', 1, n_particles));
particles(:,:,1) = init;
% Move only in the y-axis (so fix x-axis and z-axis)
particles(1,:,1) = centroid_chest(1);
particles(3,:,1) = centroid_chest(3);

% Fix first particle to real centroid chest (to keep track of it and test)
particles(:,1,1) = centroid_chest';

% Run particle filter for every frame
for t = 2:n_frames
    % Verbose or not
    if verbose
        fprintf('Chest particle - %d\n', t);
    end
        
    % Draw particles with replacement using weights of t-1
    drawn_particles = datasample(particles(:,:,t-1),n_particles,2,'Weights',weights(:,t-1));
    
    % Motion model
    motion_dist = normrnd(0, move_noise, n_dim, n_particles);
    particles(:,:,t) = drawn_particles + motion_dist;
    % Move only in the y-axis (so fix x-axis and z-axis)
    particles(1,:,t) = centroid_chest(1);
    particles(3,:,t) = centroid_chest(3);
    
    % Observation model
    for p = 1:n_particles
        if mod(p, 10) == 0 && verbose
            fprintf('Chest particle - %d\n', p);
        end
        
        % Take points in the point cloud inside the chest box
        ind_box_chest = findPointsInROI(mergedpcl{t}, ...
            [particles(1,p,t) - x_lim_left, particles(1,p,t) + x_lim_right; ...
            particles(2,p,t) - y_lim_left, particles(2,p,t) + y_lim_right; ...
            particles(3,p,t) - z_lim_down, particles(3,p,t) + z_lim_up]);
        pcChest = select(mergedpcl{t}, ind_box_chest);
        
        % Take points in the point cloud inside the head cylinder
        ind_cyl_head = find((mergedpcl{t}.Location(:,1)-particles(1,p,t)).^2/x_semiradius.^2 + ...
            (mergedpcl{t}.Location(:,2)-particles(2,p,t)).^2/y_semiradius.^2 < 1 & ...
            mergedpcl{t}.Location(:,3) >= particles(3,p,t) + z_lim_up);
        pcHead = pointCloud(mergedpcl{t}.Location(ind_cyl_head,:),'Color',mergedpcl{t}.Color(ind_cyl_head,:));
        
        % Observation model (number of points)
        weights(p,t) = pcChest.Count + pcHead.Count;
    end
    % Normalize weights to get probabilities
    weights(:,t) = weights(:,t) / sum(weights(:,t));
end

% Get the maximum weight in every frame as the centroid
[~,ind_best_chest] = max(weights, [], 1);
best_chest = zeros(n_dim, n_frames);
for f = 1:n_frames
    best_chest(:,f) = particles(:,ind_best_chest(f),f);
end

% Save elapsed time
elapsed_time = toc;










