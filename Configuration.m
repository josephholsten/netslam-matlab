classdef Configuration
  % Holds global configuration information about how to run the
  % algorithm.

  properties
    camera                  % camera model
    landmark_width
    landmark_half_width
    frame_size              % width, height
    landmark_search_size    % width, height
    max_search_attempts
    required_landmarks_per_frame
    new_landmark_threshold
    process_noise           % TODO
    observation_noise       % TODO
    std_pixel
    std_inverse_distance
    figures_path
  end
  
  methods
    
    function obj = Configuration()
      obj.landmark_width = 11;
      obj.landmark_half_width = 6;
      obj.frame_size = [320; 240];
      obj.landmark_search_size = [50; 50]; % original: [60;40]
      obj.max_search_attempts = 50;
      obj.required_landmarks_per_frame = 20;
      obj.new_landmark_threshold = 100;    % TODO: find out what this does
      obj.camera = Camera([1 1], [0 0], [0 0]);
      obj.std_pixel = 1;
      obj.std_inverse_distance = 1;
      obj.figures_path = 'figures';
      obj.process_noise = eye(13);
      obj.observation_noise = eye(2);
    end
  end
end