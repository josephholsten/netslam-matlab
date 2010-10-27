function [x, y, m, cc, found] = find_template_in_region(template, image, pos, cov, threshold)

% FIXME: finding the max CC in the rectange is not sufficient; matches outside
% of the projected ellipse should be discarded.

chi_095_2 = 5.9915;
S = cov;
Si = inv(S);
h = pos;
x = 0;
y = 0;
cc = 0;

if eig(S) > 100
  display('search ellipse too big');
  found = false;
  return;
end

half_w = 2 * sqrt(S(1,1));     % find maximum horizontal bound
half_h = 2 * sqrt(S(2,2));     % find maximum vertical bound

y0 = max(1, floor(h(2) - half_h));
y1 = min(size(image, 1), ceil(h(2) + half_h));
x0 = max(1, floor(h(1) - half_w));
x1 = min(size(image, 2), ceil(h(1) + half_w));

region = image(y0:y1, x0:x1);
cc = normxcorr2(template, region);
strip = floor(size(template,1)/2);
cc = cc(strip+1:end-strip,strip+1:end-strip);

for i = 1:size(cc,1)
for j = 1:size(cc,2)
  uv = [i + x0 - 1; j + y0 - 1];
  nu = uv - h;
  if (nu' * Si * nu) > chi_095_2
    cc(i,j) = 0;
  end
end
end

[m,idx] = max(cc(:));
[y,x] = ind2sub(size(cc),idx);
y = y + y0 - 1;
x = x + x0 - 1;

nu = [x; y] - h;
if (nu' * Si * nu) > chi_095_2
  display('Found point, but outside ellipse!');
  display(nu);
  found = false;
  return;
end

found = (m >= threshold);

end