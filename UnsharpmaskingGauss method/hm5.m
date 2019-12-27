%Unsharp masking with Gaus method%
%Homework 5
clear,clc% degiskenler sifirlama ve bellegi temizleme
fileName = 'Fig0333(a)(test_pattern_blurring_orig).tif';
I = imread(fileName);
%figure,imshow(I); title('First Image');
if size(I,3)>1 
    I=rgb2gray(I);
end

im = im2double(I);

sigma = 9;
[x, y] = meshgrid(-1*sigma:1:1*sigma, -1*sigma:1:1*sigma);
h = exp(-(x.^2+y.^2)/(2*sigma^2)); % gaus 
h = h./sum(sum(h));
k=9;
h = -k*h;
[M, N] = size(h);
r_mid = round(M/2);
c_mid = round(N/2);
h(r_mid,c_mid) = (8*k)/9+1;

I = imfilter(im,h,'symmetric', 'same');

imshowpair(im, I, 'montage', 'Scaling', 'none');