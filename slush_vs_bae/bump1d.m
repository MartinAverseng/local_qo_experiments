function [res] = bump1d(x)

AA = 5;
R0 = 0.1;
xS = x/R0;
res = 0*x;
ind = abs(xS) < 1;
xS = xS(ind);
res(ind) = exp(AA*xS.^2./(xS.^2-1));


end

