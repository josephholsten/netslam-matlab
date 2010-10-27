function J = dq_dwt(q, w, t)
% DQ_DWT Jacobian of quaternion multiplied by rotation over time.
% q: quaternion
% w: angular velocity
% t: time-step

J = dqaqb_dqb(q) * dqwt_dw(w, t);

end

