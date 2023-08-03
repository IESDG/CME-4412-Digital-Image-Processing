%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
moon = imread('moon.bmp');
thresholded_moon = moon;

% Thresholding with threshold 20
threshold = 20;
thresholded_moon(find(moon<threshold)) = 0;
thresholded_moon(find(moon>=threshold)) = 255;

figure
subplot(2,1,1)
imshow(moon)
axis off
title('Original')

subplot(2,1,2)
imshow(thresholded_moon)
axis off
title('Thresholded')

%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spine = imread("fractured_spine.tif");

% s=c*(r^y)

r = im2double(spine);
normalize(r,"range");

c = 1;

y = [0.6, 0.4, 0.3];

s1 = c*(r.^y(1)); % y = 0.6
s2 = c*(r.^y(2)); % y = 0.4
s3 = c*(r.^y(3)); % y = 0.3

figure
subplot(1,4,1)
imshow(spine)
axis off
title('Original')

subplot(1,4,2)
imshow(s1)
axis off
title('y = 0.6')

subplot(1,4,3)
imshow(s2)
axis off
title('y = 0.4')

subplot(1,4,4)
imshow(s3)
axis off
title('y = 0.3')

%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kids = imread("kids.tif");

output = stretch(kids, 75, 180 ,0 ,255);

figure
subplot(1,2,1)
imshow(kids)
axis off
title('Original')

subplot(1,2,2)
imshow(output)
axis off
title('Stretched')

%imhist(kids)
%imhist(output)



function output = stretch(input, r1, r2, s1, s2)
 
    [rows,cols] = size(input);
    
    slope = [s1/r1,                 % Slope 1
            (s2-s1)/(r2-r1),        % Slope 2
            (255-s2)/(255-r2)];     % Slope 3
    
    
    output = input;
    
    % For every pixel in every interval we stretch the pixels.
    for i = 1:rows
        for j = 2:cols
            if (input(i,j) < r1)
                output(i,j) = slope(1)*input(i,j);
            elseif (input(i,j) < r2)
                output(i,j) = slope(2)*(input(i,j) - r1) + s1;
            else
                output(i,j) = slope(3)*(input(i,j) - r2) + s2;
            end
        end
    end
end

