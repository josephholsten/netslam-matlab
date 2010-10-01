function [p] = ahp_to_euclidean(ahp)
% AHP_TO_EUCLIDEAN converts anchored-homogeneous-point to euclidean point
% p = ahp_to_euclidean([a h q])
% a: anchor-point as euclidean 3-vector
% h: direction vector, not necessarily normalized
% q: inverse distance over magnitude of h
% p: resolved euclidean point

a = ahp(1:3);  % anchor point
h = ahp(4:6);  % direction vector (not necessarily normalized)
q = ahp(7);    % inverse distance (sort of)
p = a + h * q; % resolve point

end