function J = davison_dhu_dhd(d, f, c, k)
% DHU_DHD Jacobian of undistorted image coordinates (DAVISON's version)
% with respsect to distorted image coordinates.
% d: distorted coordinates
% c: camera image center
% k: distortion coefficients
% J: 2x2 jacobian

Cx=c(1);
Cy=c(2);
k1=k(1);
k2=k(2);
dx=1;
dy=1;
uvd = d;

% BEGIN davison original code
ud=uvd(1);
vd=uvd(2);
xd=(uvd(1)-Cx)*dx;
yd=(uvd(2)-Cy)*dy;
  
rd2=xd*xd+yd*yd;
rd4=rd2*rd2;
     
uu_ud=(1+k1*rd2+k2*rd4)+(ud-Cx)*(k1+2*k2*rd2)*(2*(ud-Cx)*dx*dx);
vu_vd=(1+k1*rd2+k2*rd4)+(vd-Cy)*(k1+2*k2*rd2)*(2*(vd-Cy)*dy*dy);
    
uu_vd=(ud-Cx)*(k1+2*k2*rd2)*(2*(vd-Cy)*dy*dy);
vu_ud=(vd-Cy)*(k1+2*k2*rd2)*(2*(ud-Cx)*dx*dx);
     
J_undistor=[uu_ud uu_vd;vu_ud vu_vd];
% END davison original code

J = J_undistor;