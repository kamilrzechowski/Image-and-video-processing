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
%imagesc(abs(log2(img_fft)))

%% winner filter
% Compute the Wiener restoration filter:
%
%                   H*(k,l)
% G(k,l)  =  ------------------------------
%            |H(k,l)|^2 + S_u(k,l)/S_x(k,l)
%
% where S_x is the signal power spectrum and S_u is the noise power
% spectrum.
%
% To minimize issues associated with divisions, the equation form actually
% implemented here is this:
%
%                   H*(k,l) S_x(k,l)
% G(k,l)  =  ------------------------------
%            |H(k,l)|^2 S_x(k,l) + S_u(k,l)

%fft of bluring function
%H = psf2otf(h, size(img_org));
%H = fft2(h,M,M);
H = fftshift(fft2(h,M,M));
%H_conj = conj(H);
%HH = H_conj.*H; %% = (abs(H).^2); the same
%power spectrum of original image
%S_f = log10(abs(fftshift(fft2(img_org))).^2 );

   
denom = H.*(abs(H).^2);
denom = denom + fftshift(fft2(noise));
%make sure the denominator is not zero anywhere
denom = max(denom, sqrt(eps));

G = (abs(H).^2) ./ denom;
clear denom

% Apply the filter G in the frequency domain.
J = ifft2(fftshift(G .* fftshift(fft2(img_blured))));
clear G

% If I and PSF are both real, then any nonzero imaginary part of J is due to
J = real(J);
J = cast(rescale(J,0,255),'uint8');
imshow(J);