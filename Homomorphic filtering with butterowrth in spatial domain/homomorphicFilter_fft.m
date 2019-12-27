%Homomorphic with butterworth filter%
%Homework 7
clear,clc% degiskenler sifirlama ve bellegi temizleme
fileName = 'Fig0338(a)(blurry_moon).tif';
I = imread(fileName);
%figure,imshow(I); title('First Image');
if size(I,3)>1   
    I=rgb2gray(I);end
im = im2double(I);
im = log(im+1); % 0 degerlerinden kurtuluyoruz.
IM = fft2(im); % foruier donusumu yapıyoruz
IM = fftshift(IM);
c=size(IM)/2;
[u, v]=meshgrid(1:size(IM,2), 1:size(IM,1));
D = sqrt((u-c(2)).^2 + (v-c(1)).^2); % butterworth filtremizi hazırlıyoruz
D0=100; n=3;
gammaH=5; gammaL=.2; % Butterworth yüksek geciren filtre oldugu icin
%gammaL büyük seçerek onun baskın olmasını sağlıyoruz.
H = 1./(1+(D./D0).^(2*n));
H = (gammaH - gammaL).*H + gammaL;

IM = H.*IM;
IM = ifftshift(IM);
im2 = ifft2(IM);%ters foruier dönüşümü yapıyoruz
im2 = real(im2);
im2 = exp(im2)-1; % log tersini alıyoruz
lowHigh = stretchlim(im2,0.001);% kontrastı arttıyoruz
im2 = imadjust(im2,lowHigh);% kontrastı geriyoruz

imshowpair(I, im2, 'montage')