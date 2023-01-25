function sim = computeDiceScore(o,p)
    original = imread(o);
    binaryOriginal = im2bw(original);

    perturbed = imread(p);
    imageNoiseReduction = medfilt2(perturbed, [4 4]);
    imageProcessed = imageNoiseReduction;
    se1 = strel('square', 3);
    for i = 1:4
        imageProcessed = imerode(imageProcessed, se1);
    end
    binary = im2bw(imageProcessed);
    binaryPerturbed = imfill(binary, 'holes');

    sim = dice(binaryOriginal, binaryPerturbed);
end