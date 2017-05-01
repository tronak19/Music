function [y] = adapt(x)
if std2(x) <1
    y = ones(size(x,1),size(x,2));
else
    y = imbinarize(x,graythresh(x));

end