%Homomorphic with gaussioan filter spatial domain%
%Homework 8 _ REVISED
clear,clc% degiskenler sifirlama ve bellegi temizleme
fileName = 'Fig0338(a)(blurry_moon).tif';
I = imread(fileName);
%figure,imshow(I); title('First Image');
if size(I,3)>1 
    I=rgb2gray(I);
end
im = im2double(I);
IM = log(im+1);
absIM = abs(IM);
angIM = angle(IM);

k = 15;

h = zeros(3);
h(2,2) = 1;
gaus = 1/k*ones(3) ;

filter  = h - gaus;
IM = imfilter(im,filter,'symmetric', 'same');

im2 = exp(IM) - 1;
im2 = real(im2);
im2(im2<0)=0;

lowHigh = stretchlim(im2,0.001);
im2 = imadjust(IM,lowHigh);
imshowpair(I, im2, 'montage', 'Scaling', 'none')