RGB = imread('../Images/crop.png');
I = rgb2gray(RGB);
BW = imbinarize(I);
IM = imcomplement(I);

%figure, imhist(I);

T = graythresh(I);
IT = im2bw(I,T);
%figure, imshow(IT);
%figure, imshowpair(BW,IT,'montage');

A = blkproc(IM,[15 15],@adapt);
figure, imshow(A);