function [person, personnoclean] = personDetection(img, depth, kinect, thres, conn, level, ...
    maxiter, verbose)
%{
    Detects the person in the foreground using color and depth information.
    
    1) First, it detects the blue color of the gown. 
    2) Then, detects the green
    color of the table and sets all corresponding pixels in the depth data
    to zero. 
    3) Finally, uses an optimized region grown algorithm using the depth information.

    Inputs:
    - img: RGB color image.
    - depth: depth image.
    - kinect: kinect to be analyzed.
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

% Set default threshold to minimum subtraction
if nargin < 3 || isempty(thres)
     thres = 100;
end

% Set default connectivity
if nargin < 4 || isempty(conn)
     conn = 8;
end

% Set default neighbourhood level
if nargin < 5 || isempty(level)
     level = 1;
end

% Set default number of maximum iterations
if nargin < 6 || isempty(maxiter)
     maxiter = 50000;
end

% Set default verbose behavior
if nargin < 7 || isempty(verbose)
     verbose = true;
end

% Detect gown using blue color
bmask = blueMask(img);

% Detect gloves using pink color
pmask = pinkMask(img);

% Fuse blue and pink mask
mask = bmask + pmask;

% Detect cloth using green color
gmask = greenMask(img);

% Assign depth to variable
dep = depth;

% DIFFERENT CASES FOR EACH KINECT
% (Because the rgb and the depth images are not perfectly syncronized)
% Also, remove upper and lower border from depth because not available in color
if kinect == 1
    mask = imerode(mask, strel('square',10));
    gmask = imdilate(gmask, strel('square',10));
    dep(1:13,:) = 0;
    dep(381:end,:) = 0;
elseif kinect == 2
    mask = imerode(mask, strel('square',10));
    gmask = imdilate(gmask, strel('square',10));
    dep(1:21,:) = 0;
    dep(395:end,:) = 0;
elseif kinect == 3
    mask = imerode(mask, strel('square',15));
    gmask = imdilate(gmask, strel('square',15));
    dep(1:17,:) = 0;
    dep(384:end,:) = 0;
elseif kinect == 4
    mask = imerode(mask, strel('square',10));
    gmask = imdilate(gmask, strel('square',10));
    dep(1:19,:) = 0;
    dep(389:end,:) = 0;
end

% Remove green cloth from the depth data
dep(find(gmask)) = 0;

% Finds perimeter of the blue mask and its indices (the seeds)
perim = bwperim(mask);
indperim = find(perim);

% Remove zero depth from indices (the seeds)
indperim(find(dep(indperim)==0)) = [];

% Initialize new mask
newmask = zeros(size(mask));

% Store visited pixels
visited = find(mask);

% Save size of the perimeter
sizperim = size(perim);

% Start iteration counter
iter = 0;

% Start region growing algorithm
while ~isempty(indperim)
    % Central pixel to compute 
    central = indperim(1);
    % Compute all neighbours
    allneigh = findNeigh(sizperim, central, conn, level);
    % Compute unvisited neighbours
    unneigh = setdiff(allneigh, visited);
    % Calculate depth difference (put double because matlab uint16 is dumb)
    indclose = abs(double(dep(central)) - double(dep(unneigh))) < thres;
    closeneigh = unneigh(indclose);
    
    % Add new pixel to visited and new mask
    newmask(closeneigh) = 1;
    visited = [visited; closeneigh];
    
    % Add new pixel to seeds
    indperim = [indperim; closeneigh];
    
    % Remove previous pixel from seeds
    indperim(indperim==central) = [];
    
    iter = iter + 1;
    
    if verbose && mod(iter,2000) == 0
        fprintf('Current iteration: %d\n', iter);
    end
    
    if iter > maxiter
        break
    end    
end

% Join the blue mask and the region growing mask
personnoclean = mask + logical(newmask);

% DIFFERENT CASES FOR EACH KINECT
% Morphological transformations
person = personnoclean;
% Close operation
if kinect == 1
    person = imdilate(person, strel('square',5));
    person = imerode(person, strel('square',5));
elseif kinect == 2
    person = imdilate(person, strel('square',5));
    person = imerode(person, strel('square',5));
elseif kinect == 3
    person = imdilate(person, strel('square',5));
    person = imerode(person, strel('square',5));
elseif kinect == 4
    person = imdilate(person, strel('square',5));
    person = imerode(person, strel('square',5));
end