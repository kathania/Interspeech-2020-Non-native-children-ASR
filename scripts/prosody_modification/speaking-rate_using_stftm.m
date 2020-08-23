function speaking_rate_using_stftm(filename, scale)

[x Fs] = audioread(filename);
sent_L = length(x);

%if scale>2|scale<0.5
 %   scale = 0.7;
  %  fprintf('scale has to be in [0.5 2].\n scale is reset to be 1.5.\n')
%end

L       = 256; %frame length
S       = L/4; %hop size
m_S     = round(S/scale);
overlap = L - S;
Nframe  = floor((sent_L-overlap)/S);

a       = 0.50;
b       = -0.50;
n       = 1:L;
win     = sqrt(S)/sqrt((4*a^2+2*b^2)*L)*(a+b*cos(2*pi*n/L));
win     = win(:);
Nit     = 5;

L_recon = round(sent_L/scale);
xfinal  = zeros(L_recon,1);

U = sum(win)/(m_S);

k = 1;
kk = 1;
h = waitbar(0,'Please wait...');
for n = 1:Nframe
    frm = win.*x(k:k+L-1)/U;
    xSTFTM = abs(fft(frm));
    
    if kk+L-1<=L_recon
        res = xfinal(kk:kk+L-1);
    else
        res = [xfinal(kk:L_recon);zeros(L - (L_recon-kk+1),1)];
    end
    x_recon = iterated_recon(xSTFTM, res, Nit, win);
    
    if (kk+L-1<=L_recon)
        xfinal(kk:kk+L-1) = xfinal(kk:kk+L-1) + x_recon;
    else
        xfinal(kk:L_recon) = xfinal(kk:L_recon) + x_recon(1:L_recon-kk+1);
    end
    k = k + S;
    kk = kk + m_S;
    waitbar(n/Nframe, h)
end

close(h)


outfile = [filename(1:end-4),'_SR.wav'];
wavwrite(xfinal, Fs, outfile);


function x_recon = iterated_recon(xSTFTM, x_res, Nit, win)

j = sqrt(-1);
for i = 1:Nit
    phi = phase(fft(win.*x_res)) + randn(size(x_res))*0.01*pi; 
    % random phase purturbation will reduce some resonance.
    % added by Yang Lu
    x = xSTFTM.*exp(j*phi); %M-constraint
    x_recon = ifft(x);
    x_res = real(x_recon);
end

x_recon = x_res;
