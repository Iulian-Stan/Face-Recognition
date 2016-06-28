clear all
close all
clc

global folder extension net IMGDB V w cv

folder = 'faces';
extension = 'jpg';

folder_content = dir ([folder,'/.*',extension]);
nface = size (folder_content,1);

if ~exist('gabor.mat','file')
    disp ('Creating Gabor Filters ...');
    create_gabor;
else
    load gabor.mat;
end

if ~exist('imgdb.mat','file')
    disp ('Reading Files ...');
    IMGDB = load_images;
else
    load imgdb.mat;
end

if ~exist('net.mat','file')
    disp ('Creating Neural Network ...');
    net = create_ffnn(nface, IMGDB);
else
    load net.mat;
end


if ~exist('eigen.mat','file')
    disp ('Configurin Eigen Engine ...');
    [V, w, cv] = create_eigen;
else
    load eigen.mat;
end

Faces