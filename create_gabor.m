%% Creates 5*8 gabor filters of size 31x31
% 5 - wave length 1..5
% 8 - angles from interval [0;pi)

psi = [0 pi/2];
gamma   = 0.5;
bw      = 1;

G = cell(5,8);
for lambda = 1:5
    for theta = 1:8
        G{lambda,theta}=zeros(31,31);
    end
end
for lambda = 1:5
    for theta = 1:8
        G{lambda,9-theta} = gabor_filter(lambda,pi/8*(theta-1),psi(1),bw,gamma,31)...
            + 1i * gabor_filter(lambda,pi/8*(theta-1),psi(2),bw,gamma,31);
    end
end

figure;
for lambda = 1:5
    for theta = 1:8        
        subplot(5,8,(lambda-1)*8+theta);        
        imshow(real(G{lambda,theta}),[]);
    end
end

for lambda = 1:5
    for theta = 1:8        
        G{lambda,theta}=fft2(G{lambda,theta});
    end
end
save gabor G