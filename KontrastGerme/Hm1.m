clear,clc% degiskenler sifirlama ve bellegi temizleme
fileName = 'Fig0323(a)(mars_moon_phobos).tif';%dosyanin adi
fileName2 = 'goril_ana.png';%dosyanin adi
I = imread(fileName);
I2 = imread(fileName2);
if size(I2,3)>1 
    I2=rgb2gray(I2);
end
im = im2double(I);
im = log(1+im);
im_min = min(im(:));
im_max = max(im(:));
im = (im-im_min)*(255/(im_max-im_min));
% im = im - min(im(:)); % 
% im = im/(max(im(:))); % 
% im = 255*im; % 
im = uint8(im); %
figure(2);
imshow(im);
