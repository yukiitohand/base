function [ fwhm ] = sigma2fwhm( sigma )
fwhm = sigma / 2*sqrt(2*log(2));

end