%Histogram esitleme%
%Homework 2
clear,clc% degiskenler sifirlama ve bellegi temizleme
fileName = 'Fig0323(a)(mars_moon_phobos).tif';
I = imread(fileName);
figure,imshow(I); title('First Histogram Image');
figure, histogram(I); title('First Histogram');
if size(I,3)>1 
    I=rgb2gray(I);
end
[r,c] = size(I);%r=satir,c=sutun
histeq_final = uint8(zeros(r,c));%sonuc görseli
n=r*c;%tüm pixel
f = zeros(256,1);%frekans 
pdf = zeros(256,1);
cdf = zeros(256,1);
out = zeros(256,1);
cum = zeros(256,1);
for i = 1:r
    for j = 1:c
        value = I(i,j);
        f(value+1) = f(value+1)+1;%hangi pixelden ne kadar var
        pdf(value+1) = f(value+1)/n;
    end
end
sum = 0;
L = 255;
for i = 1:size(pdf)
    sum = sum + f(i);%bir öncekine ekleyerek pixelin
    cum(i) = sum;%cumulatif hesaplaması yapıyoruz
    cdf(i) = cum(i)/n;%çıkan olasılığı yukarı yuvarlıyoruz.
    out(i) = round(cdf(i)*L);
end
for i = 1:r
    for j = 1:c
        histeq_final(i,j) = out(I(i,j)+1);
    end
end
%plot(cdf);
figure,imshow(histeq_final); title('Histogram Image');
figure, histogram(histeq_final); title('My function Histogram');
 




 


