function gb=gabor_filter(lambda,theta,psi,bw,gamma, sz)
% function gb=gabor_filter(bw,gamma,psi,lambda,theta, sz)
% lambda= wave length, (>=2)
% theta = angle in rad, [0 pi)
% psi   = phase shift, [0 pi/2]
% bw    = bandwidth, (1)
% gamma = aspect ratio, (0.5)
 
sigma = lambda/pi*sqrt(log(2)/2)*(2^bw+1)/(2^bw-1);
sigma_x = sigma;
sigma_y = sigma/gamma;
 
[x,y]=meshgrid(-fix(sz/2):fix(sz/2),fix(sz/2):-1:fix(-sz/2));
% x (right +)
% y (up +)

% Rotation 
x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);
 
gb=exp(-0.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lambda*x_theta+psi);