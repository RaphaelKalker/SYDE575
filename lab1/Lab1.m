%SYDE 575 Lab 1
%Names (ID): 
%Jacinta Ferrant (20446891)
%Raphael Kalker (20423222)
%Date: Sept. 23, 2015
close all;
clear all;
clc;

lena = imread('lena.tiff');
tire = imread('tire.tif');
cameraman = imread('cameraman.tif');

% cameraman.tif is already a grayscale image
% convert lena.tiff to a grayscale image
gLena = rgb2gray(lena);

% 3. Digital Zooming

%Reducing resolution by a factor of 4 using bilinear interpolation
rLena = imresize(gLena, 0.25, 'bilinear');
rCameraman = imresize(cameraman, 0.25, 'bilinear');

figure();
image1 = imshow(rLena);
title('Bilinear Reduction: Lena');

figure();
image2 = imshow(rCameraman);
title('Bilinear Reduction: Cameraman');

%Zooming using nearest neighbour interpolation
nnLena = imresize(rLena, 4, 'nearest');
nnCameraman = imresize(rCameraman, 4, 'nearest');

%Zooming using bilinear interpolation
biLena = imresize(rLena, 4, 'bilinear');
biCameraman = imresize(rCameraman, 4, 'bilinear');

%Zooming using bicubic interpolation
bcLena = imresize(rLena, 4, 'bicubic');
bcCameraman = imresize(rCameraman, 4, 'bicubic');

figure();
image3 = imshow(nnLena);
title('Nearest Neighbour Interpolation: Lena');

figure();
image4 = imshow(nnCameraman);
title('Nearest Neighbour Interpolation: Cameraman');

figure();
image5 = imshow(biLena);
title('Bilinear Interpolation: Lena');

figure();
image6 = imshow(biCameraman);
title('Bilinear Interpolation: Cameraman');

figure();
image7 = imshow(bcLena);
title('Bicubic Interpolation: Lena');

figure();
image8 = imshow(bcCameraman);
title('Bicubic Interpolation: Cameraman');

%PSNR Computation
%nearest neighbour interpolation
PSNR_nn_lena = PSNR(gLena, nnLena);
PSNR_nn_camerman = PSNR(cameraman, nnCameraman);

%bilinear interpolation
PSNR_bi_lena = PSNR(gLena, biLena);
PSNR_bi_cameraman = PSNR(cameraman, biCameraman);

%bicubic interpolation
PSNR_bc_lena = PSNR(gLena, bcLena);
PSNR_bc_camerama = PSNR(cameraman, bcCameraman);


%4. Discrete Convolution for Image Processing

intensity = double(gLena)/255;
h1=(1/6)*ones(1,6);
h2=h1';
h3=[-1, 1];
c1 = conv2(intensity, h1);
c2 = conv2(intensity, h2);
c3 = conv2(intensity, h3);

figure();
subplot(1,4,1);
imshow(gLena);
subplot(1,4,2);
imshow(c1);
subplot(1,4,3);
imshow(c2);
subplot(1,4,4);
imshow(c3);

%5. Point Operations for Image Enhancement

figure();
subplot(1,2,1);
imshow(tire);
subplot(1,2,2);
imhist(tire);