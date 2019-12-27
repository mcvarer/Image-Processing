
%load an image with periodic noise
im = imread('Fig0516(a)(applo17_boulder_noisy).tif');
% figure;
% imshow(im,[]);
% title('noisy image');

%In order to perform filtering in the frequency domain, we need to pad the
%image at first
[rows, cols] = size(im);
paddedIm = padarray(im, [rows, cols],'post');
%figure;
%imshow(paddedIm,[]);
%title('padded noisy image');

%Fuurier transform yapıyoruz
fftImg = fft2(paddedIm);
fftImgShifted = fftshift(fftImg); % filtre buna uygulanacak
figure;
% FsNimg = abs(fftImgShifted);
FsNimg = log(1+abs(fftImgShifted));
% FsNimg = imgaussfilt(FsNimg,5);
imshow(FsNimg,[]); %show the Fourier spectrum in log scale
title('Fourier spectrum of the noisy image (shown in log scale)');

pos1 = round(getPosition(impoint())); % user input
y1 = pos1(2)-rows;
x1 = pos1(1)-cols;
pos2 = round(getPosition(impoint())); % user input
y2 = pos2(2)-rows;
x2 = pos2(1)-cols;
pos3 = round(getPosition(impoint())); % user input
y3 = pos3(2)-rows;
x3 = pos3(1)-cols;
pos4 = round(getPosition(impoint())); % user input
y4 = pos4(2)-rows;
x4 = pos4(1)-cols;
% pos5 = round(getPosition(impoint())); % user input
% y5 = pos5(2)-rows;
% x5 = pos5(1)-cols;

%construct butterworth notch reject filters
centers = [x1 y1; x2 y2; x3 y3; x4 y4];
D0 = 80;
order = 2;
r=200;
W = 30;

% % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % Filters % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % 

% Huv = ButterworthNotchFilter(2*rows, 2*cols, centers, D0, order);
% Huv = GaussianNotchFilter(2*rows, 2*cols, centers, D0, order);
% Huv = idealFilter(2*rows, 2*cols, centers, r);
Huv = BandrejectFilter(2*rows, 2*cols, centers, D0, W, order);



figure;
imshow(Huv,[]);
title('Ideal Bandreject Filtresi');

filterImg = real(ifft2(ifftshift(fftImgShifted .* Huv)));
finalResult = filterImg(1:rows, 1:cols);

finalResult = adpmedian(finalResult,9);

% % % % % % % % % Max Filter % % % % % % % % %
%finalResult = ordfilt2(finalResult, 9, ones(3,3));
%finalResult = imgaussfilt(finalResult, 1.2);

windowSize = 5;
psf = ones(windowSize)/windowSize^2; % Uniform box blur
finalResult = conv2(double(finalResult), psf, 'same');



%Min filter
%finalResult = ordfilt2(finalResult, 1, ones(3,3)); 
% Median filter
%finalResult = medfilt2(finalResult,[5 5]);

% H = fspecial('average',3);
% finalResult = imfilter(finalResult,H,'replicate'); 


%figure;
%imshow(finalResult,[]);
%title('final result');
figure, imshowpair(im, finalResult,'montage');
