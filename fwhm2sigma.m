function [ sigma ] = fwhm2sigma( fwhm )
sigma = 2*sqrt(2*log(2))*fwhm;

end

