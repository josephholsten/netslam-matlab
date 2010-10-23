classdef SlamModel < handle
  % Dynamic motion and observation model
  
  properties
    config
    state
    covariance
    landmarks
  end
  
  properties (Dependent = true)
    C
  end
  
  methods
    
    function obj = SlamModel(config, x, P)
      if nargin > 0
        obj.config = config;
        obj.state = x;
        obj.covariance = P;
        obj.landmarks = [];
      else
        obj.config = Configuration();
        obj.state = [0 0 0 1 0 0 0 0 0 0 0 0 0]';
        obj.covariance = eye(13);
        obj.landmarks = [];
      end
    end
    
    function C = get.C(model)
      [p,q,v,w] = model.unpack_camera_state();
      R = q2R(q);
      C = [R', -R*p; zeros(1,3), 1];
    end
    
    function pack_camera_state(model, p, q, v, w)
      % PACK_CAMERA_STATE pack the camera state into the state vector
      % p: camera position (3x1)
      % q: camera orientation quaternion (4x1)
      % v: linear camera velocity (3x1)
      % w: angular camera velocity quaternion (4x1)
      state = model.state;
      state(1:3) = p;
      state(4:7) = q;
      state(8:10) = v;
      state(11:13) = w;
      model.state = state;
    end
    
    function pack_state(model, p, q, v, w)
      % PACK_STATE pack the state into the state vector
      % p: camera position (3x1)
      % q: camera orientation quaternion (4x1)
      % v: linear camera velocity (3x1)
      % w: angular camera velocity quaternion (4x1)
      model.pack_camera_state(p, q, v, w);
      state = model.state;
      j = 15;
      n = 7;
      for i = 1:size(model.landmarks)
        state(j:j+n) = model.landmarks(i).ahp;
        j = j + n;
      end
      model.state = state;
    end
    
    function [p,q,v,w] = unpack_state(model)
      % UNPACK_STATE take variables out of state vector
      % p: camera position (3x1)
      % q: camera orientation quaternion (4x1)
      % v: linear camera velocity (3x1)
      % w: angular camera velocity quaternion (4x1)
      [p q v w] = model.unpack_camera_state();
      j = 15;
      n = 7;
      state = model.state;
      for i = 1:size(model.landmarks,2)
        model.landmarks(i).ahp = state(j:j+n);
        j = j + n;
      end
    end
    
    function [p,q,v,w] = unpack_camera_state(model)
      % UNPACK_CAMERA_STATE take camera variables out of state vector
      % p: camera position (3x1)
      % q: camera orientation quaternion (4x1)
      % v: linear camera velocity (3x1)
      % w: angular camera velocity quaternion (4x1)
      state = model.state;
      p = state(1:3);
      q = state(4:7);
      v = state(8:10);
      w = state(11:13);
    end
  end
  
end

