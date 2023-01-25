function [F, U] = robustSegmentation(im)

    % segmentation
    image = imread(im);
    imageNoiseReduction = medfilt2(image, [4 4]);
    imageProcessed = imageNoiseReduction;
    se1 = strel('square', 3);
    for i = 1:4
        imageProcessed = imerode(imageProcessed, se1);
    end
    binary = im2bw(imageProcessed);
    filledImage = imfill(binary, 'holes');
    cc = bwlabel(filledImage, 8);

    % compute area and perimeter
    F = bwarea(binary);
    U = sum(bwperim(binary), 'all');

    % display results
    figure
    subplot(2,2,1);
        imshow(image);
        title('Noised image');
    subplot(2,2,2);
        imshow(imageProcessed);
        title('Processed image');
    subplot(2,2,3);
        imshow(filledImage);
        title('Binary filled image');
    subplot(2,2,4);
        imagesc(cc);
        title('Colored segmentation image');

end