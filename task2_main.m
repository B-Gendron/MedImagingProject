%% -------------------------------------------------
%                      Task 2
%  -------------------------------------------------
% Custom Function in GammaTransfo.m
%        -> GammaTransfo(x, c, gamma) = c * x^gamma (with x = g(a,b))
%% 1) Sketch curve for gamma = 0.5 and 2
gamma1 = 0.5; gamma2 = 2;
x = 0:255; c = 1/255;
y1 = GammaTransfo(x, c^(gamma1-1), gamma1);
y2 = GammaTransfo(x, c^(gamma2-1), gamma2);
y0 = GammaTransfo(x, c^0, 1);

figure("Name", "Transformation curve for two gamma values")
subplot(1, 3, 1);
plot(x, y1)
title('Gamma1 = 0.5', 'FontSize', 10)
subplot(1, 3, 2);
plot(x, y0)
title('Gamma = 1', 'FontSize', 10)
subplot(1, 3, 3);
plot(x, y2)
title('Gamma2 = 2', 'FontSize', 10)
%% 2) Determination of coefficient c
% c is the coefficient of normalization.
% Because f must be between 0 and 255, g(x,y)^gamma must be normalized.
% Thus, c must be 1/255^(gamma-1).

% If gamma has an upper bound, c can be a constant, with value
% 1/255^(upper_bound-1). For example, in our case, if we want the same
% coefficient c for both gamma1 and gamma2, the upper_bound being 2,
% c would be equal to 1/255^1.

%% 3) Which type of input image lead to an enhancement
% A high gamma leads to a darker image, 
%   while a low gamma leads to lighter images (shadows are darker).
% So gamma2 = 2 enhances very bright images, 
%   while gamma1 = 0.5 enhances dark images (shadows are lighter).

% Example: transformation of a gray image
Ip = imread("peppers.png");
I = rgb2gray(Ip);
I1 = GammaTransfo(double(I), 1/255^(gamma1-1), gamma1);
I2 = GammaTransfo(double(I), 1/255^(gamma2-1), gamma2);
figure("Name", "Transformation of the image")
subplot(1, 3, 1);
imagesc(I1); colormap gray
title('Gamma1 = 0.5', 'FontSize', 10)
subplot(1, 3, 2);
imagesc(I);colormap gray
title('Original image', 'FontSize', 10)
subplot(1, 3, 3);
imagesc(I2); colormap gray
title('Gamma1 = 2', 'FontSize', 10)

%% 4) Minimum slope for grey value spread/compression
% For a compression, we need to map a larger interval into a smaller one.
% Thus, the slope must be lower than 1.
% The spread is the opposite, so the slope must be greater than 1.

% For example, for gamma = 0.5, the transformation spread the low values
% of grey, and compress high values of grey.