function qp = qprod(q,p)
	
a = q(1);
v = q(2:4);
x = p(1);
u = p(2:4);

qp = [ a * x - v' * u,  ...
     ( a * u + x  * v)' ...
     + cross(v, u)'  ];