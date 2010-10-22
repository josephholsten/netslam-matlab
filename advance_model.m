function advance_model(dt)
global cam_p
global cam_q
global cam_v
global cam_w
global cam_P

cam_p = cam_p + cam_v * dt;
cam_q = qprod(cam_q, v2q(cam_w * dt));

end
