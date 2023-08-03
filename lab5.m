img = imread("scene.png");
img2 = double(img);

img_filtered = filter(img2, "gaussian_low", 30);

figure
subplot(1,2,1)
imshow(img)

subplot(1,2,2)
imshow(img_filtered)
title("Gaussian low d0 30")

%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 3 %%%%%%%%%%%%%%%%%%%%%%%%%%


img_cat = imread("cat.jpeg");
img_dog = imread("dog.jpeg");

dog_ideal_low = filter(img_dog, "ideal_low", 20);
cat_ideal_high = filter(img_cat, "ideal_high", 20);

dog_gaussian_low = filter(img_dog, "gaussian_low", 15);
cat_gaussian_high = filter(img_cat, "gaussian_high", 15);

dog_butterworth_low = filter(img_dog, "butterworth_low", 10);
cat_butterworth_high = filter(img_cat, "butterworth_high", 10);

ideal_cd = dog_ideal_low+cat_ideal_high;
gaussian_cd = dog_gaussian_low+cat_gaussian_high;
butterworth_cd = dog_butterworth_low+cat_butterworth_high;

figure
subplot(1,3,1)
imshow(ideal_cd)
title("ideal filter with d0 = 20")

subplot(1,3,2)
imshow(gaussian_cd)
title("gaussian filter with d0 = 15")

subplot(1,3,3)
imshow(butterworth_cd)
title("butterworth filter with d0 = 10 and order 2")


%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 4 %%%%%%%%%%%%%%%%%%%%%%%%%%

noisy = imread("NoisyImg.bmp");

noisy_ideal_low = filter(noisy, "ideal_low", 50);
noisy_gaussian_low = filter(noisy, "gaussian_low", 50);
noisy_butterworth_low = filter(noisy, "butterworth_low", 50);
noisy_ideal_high = filter(noisy, "ideal_high", 5);
noisy_gaussian_high = filter(noisy, "gaussian_high", 5);
noisy_butterworth_high = filter(noisy, "butterworth_high", 5);

figure
subplot(1,3,1)
imshow(noisy_ideal_low);
title("ideal low")

subplot(1,3,2)
imshow(noisy_gaussian_low);
title("gaussian low")

subplot(1,3,3)
imshow(noisy_butterworth_low);
title("butterworth low")

figure
subplot(1,3,1)
imshow(noisy_ideal_high);
title("ideal high")

subplot(1,3,2)
imshow(noisy_gaussian_high);
title("gaussian high")

subplot(1,3,3)
imshow(noisy_butterworth_high);
title("butterworth high")

%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 5 %%%%%%%%%%%%%%%%%%%%%%%%%%
noisy_y = imread("NoisyBlur.bmp");

noisy_ideal_low = filter(noisy_y, "ideal_low", 120);
noisy_gaussian_low = filter(noisy_y, "gaussian_low", 120);
noisy_butterworth_low = filter(noisy_y, "butterworth_low", 120);
noisy_ideal_high = filter(noisy_y, "ideal_high", 10);
noisy_gaussian_high = filter(noisy_y, "gaussian_high", 10);
noisy_butterworth_high = filter(noisy_y, "butterworth_high", 10);

figure
subplot(1,3,1)
imshow(noisy_ideal_low);
title("ideal low")

subplot(1,3,2)
imshow(noisy_gaussian_low);
title("gaussian low")

subplot(1,3,3)
imshow(noisy_butterworth_low);
title("butterworth low")

figure
subplot(1,3,1)
imshow(noisy_ideal_high);
title("ideal high")

subplot(1,3,2)
imshow(noisy_gaussian_high);
title("gaussian high")

subplot(1,3,3)
imshow(noisy_butterworth_high);
title("butterworth high")




%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 2 %%%%%%%%%%%%%%%%%%%%%%%%%%
function img_filtered = filter(img, filter_name,D0)

    if(ndims(img) == 3) % Finding out if the picture has rgb or not.

    % First we divide the color masks of the image.
    img_r = img(:,:,1);
    img_g = img(:,:,2);
    img_b = img(:,:,3);

    % Then we create the mask of the filter.
    mask = create_filter(filter_name, size(img_r), D0);
    
    % FFT of each color mask.
    f_r = fft2(img_r);
    f_g = fft2(img_g);
    f_b = fft2(img_b);

    % Shifting FFT's to make the frequency more centralized.
    F_r = fftshift(f_r);
    F_g = fftshift(f_g);
    F_b = fftshift(f_b);

    % Applying the mask to each color mask.
    G_r = F_r.*mask;
    G_g = F_g.*mask;
    G_b = F_b.*mask;

    % Inverse FFT of each color mask.
    g_r = real(ifft2(ifftshift(G_r)));
    g_g = real(ifft2(ifftshift(G_g)));
    g_b = real(ifft2(ifftshift(G_b)));

    
    % Concatanetion of each color transformed color mask.
    img_filtered = uint8(cat(3, g_r, g_g, g_b));

    else
    % If the picure has no rgb values
    
    mask = create_filter(filter_name, size(img), D0);
    
    f = fft2(img);
    F = fftshift(f);

    G = F.*mask;
    g = real(ifft2(ifftshift(G)));

    img_filtered = uint8(g);



    end
    

end
%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 1 %%%%%%%%%%%%%%%%%%%%%%%%%%
function H = create_filter(filter_name, filter_size, D0)
    % H is the mask.
    H = ones(filter_size);
    [M, N] = size(H);

    % Selecting filter
    if(filter_name == "ideal_low")
        ideal()
    elseif(filter_name == "ideal_high")
        ideal()
        H = abs(1-H);
    elseif(filter_name == "gaussian_low")
        gaussian()
    elseif(filter_name == "gaussian_high")
        gaussian()
        H = abs(1-H);
    elseif(filter_name == "butterworth_low")
        butterworth()
    elseif(filter_name == "butterworth_high")
        butterworth()
        H = abs(1-H);
    end

    % ideal filter
    function ideal()
        for u=1:M
            for v=1:N
                D = sqrt((u-(M/2)).^2 + (v-(N/2)).^2);
                if D >= D0
                    H(u,v) = 0;
                else
                    H(u,v) = 1;
                end
            end
        end
    end

    % gaussian filter
    function gaussian()
        for u=1:M
            for v=1:N
                D = sqrt((u-(M/2)).^2 + (v-(N/2)).^2);
                x = -(D.^2);
                y = 2.*(D0^2);
                H(u,v) = exp(x/y);
                
            end
        end      
    end

    % butterworth filter
    function butterworth()
        n = input("Enter the order of the filter");
        for u=1:M
            for v=1:N
                D = sqrt((u-(M/2)).^2 + (v-(N/2)).^2);
                x = D/D0;
                y = x.^(2.*n) + 1;
                H(u,v) = 1/y;
                
            end
        end
    end
%

end
