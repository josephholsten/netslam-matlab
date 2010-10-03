function [Y] = make_not_homogeneous(X)

H = X(end,:);

Y = X(1:end-1,:);

H = repmat(H, size(Y,1), 1);

Y = Y ./ H;

end