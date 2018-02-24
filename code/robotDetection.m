function [robot, robot_color] = robotDetection(img, depth, kinect, thres, ...
    conn, level, maxpixels, verbose)
%{
    Detects the robot in the foreground without using color but only using 
    depth information.
    
    Detects the robot arm using a region growing method on depth data.

    Inputs:
    - img: RGB color image.
    - depth: depth image.
    - kinect: kinect to be analyzed.
    - thres: threshold to detect a neighbour pixel as part of the region grown.
    - maxpixels: maximum number of pixels of the region growing algorithm.
    - conn: connectivity. it can be 8 or 4. 8 is the default.
    - level: level of the neighbours. Level 1 are neighbours 1 pixel away.
    - verbose: set to true to get the number of the current iteration.

    Returns:
    - robot: final binary mask with the robot.
    - robot_color: final color mask with the robot.
%}

% Set default threshold to minimum subtraction
if nargin < 3 || isempty(thres)
     thres = 50;
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
if nargin < 6 || isempty(maxpixels)
     maxpixels = [50000, 40000, 30000, 30000];
end

% Set default verbose behavior
if nargin < 7 || isempty(verbose)
     verbose = true;
end

% Assign depth to variable
dep = depth;

% Flag to check if person is present
isrobot = 0;

% Initialize mask
mask = logical(zeros(size(dep)));

% Different cases for each kinect
if kinect == 1
%     body_area = dep(1:25,412:425);
    body_area = dep(15:40,240:260);
    if mean(body_area(:)) < 2000
        isrobot = 1;
        mask(15:40,240:260) = 1;
    end        
elseif kinect == 2
%     body_area = dep(117:127,1:15);
    body_area = dep(6:26,261:281);
    if mean(body_area(:)) < 1500
        isrobot = 1;
        mask(6:26,261:281) = 1;
    end          
elseif kinect == 3
    body_area = dep(7:17,285:300);
    if mean(body_area(:)) < 1500
        isrobot = 1;
        mask(7:17,285:300) = 1;
    end         
elseif kinect == 4
    body_area = dep(5:15,307:317);
    if mean(body_area(:)) < 1500
        isrobot = 1;
        mask(5:15,307:317) = 1;
    end  
end

% Finds perimeter of the mask and its indices (the seeds)
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
    central = datasample(indperim,1);
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
    
    if sum(newmask(:)) > maxpixels(kinect)
        break
    end    
end

% Join the blue mask and the region growing mask
robot = mask + logical(newmask);

% Color mask
robot_color = img;
robot_color(repmat(~robot,[1 1 3])) = 0;



