%Anisotropic Gaussian türevi ile kenar belirleme%
%Homework 6
clear,clc% degiskenler sifirlama ve bellegi temizleme
fileName = 'Fig0338(a)(blurry_moon).tif';
I = imread(fileName);
%figure,imshow(I); title('First Image');
if size(I,3)>1 
    I=rgb2gray(I);
end

im = im2double(I);

smoothed = imfilter(im,ones(3)./9, 'symmetric','same');
sigmax = 0.5;
sigmay = 0.9;
sgm = 2;
%[x, y] = meshgrid(-1*sgm:1:1*sgm, -1*sgm:1:1*sgm);
[x, y] = meshgrid(-3*sigmax:0.5:3*sigmax, -3*sigmay:0.5:3*sigmay);
% hdx = -(sqrt(2)*x.*exp(-(x.^2 + y.^2)./(2*sgm^2)))./(2*sgm^3*pi^(1/2)); % gaus türev x
% hdy = -(sqrt(2)*y.*exp(-(x.^2 + y.^2)./(2*sgm^2)))./(2*sgm^3*pi^(1/2));

hdx = -(x.*exp(- x.^2./(2*sigmax^2) - y.^2./(2*sigmay^2)))./(2*sigmax^3*sigmay*pi);
hdy = -(y.*exp(- x.^2./(2*sigmax^2) - y.^2./(2*sigmay^2)))./(2*sigmax*sigmay^3*pi);
dx = imfilter(smoothed, hdx, 'symmetric', 'same');
dy = imfilter(smoothed, hdy, 'symmetric', 'same');
mag = sqrt(dx.^2 + dy.^2);
ang = atan2(dy,dx);
imshowpair(im, mag, 'montage', 'Scaling', 'none');