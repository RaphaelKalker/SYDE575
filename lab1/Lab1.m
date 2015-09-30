%SYDE 575 Lab 1
%Names (ID):
%Jacinta Ferrant (20446891)
%Raphael Kalker (20423222)
%Date: Oct. 2, 2015
close all;
clear all;
clc;

lena = imread('lena.tiff');
tire = imread('tire.tif');
cameraman = imread('cameraman.tif');
figure();
subplot(1,3,1);
imshow(lena);
subplot(1,3,2);
imshow(tire);
subplot(1,3,3);
imshow(cameraman);
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0
                                                    1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
text(0.5, 1,'Original Images','HorizontalAlignment','center','VerticalAlignment', 'top');

% cameraman.tif is already a grayscale image
% convert lena.tiff to a grayscale image
gLena = rgb2gray(lena);

% 3. Digital Zooming

%Reducing resolution by a factor of 4 using bilinear interpolation
rLena = imresize(gLena, 0.25, 'bilinear');
rCameraman = imresize(cameraman, 0.25, 'bilinear');

figure(1);
subplot(1,2,1);
imshow(rLena);
title('Bilinear Reduction: Lena');
subplot(1,2,2);
imshow(rCameraman);
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

figure(2);
subplot(1,3,1);
imshow(nnLena);
title('Nearest Neighbour');
subplot(1,3,2);
imshow(biLena);
title('Bilinear');
subplot(1,3,3);
imshow(bcLena);
title('Bicubic');

figure(3);
subplot(1,3,1);
imshow(nnCameraman);
title('Nearest Neighbour');
subplot(1,3,2);
imshow(biCameraman);
title('Bilinear');
subplot(1,3,3);
imshow(bcCameraman);
title('Bicubic');

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

figure(4);
subplot(2,2,1);
imshow(gLena);
title('Original Image');
subplot(2,2,2);
imshow(c1);
title('Conv h1');
subplot(2,2,3);
imshow(c2);
title('Conv h2');
subplot(2,2,4);
imshow(c3);
title('Conv h3');

%5. Point Operations for Image Enhancement

%The original tire with corresponding histogram
figure(5);
subplot(1,2,1);
imshow(tire);
subplot(1,2,2);
imhist(tire);

%image negative transform (complement) with correspoding histogram
figure(6);
subplot(1,2,1);
negTire = imcomplement(tire);
imshow(negTire);
subplot(1,2,2);
imhist(negTire);

%power law transformations on tire image and corresponding histograms
% for gamma = 0.5
figure(7);
subplot(1,2,1);
normTire = double(tire)/255;
powTire1 = normTire.^0.5;
imshow(powTire1);
subplot(1,2,2);
imhist(powTire1);
%for gamma = 1.3
figure(8);
subplot(1,2,1);
powTire2 = normTire.^1.3;
imshow(powTire2);
subplot(1,2,2);
imhist(powTire2);

%histogram equalization on tire with corresponding histogram
figure(9);
subplot(1,2,1);
eqTire = histeq(tire);
imshow(eqTire);
subplot(1,2,2);
imhist(eqTire);