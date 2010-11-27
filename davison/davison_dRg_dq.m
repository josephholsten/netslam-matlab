function J = davison_dRg_dq(g, q)
% DRG_DQ Jacobian of a rotated vector with respect to
% a rotation quaternion. (DAVISON's version)
% g: unrotated point
% q: rotation quaternion
% J: 3x4 jacobian

aMat = g;

  dRq_times_a_by_dqRES=zeros(3,4);
  
  TempR = dR_by_dq0(q);
  Temp31 = TempR * aMat;
  dRq_times_a_by_dqRES(1:3,1)=Temp31;

  TempR = dR_by_dqx(q);
  Temp31 = TempR * aMat;
  dRq_times_a_by_dqRES(1:3,2)=Temp31;

  TempR = dR_by_dqy(q);
  Temp31 = TempR * aMat;
  dRq_times_a_by_dqRES(1:3,3)=Temp31;

  TempR = dR_by_dqz(q);
  Temp31 = TempR * aMat;
  dRq_times_a_by_dqRES(1:3,4)=Temp31;
  
  J = dRq_times_a_by_dqRES;
  
return

 
function dR_by_dq0RES=dR_by_dq0(q)
  q0 = q(1);
  qx = q(2);
  qy = q(3);
  qz = q(4);

  dR_by_dq0RES=[2*q0, -2*qz,  2*qy;
		        2*qz,  2*q0, -2*qx;
		       -2*qy,  2*qx,  2*q0];
 
  return;


function dR_by_dqxRES=dR_by_dqx(q)

  q0 = q(1);
  qx = q(2);
  qy = q(3);
  qz = q(4);

  
  dR_by_dqxRES=[2*qx, 2*qy,   2*qz;
		        2*qy, -2*qx, -2*q0;
		        2*qz, 2*q0,  -2*qx];
 
return



function dR_by_dqyRES=dR_by_dqy(q)
    
  q0 = q(1);
  qx = q(2);
  qy = q(3);
  qz = q(4);

  dR_by_dqyRES=[-2*qy, 2*qx,  2*q0;
		         2*qx, 2*qy,  2*qz;
		        -2*q0, 2*qz, -2*qy];
 
return

function dR_by_dqzRES=dR_by_dqz(q)
  q0 = q(1);
  qx = q(2);
  qy = q(3);
  qz = q(4);


  dR_by_dqzRES=[-2*qz, -2*q0, 2*qx;
		         2*q0, -2*qz, 2*qy;
		         2*qx,  2*qy, 2*qz];
 
  return
