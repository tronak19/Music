% RGB = imread('../Images/crop.png');
RGB = imread('../Images/bwdot.jpg');
I = rgb2gray(RGB);
BW = imbinarize(I);
IM = imcomplement(I);
figure
imshow(BW);
figure
imshow(IM);

[h,w] = size(BW);
fprintf('Height = %d\n',h);
fprintf('Width = %d\n',w);

% i=50;j=110;
% px=BW(j,i);
% disp(px);
% disp(BW(345,900));

%disp(IMAGE(Y,X));X=50;Y=110;

count_bw = 0;
count_im = 0;
length = 0;
k=0;
l=0;

for i=1:1:200
    for j=1:1:w
        pixel = BW(i,j);
        if pixel==1
        	count_bw = count_bw+1;
            %disp(pixel);
        end
    end
end


for i=1:1:200
    for j=1:1:w
        pixel = IM(i,j);
        if pixel==0
        	count_im = count_im+1;
            %disp(pixel);
        end
    end
end

fprintf('Count BW = %d\n',count_bw);
fprintf('Count IM = %d\n',count_im);