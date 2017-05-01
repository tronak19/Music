RGB = imread('../Images/crop.png');
I = rgb2gray(RGB);
BW = imbinarize(I);

E=edge(I);
F=edge(I, 'canny');

subplot(1,2,1), imshow(E);
subplot(1,2,2), imshow(F);