classdef SlamModel
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
      [p,q,v,w] = unpack_camera_state(model.state);
      R = q2R(q);
      C = [R', -R*p; zeros(1,3), 1];
    end
  end
  
end

