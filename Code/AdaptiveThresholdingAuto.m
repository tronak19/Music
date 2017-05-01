RGB = imread('../Images/crop.png');
I = rgb2gray(RGB);
BW = imbinarize(I);
IM = imcomplement(I);
%imshow(IM);

T1 = adaptthresh(IM,0.4); %Bright Text from Dark Background
T2 = adaptthresh(I,0.4,'ForegroundPolarity','dark'); %Dark Text from Bright Background

%figure
%imshowpair(T1,T2,'montage');

BW1 = imbinarize(I,T1);
BW2 = imbinarize(I,T2);

figure
imshowpair(BW1,BW2,'montage');
%figure
%imshowpair(BW,BW1,'montage');
%figure
%imshowpair(BW,BW2,'montage');