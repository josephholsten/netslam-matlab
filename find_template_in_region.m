function [x, y, cc] = find_template_in_region(template, image, pos, cov)

% FIXME: finding the max CC in the rectange is not sufficient; matches outside
% of the projected ellipse should be discarded.

if eig(S) < 100
	% TODO: that's too big a region, throw an error
end

h = pos;
S = cov;

half_w = ceil(2 * sqrt(S(1,1)));     % find maximum horizontal bound
half_h = ceil(2 * sqrt(S(2,2)));     % find maximum vertical bound

y0 = max(1, h(2) - half_h);
y1 = min(size(image,1), h(2) + half_h);
x0 = max(1, h(1) - half_w);
x1 = min(size(image, 2), h(1) + half_w);

region = image(y0:y1, x0:x1);
[x, y, cc] = find_template_in_image(template, region);

x = x + x0;
y = y + y0;

% TODO: use the template below and move away from teh built-in
% normxcorr2 function.

%chi_095_2 = 5.9915;
%inv_S = inv(S);
%for x = h(1)-half_w:h(1)+half_w
%	for y = h(2)-half_h:h(2)+half_h
%		p = [x;y] - h;                    % find position in patch-space
%		if ((p' * inv_S * p) < chi_095_2) % make sure point is in search ellipse
%			% TODO
%		end
%	end
%end

end