function [V, w, cv] = create_eigen()
%% Loading the database into matrix v
w=read_images();

%% Initializations
N=5;                                % Number of signatures used for each image.
v = cell2mat(w(2,:));

%% Subtracting the mean from v
O=uint8(ones(1,size(v,2))); 
m=uint8(mean(v,2));                 % m is the maen of all images.
vzm=v-uint8(single(m)*single(O));   % vzm is v with the mean removed. 

%% Calculating eignevectors of the correlation matrix
L=single(vzm)'*single(vzm);
[V,~]=eig(L);
V=single(vzm)*V;
V=V(:,end:-1:end-(N-1));            % Pick the eignevectors corresponding to the 10 largest eigenvalues. 

%% Calculating the signature for each image
cv=zeros(size(v,2),N);
for index=1:size(v,2);
    cv(index,:)=single(vzm(:,index))'*V;    % Each row in cv is the signature for one image.
end

save eigen V w cv