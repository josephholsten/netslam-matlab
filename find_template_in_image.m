function [x, y, cc] = find_template_in_image(template, image)

CC = normxcorr2(template, image);
[cc, imax] = max(abs(CC(:)));
[y, x] = ind2sub(size(CC), imax(1));
y = y - size(template, 1);
x = x - size(template, 2);

end