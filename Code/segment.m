clc;

RGB = imread('../Images/test_staff.png');
I = rgb2gray(RGB);
BW = imbinarize(I);
IM = imcomplement(I);

[h,w] = size(IM);
fprintf('Height = %d\n',h);
fprintf('Width = %d\n',w);

projection_on_y = sum(IM,2);
%disp(projection_on_y);

% gMax = max(projection_on_y);
% threshold1 = int32(0.95*gMax);
% fprintf('gMax = %d\n',gMax);
% fprintf('threshold1 = %d\n', threshold1);

projection_on_x = sum(IM,1);
%disp(projection_on_x);

mMax = max(projection_on_x);
threshold2 = int32(0.95*mMax);
fprintf('mMax = %d\n',mMax);
fprintf('threshold2 = %d\n', threshold2);

[pks_y,loc_y] = findpeaks(projection_on_y);
% fprintf('Peaks Y Size = %d\n', size(pks_y));
% fprintf('Peak = %d; Loc = %d\n',pks_y,loc_y);

[pks_x,loc_x] = findpeaks(projection_on_x);
% fprintf('Peaks X Size = %d\n', size(pks_x));
fprintf('Peak = %d; Loc = %d\n',pks_x,loc_x);

% figure, findpeaks(projection_on_y);
figure, findpeaks(projection_on_x);

% MIN_WIDTH_THRESHOLD=18*2;
% MIN_HEIGHT_SUM_THRESHOLD=70*2;

% avg = mean(projection_on_x);
% disp(avg);
% disp(max(pks_x));
% disp(max(loc_x));