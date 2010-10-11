classdef Configuration
  % Holds global configuration information about how to run the
  % algorithm.

  properties
    enable_distortion % whether radial distortion is used
  end
  
  methods
    
    function obj = Configuration()
      obj.enable_distortion = true;
    end
  end
end