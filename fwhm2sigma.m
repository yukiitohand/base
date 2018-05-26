function [ sigma ] = fwhm2sigma( fwhm )
sigma = fwhm/(2*sqrt(2*log(2)));

end

