org_img = imread('images/lena512.bmp');
M = length(org_img);

%Image with noise corupting
gausian_noise = mynoisegen('gaussian', M, M, 0, 164);
img_gaussian_noise = cast(org_img,'double') + gausian_noise;
img_saltp = org_img;
n = mynoisegen('saltpepper', M, M, .05, .05);
img_saltp(n==0) = 0;
img_saltp(n==1) = 255;

% Filter definision
mean_filter = (1/9)*[1 1 1; 1 1 1; 1 1 1];

%Gaussian nosie filtering
imgF_gaussian_mean = cast(conv2(img_gaussian_noise, mean_filter),'uint8');
imgF_gaussian_median =  cast(medfilt2(img_gaussian_noise,[3 3]),'uint8');

%Salt and pepper noise filtering
imgF_saltp_mean = cast(conv2(img_saltp, mean_filter),'uint8');
imgF_saltp_median =  cast(medfilt2(img_gaussian_noise,[3 3]),'uint8');

%show results
imshow(imgF_gaussian_mean);
histogram(imgF_saltp_median);
