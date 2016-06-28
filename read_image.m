function img=read_image(path)

img = imread(path);
imgSize = size(img);
if (numel(imgSize) > 2)
    img = rgb2gray(img);
end
img = imresize(img,[27 18]);