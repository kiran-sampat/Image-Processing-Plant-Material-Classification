% Clear workspace and close open figures
clear;
close all;

% Load in all the original images
plant001_rgb = imread('images/plant001_rgb.png');
plant017_rgb = imread('images/plant017_rgb.png');
plant223_rgb = imread('images/plant223_rgb.png');

% Call the process function on the images
process(plant001_rgb);
process(plant017_rgb);
process(plant223_rgb);

% Process function takes in one parameter, the image
function process(imgIN)    
    greenImg = imgIN(:,:,2); % filter to green channel
    contrImg = greenImg * 1.2; % increase contrast of image to highlight greater color
    
    noiseImg = medfilt2(contrImg); % median filter noise removal

    binThresh = graythresh(noiseImg); % Otsu thresholding to find ideal threshold
    binImg = imbinarize(noiseImg, binThresh); % binarize image by threshold

    filtImg = bwareafilt(binImg, 4); % filter out objects that are not the largest 4
    imgOUT = bwpropfilt(filtImg, 'Eccentricity', 1, "smallest"); % filter out smaller objects which are non oval-like in shape

    % Show the required images
    %figure, imshow(imgIN), title('image in');
    %figure, imshow(greenImg), title('green channel');
    %figure, imshow(contrImg), title('contrast adjusted');
    %figure, imshow(noiseImg), title('noise filtered');
    %figure, imshow(binImg), title('binary image');
    %figure, imshow(filtImg), title('filtered image');
    figure, imshow(imgOUT), title('image out');
end
