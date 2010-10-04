function advance_model(dt)

cam_p = cam_p + cam_v * dt;
cam_q = qprod(cam_q, v2q(cam_w * dt));

end