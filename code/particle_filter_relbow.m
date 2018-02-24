function [best_relbow_global, particlescart_global, weights, elapsed_time] = particle_filter_relbow(...
    mergedpcl, best_rshoulder, bone_dist, n_particles, init_noise, move_noise, obs_noise, ...
    az_init, el_init, inf_lim_az, sup_lim_az, inf_lim_el, sup_lim_el, ...
    min_part, max_part, cylinder_elbow, verbose)
%{
    Particle filter of the right elbow.

    Inputs:
    - mergedpcl: merged point cloud with the four kinects.
    - best_rshoulder: best particles of right shoulder to use as starting particles for the elbow.
    - n_particles: number of particles in the particle filter.
    - init_noise: noise to generate the initial particles.
    - move_noise: noise of the motion model of the particle filter.
    - obs_noise: noise of the observation model of the particle filter.
    - bone_dist: default distance of the humerus.
    - az_init: azimuth angle of the initial pose.
    - el_init: elevation angle of the initial pose.
    - inf_lim_az: inferior kinematic limit for the azimuth.
    - sup_lim_az: superior kinematic limit for the azimuth.
    - inf_lim_el: inferior kinematic limit for the elevation.
    - sup_lim_el: inferior kinematic limit for the elevation.
    - min_part: minimum number of particles to be considered a limb.
    - max_part: maximum number of particle admitted inside the model cylinder.
    - cylinder_shoulder: 2-dim vector with the x and y semiradius of the model cylinder.
    - verbose: if true outputs the number of actual particle.
    
    Returns:
    - best_rshoulder_global: best particle for each frame in cartesian coordinates.
    - particlescart_global: all the 3-dim particles for every frame in cartesian coordinates.
    - weights: weights of each particle.
    - elapsed_time: time employed to run the whole function.
%}

% Start timer
tic

% Set default bone distance (in meters)
if nargin < 3 || isempty(bone_dist)
     bone_dist = 0.27;
end

% Set default number of particles
if nargin < 4 || isempty(n_particles)
     n_particles = 50;
end

% Set default initial noise of particles
if nargin < 5 || isempty(init_noise)
     init_noise = 0.05;
end

% Set default motion noise of particles
if nargin < 6 || isempty(move_noise)
     move_noise = 0.2;
end

% Set default observation noise of particles
if nargin < 7 || isempty(obs_noise)
     obs_noise = 0.5;
end

% Set default initial azimuth 
if nargin < 8 || isempty(az_init)
     az_init = 0;
end

% Set default initial elevation 
if nargin < 9 || isempty(el_init)
     el_init = 0;
end

% Set default initial noise of particles
if nargin < 10 || isempty(inf_lim_az)
     inf_lim_az = -pi/2;  % 1.2 degrees approx.
end

% Set default motion noise of particles
if nargin < 11 || isempty(sup_lim_az)
     sup_lim_az = pi/4;
end

% Set default observation noise of particles
if nargin < 12 || isempty(inf_lim_el)
     inf_lim_el = -pi/2;
end

% Set default observation noise of particles
if nargin < 13 || isempty(sup_lim_el)
     sup_lim_el = pi/2;
end

% Set default number of points to conclude there is no limb
if nargin < 14 || isempty(min_part)
     min_part = 200;
end

% Set default distance to ignore points
if nargin < 15 || isempty(max_part)
     max_part = 10000;
end

% Set default elliptical cylinder chest
if nargin < 16 || isempty(cylinder_elbow)
     cylinder_elbow = [0.05, 0.05];
     x_semiradius = cylinder_elbow(1);
     y_semiradius = cylinder_elbow(2);
end

% Set default behavior of verbose
if nargin < 17 || isempty(verbose)
     verbose = true;
end

% Position of the right elbow at every frame
elbow = best_rshoulder;

% Change origin of point cloud to elbow
pcElbow = mergedpcl;
for tt = 1:length(mergedpcl)
    newLoc = mergedpcl{tt}.Location - elbow(:,tt)';
    pcElbow{tt} = pointCloud(newLoc,'Color',mergedpcl{tt}.Color);
end

% Initial angles, azimuth and elevation
angles_init = [az_init, el_init];

% Number of dimensions (azimuth and elevation)
n_dim = 2;

% Number of frames
n_frames = length(mergedpcl);

% Initialize particles and weights to zero
particles = zeros(n_dim, n_particles, n_frames);
particlescart = zeros(n_dim+1, n_particles, n_frames);
weights = zeros(n_particles, n_frames);

% Initialize first frame weights to 1/N
weights(:,1) = 1/n_particles;

