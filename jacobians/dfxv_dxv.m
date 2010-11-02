function J = dfxv_dxv(q,w,t)
% DFXV_DXV Jacobian of state transition with respect to camera state.
% q: camera orientation quaternion
% w: camera angular velocity
% t: time-step

wt = w * t;
display(t);
display(w);
display(wt);

J = eye(13);
J(1:3,8:10) = eye(3);
J(4:7,4:7) = dq_dq(v2q(w * t));
J(4:7,11:13) = dq_dwt(q, w, t);

end

function J = dq_dq(q)

w = q(1);
x = q(2);
y = q(3);
z = q(4);

J = [w -x -y -z; x w z -y; y -z w x; z y -x w];

end