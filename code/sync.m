function [a_sync, b_sync, a_ind, b_ind] = sync(a, b, thres)
%{
    Synchronize two vectors. Used to synchronize the color and depth (or
    point cloud) messages.

    Inputs:
    - a: first vector.
    - b: second vector.

    Returns:
    - a_sync: vector a with only the synchronized elements.
    - b_sync: vector b with only the synchronized elements.
    - a_ind: indices of synchronized elements of a.
    - b_ind: indices of synchronized elements of b.
%}

% Threshold of unacceptable pairs
if nargin < 3 || isempty(thres)
     thres = 0.3;
end

% Write the shortest vector in b
swap = false;
if length(a) < length(b)
    swap = true;
    aux = a;
    a = b;
    b = aux;
end

% Synchronize vectors (also possible with pdist2)
a_ind = zeros(1, length(b));
b_ind = zeros(1, length(b));
a_low = 1;
for i = 1:length(b)
    [m, m_i] = min(abs(a(a_low:end) - b(i)));    
    % Keep only close values
    if m < thres
        a_ind(i) = m_i + a_low - 1;
        b_ind(i) = i;
        a_low = a_ind(i) + 1;
        % Break if exceed dimensions of a or b
        if a_low > length(a)
            break
        end
    end
end

% Remove zeros in case of early break or skipped elements
a_ind(a_ind==0) = [];
b_ind(b_ind==0) = [];

% Build synchronized vectors
a_sync = a(a_ind);
b_sync = b(b_ind);

% Reorder if a and b were swapped
if swap
    % Swap vectors
    aux1 = a_sync;
    a_sync = b_sync;
    b_sync = aux1;
    % Swap indices
    aux2 = a_ind;
    a_ind = b_ind;
    b_ind = aux2;
end
    


