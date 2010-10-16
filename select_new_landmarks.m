function new_landmarks = select_new_landmarks(frame, old_landmarks)

global config;

% Precondition: current landmarks should be predicted by now

% TODO: initialize these from state
new_landmarks = [];
num_old_landmarks = size(old_landmarks, 2);
num_required_landmarks = config.required_landmarks_per_frame;
total_landmarks = num_old_landmarks;
attempts = 0;
num_aborted_searches = 0;
num_failed_searches = 0;

while total_landmarks < num_required_landmarks
  % quit if we've surpassed max attempts
  attempts = attempts + 1;
  if (attempts > config.max_search_attempts)
    break;
  end

  % select search window; fail if any old landmarks inside it
  uv = random_landmark_search_coords();
  inside = points_inside_region(old_landmarks, uv, config.landmark_search_size);
  if (size(inside, 2) ~= 0)
    num_aborted_searches = num_aborted_searches + 1;
    continue;
  end

  % append the new landmark, if one is found
  [uv, found] = select_new_landmark_in_search_window(frame, uv);
  if (found)
    initialize_new_landmark(frame, uv);
    old_landmarks = [old_landmarks,uv];
    new_landmarks = [new_landmarks,uv];
    total_landmarks = total_landmarks + 1;
  else
    num_failed_searches = num_failed_searches + 1;
  end
end

success = (total_landmarks == num_required_landmarks);

% NOTE: possible quad-tree algorithm follows

%tree = build_quadtree(old_landmarks);
%while total_landmarks < num_required_landmarks
  % - choose largest leaf of tree
  % - fail if largest leaf size < window+margin size
  % - get region inside leaf with appropriate margin
  % - do
  %   - pick random point inside region
  %   - center search window on point
  %   - search for feature using fast_corner_detect
  %   - loop if no feature was found
  %   - loop if new feature too close to any old feature
  % - add feature to set
  % - bump total_landmarks
  % - split leaf by quadtree algorithm
%end

% NOTES

% The idea is to find a landmark which is maximally distant from
% the existing landmarks in the frame. We could use rejection sampling, though
% that is likely to be very slow. We could also use a quadtree, no speed
% guarantees there either, though likely to be better. We could also pick
% a requested window size and just scan through, looking for a blank region -
% though that probably fails due to being systematic

% here's what davison does (basically, rejection sampling):
% the 'excluded band' is half the patch size, plus one
% the initializing box size is (60,40)
% rho and std_rho = 1
% 
% - loop until max attempts passed or enough landmarks added:
%   - predict measurements
%   - get u,v locations of predicted features
%   - loop:
%     - find a random point in the image, with a margin of half the init box size plius the exluded band
%     - call fast_corner_detect_9 in that region
%     - call fast_nonmax, with the same parameters, plus result of last call
%     - result of last call, transposed, is called all_uv
%     - determine if there are new features in the sarch box
%     - determine the number of existing features in the search box
%     - if there are new features but not old features in the box,
%       - set uv_integer to all new points returned
%       - set uv to just the first feature returned
%     - else, uv is set to empty list
%     - if uv list is not empty
%       - add features in uv to the filter
%     - clear the feature measurements (?)
%     - repeat until a new landmark has been found