function y = GammaTransfo(x,c,gamma) 
y = c * x.^gamma;
% to normalize the result between 0 and 255
% y = 255*(y - min(min(y))) ./ ( max(max(y)) - min(min(y)) ); 
end