RGB = imread('../Images/crop.png');
I = rgb2gray(RGB);
BW = imbinarize(I);

RGB2 = imresize(RGB,0.5);
I = imresize(I,0.5);
BW = imresize(BW,0.5);

subplot(1,3,1), imshow(RGB);
subplot(1,3,2), imshow(I);
subplot(1,3,3), imshow(BW);