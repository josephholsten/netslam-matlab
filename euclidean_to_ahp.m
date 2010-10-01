function ahp = euclidean_to_ahp(p, a)
% EUCLIDEAN_TO_AHP converts a euclidean point to anchored-homogeneous-point form, using
% the optionally provided anchor point (defaults to the origin [0 ...]).
% [a h q] = euclidean_to_ahp(p, [a = [0 ...]])
% p: point in euclidean coordinates
% a: optional anchor point (defaults to origin [0 ...])
% h: direction vector (not normalized; initialized to p - a)
% q: inverse distance over magnitude of h (always initialized to 1)

if nargin < 2
	a = zeros(size(p));
end

ahp = [a; (p - a); 1];

end