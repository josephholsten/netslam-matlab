function J = dq_dwt(q, w, t)
% DQ_DWT Jacobian of quaternion multiplied by rotation over time.
% q: quaternion
% w: angular velocity
% t: time-step

J = dq_dq(q) * dqwt_dw(w, t);

end

function J = dq_dq(q)

w = q(1);
x = q(2);
y = q(3);
z = q(4);

J = [w -x -y -z; x w -z y; y z w -x; z -y x w];

end