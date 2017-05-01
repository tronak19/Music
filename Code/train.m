clc;

%training = csvread('../CSV/training.csv');
%testing  = csvread('../CSV/testing.csv');

training = csvread('../training.csv');

% data = ['dot   '; 'eighth'; 'fourth'; 'g     '; 'half  '; 'o     '; 'x     '];
%data = ['a   ';'b   ';'c   ';'d   ';'e   ';'f   ';'g   ';'h   ';'i   ';'j   ';'k   ';'l   ';'m   ';'o1  ';'o2  ';'o3  ';'dot ';'flag'];
data = ['1-5';'a-5';'d-5';
        '1  ';'2  ';'3  ';
        'a  ';'d  ';'1-1';
        ];
labels = cellstr(data);

t = templateTree();
Mdl = fitensemble(training,labels,'AdaBoostM2',100,t);
%prediction = predict(Mdl,testing);
%disp(prediction);

outputp=[];
test_data = csvread('../test_data.csv');

for i=1:9
    op = predict(Mdl,test_data(i,:));
    disp(op);
end

