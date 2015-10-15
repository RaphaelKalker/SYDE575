function psnr = PSNR(A,B)

psnr = 10*log10(1/mean2((A-B).^2))


end