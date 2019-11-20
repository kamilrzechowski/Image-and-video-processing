lena = imread('D:\user\D_UNI\EIT_Digital_Master\YEAR_2\ImageVideoProcessing\projects\project1\images\lena512.bmp');
% imshow(lena);

%% plot histogram
figure;
lena_hist = histogram(lena(:));
% imhist(lena);

%% simulate low contrast with a and b
a = 0.2; b = 50;

lc_lena = min(max(a.*lena + b, 0), 255);


figure; 
subplot(121);
imshow(lena); title('lena');
subplot(122);
imshow(lc_lena); title('low contrast lena');

figure;
subplot(121);
imshow(lc_lena); title('low contrast lena');
subplot(122);
imagesc(lena, [0,255]); title('imagesc');

%histogram plot
figure; 
subplot(121);
imhist(lena);  title('histogram lena');
subplot(122);
imhist(lc_lena); title('histogram low contrast lena');

%% histogram equalization

%hist cumputed manually
dim1 = size(lena, 1);
dim2 = size(lena,2);

h = zeros(1,256);
% prob = zeros(1,255);  %probability of the gray level

for i = 1:dim1
    for j= 1:dim2
        x = lc_lena(i,j);
        h(1,x) = h(1,x) + 1;
    end
end
figure;
plot(h);

minGray = min(min(lc_lena));
maxGray = max(max(lc_lena));

prob = h./length(vectLena);
figure; plot(prob);

figure; plot(cumsum(prob));

rangeCMF = cumsum(prob).*255;

lc_lena_copy = lc_lena;

for i = 1:dim1
    for j= 1:dim2
        lc_lena_copy(i,j) = rangeCMF(lc_lena_copy(i,j));
    end
end

figure;
subplot(131);
imshow(lena); title('original lena');
subplot(132);
imshow(lc_lena); title('low contrast lena');
subplot(133);
imshow(lc_lena_copy); title('after equalization');

%% wiener filter
img_org = imread('images/lena512.bmp');
img_q = 

h = myblurgen('outoffocus', 8);


