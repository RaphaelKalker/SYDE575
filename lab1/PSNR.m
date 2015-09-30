function PSNR_out = PSNR(f, g) %f = reference image, g = test image
    MAX = 256; %0-255 means 256 values
    [m, n] = size(g);
    
    diffSquared = (double(f)-double(g)).^2;
    MSE = 1/(m*n)*sum(diffSquared(:));
    
    psnr(f,g)
    PSNR_out = 10*log10(power(MAX,2)/MSE)
end
