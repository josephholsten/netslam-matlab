function J = dqaqb_dqb(qa)
% DQAQB_DQB Jacobian of quaternion multiplication, with respect to
% the right-side quaternion.
% qa: the left-side quaternion
% J: a 4x4 jacobian

w = qa(1);
x = qa(2);
y = qa(3);
z = qa(4);

J = [w -x -y -z; ...
     x  w -z  y; ...
     y  z  w -x; ...
     z -y  x  w];

end