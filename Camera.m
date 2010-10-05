classdef Camera
  % Represents a pinhole-model camera with distortion.
  % This class does not model the position, orientation, etc. of the camera.
  
  properties
    focal
    center
    projection % Projection matrix (3x4)
    distortion % Distortion matrix (2x1)
  end
  
  methods
    
    function obj = Camera(focal, center, distortion)
      % CAMERA Constructor function.
      %
      % focal: Vector of focal lengths of the form [fx fy]
      % center: Vector of camera image center point of form [cx cy]
      % distortion: Vector of 2 distortion parameters [k1 k2]
      if nargin > 0
        obj.focal = reshape(focal, 2, 1);
        obj.center = reshape(center, 2, 1);
        obj.projection = zeros(3, 4);
        obj.projection(1:3,1:3) = diag([obj.focal;1]);
        obj.projection(1:2,3) = obj.center;
        obj.distortion = reshape(distortion(1:2), 2, 1);
      end
    end
    
    
    function [u] = project(cam, C, x)
      % PROJECT Project a point x onto the image plane without distortion.
      %
      % C: camera matrix of the form [R t; 0 0 0 1]
      % x: 3D point to project (optionally can be homogeneous)
      % u: 2D point in image plane, without distortion
      %
      % TODO: test me
      
      u = unhom(cam.P * C * hom(x));
    end
    
    
    function [x] = unproject(cam, C, u, d)
      % UNPROJECT Take an image plane point u, and unproject it back into 3D space.
      % If the distance d is given, it is set as the fixed distance between the camera
      % and the point. Otherwise, the distance is left unmodified. The returned point
      % is homogeneous with a fourth component of 1.0.
      %
      % C: camera matrix of the form [R t; 0 0 0 1]
      % u: 2D point in image plane, without distortion
      % d: distance to new 3D point from camera (optional)
      % x: calculated 3D point
      % 
      % TODO: test me
      
      x = pinv(cam.P * C) * hom(u);
      
      if nargin > 2
        t = repmat(C(:,3),1,size(x,2));
        r = x + t;
        r = r * d ./ sqrt(r' * r)';
        x = r - t;
        x(4,:) = ones(1,size(x,2));
      end
    end
    
    
    function [v] = distort(cam, u)
      % DISTORT Distort points in the image plane
      % 
      % u: undistorted points
      % v: distorted points
      [n m] = size(u);
      k1 = cam.distortion(1);
      k2 = cam.distortion(2);
      c = repmat(cam.center, 1, m);
      %f = repmat(cam.focal, 1, m);
      f = ones(n,m);
      p = (u - c) .* f;
      ru = sqrt([1 1] * (p .* p));
      rd = ru ./ (1 + k1 * ru.^2 + k2 * ru.^4);
      for k=1:10
        q = rd + k1 * rd.^3 + k2 * rd.^5 - ru;
        q_p = 1 + 3 * k1 * rd.^2 + 5 * k2 * rd.^4;
        rd = rd - q ./ q_p;
      end
      D = 1 + k1 * rd.^2 + k2 * rd.^4;
      D = repmat(D, n, 1);
      v = p ./ (D .* f) + c;
    end
    
    
    function [u] = undistort(cam, v)
      % UNDISTORT Undistort points in the image plane
      %
      % v: distorted points
      % u: undistorted points    
      [n m] = size(v);
      k1 = cam.distortion(1);
      k2 = cam.distortion(2);
      c = repmat(cam.center, 1, m);
      %f = repmat(cam.focal, 1, m);
      f = ones(n,m);
      p = (v - c) .* f;
      r = sqrt([1 1] * (p .* p));
      D = 1 + k1 * r.^2 + k2 * r.^4;
      D = repmat(D, n, 1);
      u = p .* D ./ f + c;
    end
  end
end