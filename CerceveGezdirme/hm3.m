%Cerceve gezdirme%
%Homework 3
clear,clc% degiskenler sifirlama ve bellegi temizleme
fileName = 'Fig0323(a)(mars_moon_phobos).tif';
I = imread(fileName);
%figure,imshow(I); title('First Image');
if size(I,3)>1 
    I=rgb2gray(I);
end

im = im2double(I);

[M, N] = size(im);
k1=0.65;
k2=0.35;
r=11;c=11;

for i=1:M-r+1
    for j=1:N-c+1
        aa = im(i:i+r-1, j:j+c-1);
        x = aa((r+1)/2,(c+1)/2);
        %fun1 = @(x) k1*(x(ceil((i+r)/2),ceil((j+c)/2))-mean2(x)) + k2*mean2(x);
        im(ceil((i+r)/2),ceil((j+c)/2)) = k1*(x-mean2(aa)) + k2*mean2(aa);
        %im(ceil((i+r)/2),ceil((j+c)/2)) = mean2(aa);
    end
end
im = mat2gray(im);
imshow(im);