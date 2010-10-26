classdef Landmark < handle

  properties
    patch
    ahp
    cam_pos
    observed
    observation
    predicted
    prediction
  end
  
  properties (Dependent = true)
    pos
  end
  
  methods
    
    function obj = Landmark(model, patch, cam_pos, uv)
      if nargin > 0
        obj.patch = patch;
        obj.cam_pos = cam_pos;
        obj.estimate_pos(model, uv);
        obj.observed = false;
        obj.observation = [];
        obj.predicted = false;
        obj.prediction = [];
      end
    end
    
    function L = estimate_pos(L, model, uv)
      cam = model.config.camera;
      uv = cam.undistort(uv);
      L.pos = cam.unproject(model.C, uv, 1);
    end
    
    function p = get.pos(L)
      p = ahp_to_euclidean(L.ahp);
    end
    
    function L = set.pos(L, p)
      L.ahp = euclidean_to_ahp(p, L.cam_pos);
    end
    
  end
  
end