A = imread("images/lena512.bmp");
%histogram(A(:))

a = 0.2;
%b = 255*(1 - a)*0.5;
b = 50;
G = min(max(a*A + b, 0), 255);
%imagesc(G, [0 255]);
%imshow(A)
%histogram(G(:));
%xlim([0 255])

max_val = max(max(G));
min_val = min(min(G));
G_inline = G(:);
matrix = zeros(6,max_val-min_val);
for i = 1:max_val-min_val + 1
    matrix(1,i) = i+min_val;
end

for i =1:length(G_inline)
    index = G_inline(i)-min_val + 1;
    matrix(2,index) = matrix(2,index) + 1;
end

total_pixel_num = length(G_inline);
for i = 1:max_val-min_val + 1
    matrix(3,i) = matrix(2,i)/total_pixel_num;
end
matrix(4,1) = matrix(3,1);
for i = 2:max_val-min_val + 1
    matrix(4,i) = matrix(3,i) + matrix(4,i-1);
end
for i = 1:max_val-min_val + 1
    matrix(5,i) = matrix(4,i) *255;
    matrix(6,i) = floor(matrix(5,i));
end
G_equalized = G;
[rows columns] = size(G);
for x = 1:rows
    for y = 1:columns
        index = G_equalized(x,y)-min_val + 1;
        G_equalized(x,y) = matrix(6,index); 
    end
end
imshow(G_equalized);
histogram(G_equalized);
