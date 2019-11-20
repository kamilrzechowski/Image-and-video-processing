function out_img = wiener_filter(Sx, img, h, var_n)
    gamma = 1;                                % When we have a zero in Sxx,
                                              % we replace by gamma, for
                                              % avoiding NaN.
	[m,n]=size(img);
    H = fft2(h, m, n);                        % Compute DFT of blur_filter
    H_conj = conj(H);                         % Magnitude (element-wise)
    Snn = ones(m,n)*(var_n^2);
    Sx(Sx(:)==0)=gamma;
    k = Snn ./ Sx;                            % finding the ratio of Sxx/Snn
    H_inv = H_conj./((abs(H).^2) + k);        % deblur_filter
    
    G = fft2(img);                            % convert the distorted to fft
    Ghat = G.*H_inv;
    out_img = imadjust(real(ifft2(Ghat)));    % convert the corrected to time
end