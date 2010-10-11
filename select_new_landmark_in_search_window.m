function [uv, found] = select_new_landmark_in_search_window(frame, uv)

global config;
global base_path;

[region, anchor] = get_centered_region(frame, uv, config.landmark_search_size);
region = double(region);

cd ../fast-matlab-src
cs = fast_corner_detect_9(region, config.new_landmark_threshold);
c = fast_nonmax(region, config.new_landmark_threshold, cs);
cd ../tests

all_uv = c';

if (size(all_uv, 2) ~= 0)
  uv = all_uv(:,1) + anchor - ones(2,1);
  found = 1;
else
  uv = [];
  found = 0;
end

end