%% Original image

% process original image
rawImageOriginal = imread('Abgcross-Original.tif');
binaryImageOriginal = im2bw(rawImageOriginal);
connectedComponentsOriginal = bwlabel(binaryImageOriginal, 8);

% compute area and perimeter
statsOriginal = regionprops('table',connectedComponentsOriginal);

% display pipeline for original image
figure
    subplot(1,3,1);
        imshow(rawImageOriginal);
        title('Original image');
    subplot(1,3,2);
        imshow(binaryImageOriginal);
        title('Binary image');
    subplot(1,3,3);
        imagesc(connectedComponentsOriginal);
        title('Colored segmentation image');

%% Perturbated image

% process noised image
rawImageNoise = imread('abgcross_noise.tif');
% noise reduction + iterative erosion
rawImageReduced = medfilt2(rawImageNoise, [5 5]); 
imageProcessed = rawImageReduced;
se1 = strel('square', 3);
for i = 1:5
    imageProcessed = imerode(imageProcessed, se1);
end
binaryImageNoise = im2bw(imageProcessed);
connectedComponentsNoise = bwlabel(binaryImageNoise, 8);

%  compute area and perimeter
statsNoise = regionprops('table',connectedComponentsNoise);

% display pipeline for noised image
figure
    subplot(2,2,1);
        imshow(rawImageNoise);
        title('Noised image');
    subplot(2,2,2);
        imshow(imageProcessed);
        title('Processed image');
    subplot(2,2,3);
        imshow(binaryImageNoise);
        title('Binary image');
    subplot(2,2,4);
        imagesc(connectedComponentsNoise);
        title('Colored segmentation image');
