%butterbo gezdirme%
%Homework 4
clear,clc% degiskenler sifirlama ve bellegi temizleme
fileName = 'Fig0333(a)(test_pattern_blurring_orig).tif';
I = imread(fileName);
%figure,imshow(I); title('First Image');
if size(I,3)>1 
    I=rgb2gray(I);
end


[M, N] = size(I);
im = im2double(I);

sm = 3;
[x, y] = meshgrid(-2*sm:1:2*sm, -2*sm:1:2*sm);
%flt = exp(-(x.^2+y.^2)/(2*sm^2));

DW = 6; % filtre genişliği
n = 20; % keskinliği ayarlamak için

flt = 1-1./(1+((DW./(x.^2-y.^2))^2*n));

flt = flt./sum(sum(flt));

I = imfilter(im,flt,'symmetric', 'same');

imshowpair(im, I, 'montage', 'Scaling', 'none');