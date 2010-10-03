function test_find_template_in_image_based_on_demo

template = .2*ones(11); % Make light gray plus on dark gray background
template(6,3:9) = .6;   
template(3:9,6) = .6;
BW = template > 0.5;      % Make white plus on black background
% Make new image that offsets the template
offsetTemplate = .2*ones(21); 
offset = [3 5];  % Shift by 3 rows, 5 columns
offsetTemplate( (1:size(template,1))+offset(1),...
                (1:size(template,2))+offset(2) ) = template;

[x, y, cc] = find_template_in_image(BW, offsetTemplate);

assertElementsAlmostEqual([y x], offset);

end