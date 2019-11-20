%load image
img_org = imread('images/lena512.bmp');
M = length(img_org);

%blure image
h = myblurgen('outoffocus', 8);
img_blured = conv2(img_org, h, 'same');
img_blured = min(max(img_blured, 0), 255);
noise = img_blured - round(img_blured);

%fourier transform
img_fft = fftshift(fft2(img_blured));
% imagesc(abs(log2(img_fft)))

% fig = figure;
subplot(121); imshow(fftshift(fft2(img_org)));  title('Fourier spectrum original img');
subplot(122); imshow(fftshift(fft2(img_blured)));  title('Fourier spectrum degraded img');
% print(fig,'spectra','-dpng');
%% wf
im_out = wiener_filter(0, img_blured/255, h, var(noise(:)));
% fig = figure;
subplot(131); imshow(img_org); title('original image');
subplot(132); imshow(uint8(img_blured)); title('degradated image');
subplot(133); imshow(im_out); title('restored image');
% print(fig,'Wiener','-dpng');