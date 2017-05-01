RGB = imread('../Images/crop.png');
I = rgb2gray(RGB);
BW = imbinarize(I);
IM = imcomplement(I);

figure, imshow(BW);