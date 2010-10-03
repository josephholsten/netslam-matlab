function [Y] = make_homogeneous(X)

Y = [X; ones(1,size(X,2))];

end