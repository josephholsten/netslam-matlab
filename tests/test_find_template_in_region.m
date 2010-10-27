function test_find_template_in_region

model = SlamModel();

S = 5 * eye(2);
T = [0 1 0; 1 2 1; 0 1 0];
c = [11; 11];

% found case
I = rand(21, 21);
uv = c;
I(uv(2)-1:uv(2)+1,uv(1)-1:uv(1)+1) = T / 2;
[x, y, m, cc, found] = find_template_in_region(T, I, c, S, 0.9);
assertEqual(found, true);
assertEqual(c, [x; y]);
assertElementsAlmostEqual(m, 1.0);

% not found case
I = rand(21, 21);
uv = [6; 6];
I(uv(2)-1:uv(2)+1,uv(1)-1:uv(1)+1) = T / 2;
[x, y, m, cc, found] = find_template_in_region(T, I, c, S, 0.9);
assertEqual(found, false);

% edge case: just inside ellipse
I = rand(21, 21);
uv = [7; 11];
I(uv(2)-1:uv(2)+1,uv(1)-1:uv(1)+1) = T / 2;
[x, y, m, cc, found] = find_template_in_region(T, I, c, S, 0.9);
assertEqual(found, true);
assertEqual(uv, [x;  y]);
assertElementsAlmostEqual(m, 1.0);

% edge case: just outside ellipse
I = rand(21, 21);
uv = [6; 11];
I(uv(2)-1:uv(2)+1,uv(1)-1:uv(1)+1) = T / 2;
[x, y, m, cc, found] = find_template_in_region(T, I, c, S, 0.9);
assertEqual(found, false);

end