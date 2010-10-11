function [sub, anchor] = get_centered_region(frame, center, region_size)

region_size = region_size - ones(2,1);
min = ceil(center - region_size / 2);
max = floor(center + region_size / 2);
sub = frame(min(2):max(2),min(1):max(1));
anchor = min;

end