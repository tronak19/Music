clc;

% I = imread('../Labels/half.png');
% disp(size(I));
% J = imresize(I, [15 15]);
% disp(size(J));
% subplot(1,2,1), imshow(I);
% subplot(1,2,2), imshow(J);

% A = magic(3);
% disp(A);
% O = reshape(A',1,[]);
% disp(O);

% data = ['dot   '; 'eighth'; 'fourth'; 'g     '; 'half  '; 'o     '; 'flag  '];
% data = ['a   ';'b   ';'c   ';'d   ';
%         'e   ';'f   ';'g   ';'h   ';
%         'i   ';'j   ';'k   ';'l   ';
%         'm   ';'o1  ';'o2  ';'o3  ';
%         'dot ';'flag'];
data = ['1-5';'a-5';'d-5';
        '1  ';'2  ';'3  ';
        'a  ';'d  ';'1-1';
        ];
image_name = cellstr(data);

count=9;
O=[];

for i=1:count
    filename = strcat('../Labels_2/', image_name{i},'.png');
    A = imread(filename);
    O(i,:) = reshape(A',1,[]);
end

csvwrite('../training.csv',O)