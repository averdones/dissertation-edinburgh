function [person, personnoclean] = personDetectionAllFrames(cam, dm, kinects, frames, ...
    thres, conn, level, maxiter, verbose)
%{
    Detects the person in the foreground using color and depth information.
    
    1) First, it detects the blue color of the gown. 
    2) Then, detects the green
    color of the table and sets all corresponding pixels in the depth data
    to zero. 
    3) Finally, uses an optimized region grown algorithm using the depth information.

    Inputs:
    - cam: cell with all the RGB color images.
    - dm: cell with all the depth images.
    - kinects: kinects to be analyzed.
    - frames: frames to analyze. Vector of 4 elements. If less than 4
    kinects are used, the corresponding frames are ignored but 'frames'
    needs to be 4-dimensional anyway.
    - thres: threshold to detect a neighbour pixel as part of the region
    grown.
    - maxiter: maximum number of iterations of the region growing
    algorithm.
    - conn: connectivity. it can be 8 or 4. 8 is the default.
    - level: level of the neighbours. Level 1 are neighbours 1 pixel away.
    - verbose: set to true to get the number of the current iteration.

    Returns:
    - personmaskclean: final mask with the person after morphological
    operations.
    - personmask: final mask with the person before morphological
    operations.
%}

% Set default kinects
if nargin < 3 || isempty(kinects)
     kinects = 1:4;
end

% Set default frames
if nargin < 4 || isempty(frames)
    frames = zeros(1, length(cam));
    for i = 1:length(cam)
        frames(i) = length(cam{i});
    end
end

% Set a default threshold for every kinect
if nargin < 5 || isempty(thres)
    thres = [100, 100, 100, 350];
end

% Set a default level for every kinect
if nargin < 6 || isempty(level)
    level = [1, 1, 1, 1];
end

% Set default verbose behavior
if nargin < 7 || isempty(verbose)
     verbose = true;
end

% If frames is a number, replicate 4 times
if length(frames) < 4
    frames = repmat(frames(1), 1, 4);
end

% If threshold is a number, replicate 4 times
if length(thres) < 4
    thres = repmat(thres(1), 1, 4);
end

% If level is a number, replicate 4 times
if length(level) < 4
    level = repmat(level(1), 1, 4);
end

% Restrict frames to the maximum possible
for i = 1:length(cam)
    if frames(i) > length(cam{i})
        frames(i) = length(cam{i});
    end
end

% Detect the person in every frame for all kinects
for ki = kinects
    if verbose
        fprintf('Kinect number: %d\n', ki);
    end
    for t = 1:frames(ki)
        if verbose
            fprintf('Frame - %d\n', t);
        end
        [person{ki}{t}, personnoclean{ki}{t}] = personDetection(cam{ki}{t}, dm{ki}{t}, ki, ...
            thres(ki), conn, level(ki), maxiter, verbose);
    end
end



    











