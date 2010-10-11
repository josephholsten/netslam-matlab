classdef Configuration
  % Holds global configuration information about how to run the
  % algorithm.

  properties
    enable_distortion % whether radial distortion is used
    landmark_width
    landmark_half_width
    frame_size
    landmark_search_size
    max_search_attempts
  end
  
  methods
    
    function obj = Configuration()
      obj.enable_distortion = true;
      obj.landmark_width = 11;
      obj.landmark_half_width = 6;
      obj.frame_size = [320; 240];
      obj.landmark_search_size = [60; 40];
      obj.max_search_attempts = 50;
    end
  end
end