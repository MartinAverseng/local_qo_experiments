%% Path and cleaning

clear all;
close all

cd ..
addpath(genpath("ffmatlib"));
cd twoMeshTest/

%% Data retrieval

k = 50;
[p,b,t]=ffreadmesh(['export_mesh_k_',num2str(k),'h1h2.msh']);
[vh]=ffreaddata(['export_vh_k_',num2str(k),'h1h2.txt']);
u=ffreaddata(['export_data_k_',num2str(k),'h1h2.txt']);

xm = 1.1;
xM = 2.1;
xC = (xM + xm)/2;

ym = 0;
yM = 1;
yC = (yM + ym)/2;
N = ceil(200*k/(2*pi));
x = linspace(xm,xM,N);
y = linspace(ym,yM,N);
[X,Y] = meshgrid(x,y);

data = ffinterpolate(p,b,t,vh,X,Y,u);


%% Fourier analysis
close all;

r0c = sqrt((X - xC).^2 + (Y - yC).^2);
Rbump = 0.5;
bump = (exp(1.)*exp(-1./(1 - (r0c/Rbump).^2)));
bump(r0c >= Rbump) = 0;

thetaInc = pi/2;
finc = exp(1i*k*(cos(thetaInc)*X + sin(thetaInc)*Y));
err = bump.*(data-finc);
% f = k/2pi

%ffpdeplot(p,b,t,'VhSeq',vh,'XYData',log(1e-10 + abs(real(u)))/log(10),'ZStyle','continuous','Mesh','off');
figure
imagesc(x,y,real(err));
title("Interpolated function")
W = fftshift(fft2(err));



l1 = sqrt(sum(sum(abs(W).^2)))/N^2;

Fsx = N/(xM - xm);
Fsy = N/(yM - ym);

fx = (-(N/2-1):N/2)/N*Fsx;
fy = (-(N/2-1):N/2)/N*Fsy;

kx = 2*pi*fx;
ky = 2*pi*fy;

[Kx,Ky] = meshgrid(kx,ky);

WLF = W;
WLF((Kx.^2 + Ky.^2) > 4*k^2)= 0;
WHF = W - WLF;

wHF = ifft2(ifftshift(WHF));
wLF = ifft2(ifftshift(WLF));
figure;
imagesc(x,y,real(wLF));
title("Low-frequency part of w")
figure;
imagesc(x,y,real(wHF));
title("High-frequency part of w")
H = k^(-2).*(Kx.^2 + Ky.^2);

l1 = sqrt(l1.^2 + sum(sum(H.*abs(W).^2)))/N^2;
errH1kHF = sqrt(sum(sum(abs(WHF).^2)) + sum(sum(H.*abs(WHF).^2)))/N^2
errH1kLF = sqrt(sum(sum(abs(WLF).^2)) + sum(sum(H.*abs(WLF).^2)))/N^2
errTot = sqrt(sum(sum(abs(WLF).^2)) + sum(sum(H.*abs(W).^2)))/N^2