% Initialize first frame particles based on initial azimuth and elevation
% init = unifrnd(repmat(([inf_lim_az inf_lim_el])', 1, n_particles), ...
%     repmat(([sup_lim_az sup_lim_el])', 1, n_particles));

% Initialize first frame particles based on initial azimuth and elevation
% with gaussian
init = normrnd(repmat(([az_init el_init])', 1, n_particles), ...
    repmat(([init_noise init_noise])', 1, n_particles));

% Restrict azimuth between -pi/2 and pi/2 anmd
ind_bad_neg_az = find(init(1,:) < inf_lim_az);
ind_bad_pos_az = find(init(1,:) > sup_lim_az);
init(1,ind_bad_neg_az) = inf_lim_az;
init(1,ind_bad_pos_az) = sup_lim_az;

% Restrict elevation between -pi/2 and pi/2
ind_bad_neg_el = find(init(2,:) < inf_lim_el);
ind_bad_pos_el = find(init(2,:) > sup_lim_el);
init(2,ind_bad_neg_el) = inf_lim_el;
init(2,ind_bad_pos_el) = sup_lim_el;

% Assign particles
particles(:,:,1) = init;
[x, y, z] = sph2cart(particles(1,:,1), particles(2,:,1), repmat(bone_dist, 1, n_particles));
% Fix first particle to real wrist (to keep track of it and test)
particles(:,1,1) = [az_init, el_init];
[x_first, y_first, z_first] = sph2cart(particles(1,1,1), particles(2,1,1), bone_dist);

% Assign all cartesian particles
particlescart(:,:,1) = [x; y; z];
% Assign first cartesian particle
particlescart(:,1,1) = [x_first; y_first; z_first];

% Run particle filter for every frame
for t = 2:n_frames
    % Verbose or not
    if verbose
        fprintf('Right elbow frame - %d\n', t);
    end
    
    % Get only 5 best particles
    n_best_weights = 5;
    [max_weights, ind_max_weights] = sort(weights(:,t-1),'descend');
    best_particles = particles(:,ind_max_weights(1:n_best_weights),t-1);
    
    % Draw particles with replacement using weights of t-1
    drawn_particles = datasample(best_particles,n_particles,2,'Weights',max_weights(1:n_best_weights));
    
    % Motion model
    motion_dist = normrnd(0, move_noise, n_dim, n_particles);
    moved_particles = drawn_particles + motion_dist;

    % Restrict azimuth between -pi/2 and pi/2 anmd
    ind_bad_neg_az = find(moved_particles(1,:) < inf_lim_az);
    ind_bad_pos_az = find(moved_particles(1,:) > sup_lim_az);
    moved_particles(1,ind_bad_neg_az) = inf_lim_az;
    moved_particles(1,ind_bad_pos_az) = sup_lim_az;

    % Restrict elevation between -pi/2 and pi/2
    ind_bad_neg_el = find(moved_particles(2,:) < inf_lim_el);
    ind_bad_pos_el = find(moved_particles(2,:) > sup_lim_el);
    moved_particles(2,ind_bad_neg_el) = inf_lim_el;
    moved_particles(2,ind_bad_pos_el) = sup_lim_el;
    
    % Assign moved particles
    particles(:,:,t) = moved_particles;
    
    % Calculate cartesian elbow point
    [x, y, z] = sph2cart(particles(1,:,t), particles(2,:,t), repmat(bone_dist, 1, n_particles));
    particlescart(:,:,t) = [x; y; z];

    % Observation model
    for p = 1:n_particles
        if mod(p, 10) == 0 && verbose
            fprintf('Right elbow particle - %d\n', p);
        end
                
        % Change axis z to the bone (axis from shoulder to elbow)
        rot = vrrotvec(particlescart(:,p,t), [0, 0, 1]);
        rotm = vrrotvec2mat(rot);

        aux_rot = rotm * pcElbow{t}.Location';
        aux_col = pcElbow{t}.Color;
        pcElbowRot = pointCloud(aux_rot','Color',aux_col);
                
        % Take only points in the point cloud inside the cylinder z-axis range
        ind_cyl = findPointsInROI(pcElbowRot, ...
            [-inf, inf; -inf, inf; 0, bone_dist]);
        pcObs = select(pcElbowRot, ind_cyl);
        ins_cyl = find(pcObs.Location(:,1).^2/x_semiradius.^2 + pcObs.Location(:,2).^2/y_semiradius.^2 < 1);
        pcObs = pointCloud(pcObs.Location(ins_cyl,:),'Color',pcObs.Color(ins_cyl,:));
        
        % Observation model (number of points)
        weights(p,t) = pcObs.Count;
        
        % If not enough points, there is no limb
        if pcObs.Count < min_part
            particlescart(:,p,t) = [NaN; NaN; NaN];
        end
    end
    % Set to zero weights of particles with many points inside the cylinder
    weights(find(weights(:,t) > max_part),t) = 0;    
    
    % Normalize weights to get probabilities (check if all weights are zero)
    if sum(weights(:,t)) == 0
        weights(:,t) = 1/n_particles;
    else
        weights(:,t) = weights(:,t) / sum(weights(:,t));
    end
end

% Get the maximum weight in every frame as the centroid
[~,ind_best_relbow] = max(weights, [], 1);
best_relbow = zeros(n_dim+1, n_frames);
for f = 1:n_frames
    best_relbow(:,f) = particlescart(:,ind_best_relbow(f),f);
end

% Get back to global coordinate system
particlescart_global = particlescart;
for tt = 1:length(mergedpcl)
    particlescart_global(:,:,tt) = particlescart(:,:,tt) + elbow(:,tt);
end
best_relbow_global = best_relbow + elbow;

% Save elapsed time
elapsed_time = toc;







