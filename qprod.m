function qp = qprod(q,p)
% QPROD Multiply quaternions
% q: first quaternion
% p: second quaternion
% qp: product of quaternions
	
a = q(1);
v = q(2:4);
x = p(1);
u = p(2:4);

qp = [ a * x - v' * u,  ...
     ( a * u + x  * v)' ...
     + cross(v, u)'  ];