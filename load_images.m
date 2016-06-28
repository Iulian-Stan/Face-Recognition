function IMGDB = load_images()

global folder extension

out_max = 0.9;  % output for the right face
out_min = 0.1; % output for the wrong face

if exist('imgdb.mat','file')
    load imgdb;
else
    IMGDB = cell (3,[]);
end
disp ('Loading Faces ');
%get all files matching the pattern
folder_content = dir ([folder '/*.' extension]);
nface = size (folder_content,1);
for k=1:nface
    string = [folder '/' folder_content(k).name];
    
    %test if the file already exists
    image_exists=0;
    for index=1:length(IMGDB)
        if strcmp(IMGDB{1,index},string)
            image_exists=1;
        end
    end
    if image_exists==1
        continue;
    end
    
    image = imread(string);
    %convert the image to gray scale and resize 
    if numel(size(image)) > 2
        image = rgb2gray(image);
    end
    image = imresize(image,[27 18]);
    IM {1} = im2vec (image);
    IM {2} = im2vec (fliplr(image));
    IM {3} = im2vec (circshift(image,1));
    IM {4} = im2vec (circshift(image,-1));
    IM {5} = im2vec (circshift(image,[0 1]));
    IM {6} = im2vec (circshift(image,[0 -1]));
    IM {7} = im2vec (circshift(fliplr(image),1));
    IM {8} = im2vec (circshift(fliplr(image),-1));
    IM {9} = im2vec (circshift(fliplr(image),[0 1]));
    IM {10} = im2vec (circshift(fliplr(image),[0 -1]));
    for index=1:size(IM,2)
        IMGDB {1,end+1}= string;
        IMGDB {2,end} = out_min*ones(69,1);
        IMGDB {2,end}(k) = out_max;
        IMGDB (3,end) = {IM{index}};
    end
end
save imgdb IMGDB;