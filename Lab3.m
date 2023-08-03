%Read a grayscale Image or a matrix mxn

input1 = imread('kids.tif');
input2 = imread('Rose1024.tif');
input3 = imread('fractured_spine.tif');

Y = equalize(input2);

figure
subplot(3,1,1)
imshow(input2);
title('Original Image')

subplot(3,1,2)
imshow(Y);
title('Equalized Image')

subplot(3,1,3)
imshow(histeq(input2))
title('Equalized Image (Matlab)')

figure
subplot(3,1,1)
imhist(input1);
title('Original Histogram')

subplot(3,1,2)
imhist(Y);
title('Equalized Histogram')

subplot(3,1,3)
imhist(histeq(input1))
title('Equalized Histogram (Matlab)')


%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = match(input1,input3);

figure
subplot(4,1,1)
imshow(input1);
title('input 1')

subplot(4,1,2)
imshow(input3);
title('input 2')

subplot(4,1,3)
imshow(A);
title('Histogram matching')

subplot(4,1,4)
imshow(imhistmatch(input1,input3));
title('Histogram matching (Matlab)')

figure
subplot(4,1,1)
imhist(input1);
title('input 1')

subplot(4,1,2)
imhist(input3);
title('input 2')

subplot(4,1,3);
imhist(A);
title('Matched histogram')

subplot(4,1,4);
imhist(imhistmatch(input1,input3))
title('Matched histogram (Matlab)')

function Y = equalize(x)
    % Frequency of every pixel
    [pixelFreq, ~] = imhist(x);

    % Pixel count
    pixelCount = numel(x);

    % Minimum grayscale value in the picture
    %min_x = double(min(min(x)));
    min_x = 0;
    % Maximum grayscale value in the picture
    %max_x = double(max(max(x)));
    max_x = 255;
    % Number of different grayscale values in the picture
    bin = max_x - min_x;
    Cumulative_hist = 0;
    Y = x;

    
    for i=1:256
        Cumulative_hist = Cumulative_hist + pixelFreq(i);
        Y(x==i) =  floor((Cumulative_hist/pixelCount)*bin);
        
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = match(k, l)

    Map = zeros(256,1,'uint8');

    % Histograms of our inputs
    hist_input = imhist(k);
    hist_referance = imhist(l);

    % Calculating cumulative ditribution factors
    cdf1 = cumsum(hist_input) / numel(k)
    cdf2 = cumsum(hist_referance) / numel(l);
    
    % https://stackoverflow.com/a/26765167

    % Getting the absolute differance of every pixels cdf value
    % 
    for i=1:256
        [~,index] = min(abs(cdf1(i) - cdf2));
        Map(i) = index-1;
    end
    A = Map(uint32(k) + 1); % 256 is bigger than 8 bits so 32 bit integer.

end
