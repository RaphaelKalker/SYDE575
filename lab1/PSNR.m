function PSNR_out = PSNR(f, g) %f = reference image, g = test image
[m, n] = size(g);
diffSquared = power(f-g,2);
MSE = 1/(m*n)*sum(diffSquared(:));
PSNR_out = 10*log10(power(max(m, n),2)/MSE);
end


