clc;

count=9;
O=[];

for i=1:count
    filename = strcat('../Test_2/', num2str(i),'.png');
    A = imread(filename);
    O(i,:) = reshape(A',1,[]);
end

csvwrite('../test_data.csv',O)