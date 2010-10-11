classdef Configuration
  % Holds global configuration information about how to run the
  % algorithm.

  properties
    enable_distortion % whether radial distortion is used
    landmark_width
    landmark_half_width
    frame_size % width, height
    landmark_search_size % width, height
    max_search_attempts
    required_landmarks_per_frame
    new_landmark_threshold
  end
  
  methods
    
    function obj = Configuration()
      obj.enable_distortion = true;
      obj.landmark_width = 11;
      obj.landmark_half_width = 6;
      obj.frame_size = [320; 240]; % oriented VERTICALLY % original: [320;240]
      obj.landmark_search_size = [50; 50]; % original: [60;40]
      obj.max_search_attempts = 50;
      obj.required_landmarks_per_frame = 20;
      obj.new_landmark_threshold = 100;
    end
  end
end