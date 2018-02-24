function [r, idx] = sample(x, n, prob, replace)
%{
    Sample with or without replacement from a set of probabilites.
    It mimics the sample from R.

    Inputs:
    - x: either a vector of one or more elements from which to choose or a
    positive integer. If it's an integer int, x will be considered 1:int.
    - n: a non-negative integer giving the number of items to choose.
    - replace: should sampling be with replacement? NOT IMPLEMENTED. NOW
    ONLY WITH REPLACEMENT.
    - prob: a vector of probability weights for obtaining the elements
    of the vector being sampled. They don't need to sum to one.

    Returns:
    - r: sampled vector.
    - idx: sampled indices.
%}

% If x is integer, create a vector 1:x
if length(x) == 1
    x = 1:x;
end

% Set default size to maximum length of x
if nargin < 2 || isempty(n)
     n = length(x);
end

% Set default prob weights to equal weights
if nargin < 3 || isempty(prob)
     prob = repmat(1/length(x), 1, length(x));
end

% Set default behavior for replace to false
if nargin < 4 || isempty(replace)
     replace = true;
end

% Put prob in correct size
if size(prob, 1) > 1
    prob = prob';
end    

% Turn weights into a normed cumulative sum
weights = cumsum(prob)/sum(prob);
weights = [0 weights(1:end-1)];

% For each value pick a random number and check against weights using
% inversion method
idx = sum(weights <= rand(n,1), 2);

% Get sampled vector based on indices
r = x(idx);