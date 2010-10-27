function test_find_template_in_region

model = SlamModel();

chi_095_2 = 5.9915;
r = 7;
n = r * r / chi_095_2;
S = n * eye(2);
fsz = 40;
tsz = 10;
c = [fsz/2+1; fsz/2+1];
threshold = 0.8;

% found case
I = rand(fsz+1,fsz+1);
T = rand(tsz+1,tsz+1);
uv = c;
I(uv(2)-tsz/2:uv(2)+tsz/2,uv(1)-tsz/2:uv(1)+tsz/2) = T / 2;
uv = c;
[x, y, m, cc, found] = find_template_in_region(T, I, uv, S, threshold);
assertEqual(found, true);
assertEqual(c, [x; y]);

% not found case
I = rand(fsz+1,fsz+1);
T = rand(tsz+1,tsz+1);
uv = [fsz+1; fsz+1];
I(uv(2)-tsz/2:uv(2)+tsz/2,uv(1)-tsz/2:uv(1)+tsz/2) = T / 2;
uv = c;
[x, y, m, cc, found] = find_template_in_region(T, I, uv, S, threshold);
assertEqual(found, false);

% edge case: just inside ellipse
I = rand(fsz+1,fsz+1);
T = rand(tsz+1,tsz+1);
uv = c + [r; 0];
I(uv(2)-tsz/2:uv(2)+tsz/2,uv(1)-tsz/2:uv(1)+tsz/2) = T / 2;
uv2 = c + [0; 0];
[x, y, m, cc, found] = find_template_in_region(T, I, uv2, S, threshold);
assertEqual(found, true);
assertEqual(uv, [x;  y]);

% edge case: just outside ellipse
I = rand(fsz+1,fsz+1);
T = rand(tsz+1,tsz+1);
uv = c - [r+1; 0];
I(uv(2)-tsz/2:uv(2)+tsz/2,uv(1)-tsz/2:uv(1)+tsz/2) = T / 2;
uv = c;
[x, y, m, cc, found] = find_template_in_region(T, I, uv, S, threshold);
assertEqual(found, false);

% weird case: fun!
I = rand(fsz+1,fsz+1);
T = rand(tsz+1,tsz+1);
S = [n n/4; n/4 n];
uv = c;
I(uv(2)-tsz/2:uv(2)+tsz/2,uv(1)-tsz/2:uv(1)+tsz/2) = T / 2;
uv = c;
[x, y, m, cc, found] = find_template_in_region(T, I, uv, S, threshold);
assertEqual(found, true);
assertEqual(uv, [x;  y]);

end