function out=read_images()
% We load the database the first time we run the program.

global folder extension

Imgs = dir([folder '\*.' extension]);
NumImgs = size(Imgs,1);

image = read_image([folder '\' Imgs(1).name]);
[rows,columns] = size(image);
NumPixels = rows * columns;
out = cell(2, NumImgs);

for index=1:NumImgs
    string = [folder '\' Imgs(index).name];
    a=read_image(string);
    out{1,index} = string;
    out{2,index} = uint8(reshape(a,NumPixels,1)); % Convert to unsigned 8 bit numbers to save memory.
end
