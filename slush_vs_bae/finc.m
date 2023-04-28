function [res] = finc(k,X,Y)

thetaInc = 0;
res = exp(1i*k*(cos(thetaInc)*X + sin(thetaInc)*Y));

end

