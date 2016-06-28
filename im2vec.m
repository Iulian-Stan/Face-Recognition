function vec = im2vec (im)

load gabor;
im = adapthisteq(im,'Numtiles',[8 3]); 
features = cell(5,8);
for s = 1:5
    for j = 1:8
        features{s,j} = normal(abs(ifft2(G{s,j}.*fft2(double(im),31,31),27,18)));
    end
end
features = cell2mat(features);

%reduce the size of features
features (3:3:end,:)=[];
features (2:2:end,:)=[];
features (:,3:3:end)=[];
features (:,2:2:end)=[];

%transform features amtrix to a vector
vec = reshape (features,[2160 1]);
