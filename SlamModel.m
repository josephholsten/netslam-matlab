classdef SlamModel
  % Dynamic motion and observation model
  
  properties
    configuration % Configuration settings
    camera_matrix % Camera matrix, (R|t)
  end
  
  properties (Dependent = true)
    R
    t
    camera_position % Current location of camera
    camera_viewing_direction % Current direction of camera view
    camera_up_direction % Current direction of camera's 'up'
  end
  
  methods
    
    function obj = SlamModel(configuration)
      if nargin > 0
        obj.configuration = configuration;
        obj.camera_matrix = eye(4);
      end
    end
    
    function update(model, dt)
      % TODO
    end
    
    function R = get.R(model)
      R = model.camera_matrix(1:3, 1:3);
    end
    
    function t = get.t(model)
      t = model.camera_matrix(1:3, 3);
    end
    
    function pos = get.camera_position(model)
      pos = - model.R' * model.t;
    end
    
    function dir = get.camera_viewing_direction(model)
      % TODO
    end
    
    function dir = get.camera_up_direction(model)
      % TODO
    end
  end
  
end

