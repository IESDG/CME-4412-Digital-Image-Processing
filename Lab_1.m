%%%%%%%%%%%%%%%%%%% Question 1 %%%%%%%%%%%%%%%%%%%%%%%%
original = imread('Rose1024.tif');

% Subsampling the original image, then subsampling those subsamples.
x_512 = original(1:2:size(original,1),1:2:size(original,2));
x_256 = x_512(1:2:size(x_512,1),1:2:size(x_512,2));
x_128 = x_256(1:2:size(x_256,1),1:2:size(x_256,2));
x_64 = x_128(1:2:size(x_128,1),1:2:size(x_128,2));
x_32 = x_64(1:2:size(x_64,1),1:2:size(x_64,2));

figure
subplot(2,3,1)
imagesc(original)
title('Original')
axis off
colormap gray

subplot(2,3,2)
imagesc(x_512)
title('512x512')
axis off
colormap gray

subplot(2,3,3)
imagesc(x_256)
title('256x256')
axis off
colormap gray

subplot(2,3,4)
imagesc(x_128)
title('128x128')
axis off
colormap gray

subplot(2,3,5)
imagesc(x_64)
title('64x64')
axis off
colormap gray

subplot(2,3,6)
imagesc(x_32)
title('32x32')
axis off
colormap gray


%%%%%%%%%%%%%%%%%%%% Question 2 %%%%%%%%%%%%%%%%%%%%%%%

skull = imread("Ctskull-256.tif");

% Reducing bits one by one
q_7 = uint8((single(skull)/256)*2^7);
q_6 = uint8((single(skull)/256)*2^6);
q_5 = uint8((single(skull)/256)*2^5);
q_4 = uint8((single(skull)/256)*2^4);
q_3 = uint8((single(skull)/256)*2^3);
q_2 = uint8((single(skull)/256)*2^2);
q_1 = uint8((single(skull)/256)*2^1);

figure
subplot(2,4,1)
imagesc(skull)
title('Original')
axis off
colormap gray

subplot(2,4,2)
imagesc(q_7)
title('7 Bits')
axis off
colormap gray

subplot(2,4,3)
imagesc(q_6)
title('6 Bits')
axis off
colormap gray

subplot(2,4,4)
imagesc(q_5)
title('5 Bits')
axis off
colormap gray

subplot(2,4,5)
imagesc(q_4)
title('4 Bits')
axis off
colormap gray

subplot(2,4,6)
imagesc(q_3)
title('3 Bits')
axis off
colormap gray

subplot(2,4,7)
imagesc(q_2)
title('2 Bits')
axis off
colormap gray

subplot(2,4,8)
imagesc(q_1)
title('1 Bit')
axis off
colormap gray





