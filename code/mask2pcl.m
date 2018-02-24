function [pclperson, indices2pcl] = mask2pcl(person, pcl)
%{
    Creates point clouds based on a mask and save the indices to be able to
    come back to the image.

    Inputs:
    - person: mask of the person. Cell of size 4.
    - pcl: original point clouds from the kinects. Cell of size 4.

    Returns:

%}

% Calculate linear indices to pcl
for ki = 1:length(person)
    for t = 1:length(person{ki})
        % Transpose mask and compute indices
        aux = person{ki}{t}';
        aux = aux(:);
        indices2pcl{ki}{t} = find(aux);
    
        % Calculate new point cloud
        ind = indices2pcl{ki}{t};
        pc = pcl{ki}{t};
        x = pc.Location(ind,1);
        y = pc.Location(ind,2);
        z = pc.Location(ind,3);
        r = pc.Color(ind,1);
        g = pc.Color(ind,2);
        b = pc.Color(ind,3);
        xyz = [x y z];
        rgb = [r g b];

        % Save new point cloud
        pclperson{ki}{t} = pointCloud(xyz,'Color',rgb);
    end
end
        
        
        
        
        
        
        