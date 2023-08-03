img = imread("scene.png");

%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

normalized_img = double(img)/255; % Normalizing image in range [0 1]

%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

radius=3;
filter_3x3=ones(radius,radius)/(radius*radius); 

filtered_img_3x3 = imfilter(normalized_img,filter_3x3); % Filtered image

figure
subplot(1,2,1)
imshow(img)
title('Original Image')

subplot(1,2,2)
imshow(filtered_img_3x3)
title('Filtered Image 3x3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filter_5x5=ones(5,5)/(5*5);
filtered_img_5x5 = imfilter(normalized_img,filter_5x5); % Filtered image

filter_7x7=ones(7,7)/(7*7);
filtered_img_7x7 = imfilter(normalized_img,filter_7x7); % Filtered image

figure
subplot(2,2,1)
imshow(img)
title('Original Image')

subplot(2,2,2)
imshow(filtered_img_3x3)
title('Filtered Image 3x3')

subplot(2,2,3)
imshow(filtered_img_5x5)
title('Filtered Image 5x5')

subplot(2,2,4)
imshow(filtered_img_7x7)
title('Filtered Image 7x7')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

base_filter=[0 0 0 0 0;1 1 1 1 1;0 0 0 0 0;-1 -1 -1 -1 -1;0 0 0 0 0];
angle=0;
filter_0=imrotate(base_filter,angle,'crop');

angled_image_0 = imfilter(normalized_img,filter_0);

figure
subplot(1,2,1)
imshow(img)
title('Original Image')

subplot(1,2,2)
imshow(angled_image_0)
title('Filtered Image 0*')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filter_45 = imrotate(base_filter,45,'crop');
angled_image_45 = imfilter(normalized_img,filter_45);

filter_90 = imrotate(base_filter,90,'crop');
angled_image_90 = imfilter(normalized_img,filter_90);

filter_135 = imrotate(base_filter,135,'crop');
angled_image_135 = imfilter(normalized_img,filter_135);

figure
subplot(2,2,1)
imshow(img)
title('Original Image')

subplot(2,2,2)
imshow(angled_image_45)
title('Filtered Image 45*')

subplot(2,2,3)
imshow(angled_image_90)
title('Filtered Image 90*')

subplot(2,2,4)
imshow(angled_image_135)
title('Filtered Image 135*')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cats = imread("two_cats.jpg");
normalized_cats = double(cats)/255;

horizontal = fspecial("sobel");
filtered_horizontal = imfilter(normalized_cats,horizontal);

vertical = transpose(horizontal);
filtered_vertical = imfilter(normalized_cats,vertical);

figure
subplot(2,2,1)
imshow(cats)
title('Original Cats')

subplot(2,2,2)
imshow(filtered_horizontal)
title('Horizontal Edges')

subplot(2,2,3)
imshow(filtered_vertical)
title('Vertical Edges')

subplot(2,2,4)
imshow(filtered_vertical + filtered_vertical)
title('Added Filters')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Gmag,Gdir] = imgradient(filtered_horizontal,filtered_vertical);

figure
imshow(Gmag)
title('Edge magnitude map')
