function neigh = findNeigh(siz,ind,conn,level)
%{
    Find the indices of the 8 neighbours of a pixel.

    Inputs:
    - siz: size of the array.
    - ind: index of the pixel.
    - conn: connectivity. it can be 8 or 4. 8 is the default.
    - level: level of the neighbours. Level 1 are neighbours 1 pixel away.

    Returns:
    - neigh: vector containing the indices of all the neighbours available
    (excluding out of image pixels).
%}

% Set default connectivity and restrict to 4 or 8
if nargin < 3 || isempty(conn) || conn ~=4 && conn ~= 8
     conn = 8;
end

% Set default level to 1
if nargin < 4 || isempty(level) || level <= 0
     level = 1;
end

% Convert indices to subscripts 
[r,c] = ind2sub(siz,ind);

% Find neighbours indices
if conn == 8
    neigh = [r-level,c-level;
        r,c-level;
        r+level,c-level;
        r-level,c;
        r+level,c;
        r-level,c+level;
        r,c+level;
        r+level,c+level];
elseif conn == 4
    neigh = [r,c-level;
        r-level,c;
        r+level,c;
        r,c+level];
end    

% Remove invalid indices
neigh(any(neigh<=0 | neigh(:,1) > siz(1) | neigh(:,2) > siz(2),2),:) = [];

% Convert subscripts to indices
neigh = sub2ind(siz,neigh(:,1),neigh(:,2));






