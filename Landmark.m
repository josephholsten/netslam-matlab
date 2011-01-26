classdef Landmark < handle

  properties
    patch
    ahp
    cam_pos
    observed
    observation
    predicted
    prediction
    hits
    misses
    H
    S
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
        obj.hits = 0;
        obj.misses = 0;
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
    
    function n = max_miss_ratio(landmark)
      n = 3;
    end
    
    function n = grace_period(landmark)
      n = 3;
    end
    
    function p = should_be_removed(landmark)
      if landmark.hits + landmark.misses < landmark.grace_period()
        p = false;
      elseif landmark.hits == 0
        p = true; % you suck
      elseif landmark.misses / landmark.hits > landmark.max_miss_ratio()
        p = true;
      else
        p = false;
      end
    end
    
  end
  
end