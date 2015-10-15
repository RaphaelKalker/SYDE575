%SYDE 575 Lab 2
%Names (ID): 
%Jacinta Ferrant (20446891)
%Raphael Kalker (20423222)
%Date: Oct. 16, 2015
close all;
clear all;
clc;


%Generate toy image using given code
toyImage = [0.3*ones(200,100) 0.7*ones(200,100)];

%Plot the generated toy image
f1 = figure(1);
imshow(toyImage);
Plotter.saveFig(f1);

%Technically, all the following functions default to the desired values,
%but they have been explicitely specified for clarity
gaussian = imnoise(toyImage,'gaussian',0, 0.01);
saltpepper = imnoise(toyImage,'salt & pepper', 0.05);
speckle = imnoise(toyImage,'speckle', 0.04);

%Gaussian noisy toy image
Plotter.plotImageAndHistogram(gaussian);

%Salt and Pepper noisy toy image
Plotter.plotImageAndHistogram(saltpepper);

%Speckle noisy toy image
Plotter.plotImageAndHistogram(speckle);

%load and plot original lena image
lena = imread('lena.tiff');
% Plotter.plotImage(lena);


%convert lena.tiff to a grayscale image
greyLena = rgb2gray(lena);
Plotter.plotImageAndHistogram(greyLena);


%Get Lena image intensity within 0 to 1 range
dLena = im2double(greyLena);

%Apply gaussian noise to Lena image
gNoisyLena = imnoise(dLena,'gaussian',0,0.002);

%Plot the gaassian noisy lena image and its corresponding histogram
Plotter.plotImageAndHistogram(gNoisyLena);

%Compute the psnr between the gaussian noisy image and original noise-free image
psnrLena = PSNR(gNoisyLena, dLena)


%Create a 3 x 3 average filter
avgFilter33 = fspecial('average', [3 3]);
figAvgFilter = figure();
imagesc(avgFilter33);
colormap gray;
colorbar;
Plotter.saveFig(figAvgFilter);

%Apply 3 x 3 average filter to guassian noisy Lena image
avgLena33 = imfilter(gNoisyLena, avgFilter33);
Plotter.plotImageAndHistogram(avgLena33);

%Compute the psnr between the 3 x 3 average filter de-noised image and original noise-free image
psnrAvgLena33 = PSNR(avgLena33, dLena)

%Create a 7 x 7 average filter
avgFilter77 = fspecial('average', [7 7]);

%Apply 7 x 7 average filter to gaussian noisy Lena image
avgLena77 = imfilter(gNoisyLena, avgFilter77);
Plotter.plotImageAndHistogram(avgLena77);




%Compute the psnr between the de-noised 7 x 7 average filter image and original noise-free image
psnrAvgLena77 = PSNR(avgLena77, dLena)

%Create a 7 x 7 Gaussian filter
gaussFilter77 = fspecial('gaussian', [7 7], 1);
gaussFilterFig = figure();
imagesc(gaussFilter77);
colormap gray;
Plotter.saveFig(gaussFilterFig);

%Apply 7 x 7 Gaussian filter to gaussian noisy image
gaussLena77 = imfilter(gNoisyLena, gaussFilter77);
Plotter.plotImageAndHistogram(gaussLena77);


%Compute the psnr between 7 x 7  Gaussian filter de-noised image and original noise-free image
psnrGaussLena77 = PSNR(gaussLena77, dLena)

% Create a Salt & Pepper Noisy Image
spNoisyLena = imnoise(dLena,'salt & pepper',0.04);
Plotter.plotImageAndHistogram(spNoisyLena);

PSNR(dLena, spNoisyLena)


% Apply 7 x 7 average filter to Salt and Pepper noisy image
avgSpLena77 = imfilter(spNoisyLena, avgFilter77);
Plotter.plotImageAndHistogram(avgSpLena77);

%Compute the psnr between the de-noised image and original noise-free image
psnrAvgSpLena77 = PSNR(avgSpLena77, dLena)

% Apply 7 x 7 Gaussian filter to Salt and Pepper noisy image
gaussSpLena77 = imfilter(spNoisyLena, gaussFilter77);
Plotter.plotImageAndHistogram(gaussSpLena77);

%Compute the psnr between the 7 x 7 gaussian filter de-noised image and original noise-free image
psnrGaussSpLena77 = PSNR(gaussSpLena77, dLena)

% Apply Median Filter to Salt and Pepper Lena image
medFiltered = medfilt2(spNoisyLena);
Plotter.plotImageAndHistogram(medFiltered);

%Compute the psnr between the med filter de-noised image and original noise-free image
psnrMedFilter = PSNR(medFiltered, dLena)

% Load Cameraman image
cameraman = imread('cameraman.tif');

%Get cameraman image intensity within 0 to 1 range
dCameraman = im2double(cameraman);
%Apply 7 x 7 Gaussian filter on Cameraman image
cameramanFiltered = imfilter(dCameraman, gaussFilter77);
%Subtract Gaussian filtered image from original cameraman image
subtractedCameraman = dCameraman-cameramanFiltered;
Plotter.plotImages(cameraman, subtractedCameraman);

%Add original image to subtracted image
addedCameraman = dCameraman + subtractedCameraman;
Plotter.plotImages(cameraman, addedCameraman);

%Multiply subtracted image by 0.5 and then add to original image
multiCameraman = dCameraman + .1*subtractedCameraman;
Plotter.plotImages(cameraman, multiCameraman);