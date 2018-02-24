function person = personDetectionAllFramesNoColorBack(dm, thres, kinects)
%{
    Compute the mask with the person using only background subtraction with
    depth infromation.
    It is used only when no blue gown or pink gloves available.
    It needs a first frame with the person far from the doctor location.

    Inputs:
    - dm: cell with all the depth images.
    - thres: threshold for the depth background subtraction. 4-dim vector.
    - kinects: kinects to be analyzed.
    
    Returns:
    - person: final mask with the person after morphological operations.
    
%}

% Set default kinects
if nargin < 3 || isempty(kinects)
     kinects = 1:4;
end

% Set default kinects
if nargin < 4 || isempty(thres)
     thres = [100, 100, 50, 50];
end

% Set default frames
if nargin < 5 || isempty(frames)
    frames = zeros(1, length(dm));
    for i = 1:length(dm)
        frames(i) = length(dm{i});
    end
end

% If frames is a number, replicate 4 times
if length(frames) < 4
    frames = repmat(frames(1), 1, 4);
end

% If threshold is a number, replicate 4 times
if length(thres) < 4
    thres = repmat(thres(1), 1, 4);
end

% Create new depth variable
dep = dm;

% Set all depth zero values to Inf
for ki = kinects
    for t = 1:frames(ki)
        dep{ki}{t}(find(dep{ki}{t} == 0)) = Inf;
        % Correction: set values greater than some value to Inf
        if ki == 1
            dep{ki}{t}(find(dep{ki}{t} > 1700)) = Inf;            
        elseif ki == 2
            dep{ki}{t}(find(dep{ki}{t} > 1700)) = Inf;
        elseif ki == 3
            dep{ki}{t}(find(dep{ki}{t} > 2500)) = Inf;
            dep{ki}{t}(find(dep{ki}{t} < 1500)) = Inf;
        elseif ki == 4
            dep{ki}{t}(find(dep{ki}{t} > 2500)) = Inf;
        end            
    end
    % Set background frame for every kinect
    back{ki} = dep{ki}{1};
end

% Define small parts to remove for each kinect after closing operation
rem_small = [1000, 1000, 6000, 2000]; 

% Calculate person mask
for ki = kinects
    for t = 1:frames(ki)
        % Do background subtraction
        BW = back{ki} - dep{ki}{t} > thres(ki);
        % Close operation
        % Erode to remove small noise
        BW = imerode(BW, strel('square',2));
        % Dilate to get back eroded shape
        BW = imdilate(BW, strel('square',3));
        % Remove small parts
        BW = bwareaopen(BW, rem_small(ki));
        % Select largest object
        labeled = bwlabel(BW, 4);
        stats = regionprops(labeled);
        % Get the two largets blobs if visible (the two gloves)
        [~, maxid] = sort([stats.Area]);
        % If maxid empty is because no person detected
        if isempty(maxid)
            person{ki}{t} = labeled;
        else
            person{ki}{t} = ismember(labeled, maxid);
        end
    end
end