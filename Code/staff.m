clc;

RGB = imread('../Images/crop.png');
I = rgb2gray(RGB);
BW = imbinarize(I);
IM = imcomplement(I);
%figure, imshow(BW);

[h,w] = size(BW);
fprintf('Height = %d\n',h);
fprintf('Width = %d\n',w);

count=0;
k=0;
l=0;
staff_lines=[];
staff_lines_count=0;
staff_lines_mid_avg=[];
count_staff_lines_mid_avg=0;
grand_stave_start=[];
count_grand_stave_start=0;
image_count=0;

% Finding Staff Lines
for i=1:1:h
	flag=0;
    for j=1:1:w
        %current_pixel = BW(i,j);
        if (BW(i,j)==0 && BW(i+1,j)==0 && BW(i,j+1)==0 && BW(i,j+2)==0 && BW(i,j+3)==0)
        	l=i;
        	k=j;
        	
        	while(BW(l,k)~=1)
                k=k+1;
        	end
        	
        	if((k-j)>0.7*w)
        		%fprintf('Staff Lines Begin : i=%d & j=%d\n',i,j);
        		if(flag==0)
        			staff_lines = [staff_lines i];
     				staff_lines_count = staff_lines_count+1;
        			flag=1;
        		end
            end

        end
    end
end

fprintf('staff_lines_count = %d\n',staff_lines_count);
disp(staff_lines);


% Finding Grand Staves
grand_stave_start = staff_lines(1);
count_grand_stave_start = 1;

for i=1:staff_lines_count-1
    if( (staff_lines(i+1)-staff_lines(i))>50 )
        count_grand_stave_start = count_grand_stave_start+1;
        grand_stave_start(count_grand_stave_start) = staff_lines(i+1);
    end
end

fprintf('count_grand_stave_start = %d\n',count_grand_stave_start);
fprintf('grand_stave_start:\n');
disp(grand_stave_start);

 
 % Calculating Average Grand Stave Thickness & Grand Stave End
 sum=0;
 upper_limit=0;
 grand_stave_end=[];
 count_grand_stave_end=0;
 
 for i=1:count_grand_stave_start
    grand_stave = [];
    for j=1:staff_lines_count
        if (i<=(count_grand_stave_start-1))
            upper_limit = grand_stave_start(i+1);
        else
            upper_limit = h;
        end
        if( staff_lines(j)>=grand_stave_start(i) && staff_lines(j)<upper_limit )
            grand_stave = [grand_stave staff_lines(j)];        
        end
    end
    
    top = min(grand_stave);
    bottom = max(grand_stave);
    grand_stave_end = [grand_stave_end bottom];
    count_grand_stave_end = count_grand_stave_end+1;
    thickness = bottom-top;
    sum = sum + thickness;
    %fprintf('top = %d & bottom = %d\n',top,bottom);
    %fprintf('thickness = %d\n',thickness);
    %fprintf('sum = %d\n',sum);
    %disp(grand_stave);
    
 end

fprintf('count_grand_stave_end = %d\n',count_grand_stave_end);
fprintf('grand_stave_end:\n');
disp(grand_stave_end);

grand_stave_thickness_avg = round(sum/count_grand_stave_start);
fprintf('grand_stave_thickness_avg = %d\n',grand_stave_thickness_avg);


% Calculating Staff Lines Middle Gap Average
for i=1:staff_lines_count-1
	value = staff_lines(i+1)-staff_lines(i);
	if(value>5 && value<20)
		staff_lines_mid_avg = [staff_lines_mid_avg round((staff_lines(i)+staff_lines(i+1))/2)];
		count_staff_lines_mid_avg = count_staff_lines_mid_avg+1;
	end
end

fprintf('count_staff_lines_mid_avg = %d\n',count_staff_lines_mid_avg);
fprintf('staff_lines_mid_avg:\n');
disp(staff_lines_mid_avg);


% Finding Top Staff Line From Avg Staff Line Gap
top_staff_line_count=0;
for i=1:count_staff_lines_mid_avg
    top_staff_line(i) = staff_lines(max(find(staff_lines<staff_lines_mid_avg(i))));
    top_staff_line_count = top_staff_line_count+1;
end
fprintf('top_staff_line_count = %d\n',top_staff_line_count);
fprintf('top_staff_line:\n');
disp(top_staff_line);


% Calculating Average Distance Between Adjacent Staff Lines
sum=0;
difference=0;
for g=1:count_grand_stave_start
    for i=1:top_staff_line_count
        if (top_staff_line(i)>=grand_stave_start(g) && top_staff_line(i)<=grand_stave_end(g))
            if(mod(i,4)~=0)
                difference = top_staff_line(i+1) - top_staff_line(i);
            else
                difference = grand_stave_end(g) - top_staff_line(i);
            end
            sum = sum + difference;
        end
    end
end
staff_line_width_avg = round(sum/top_staff_line_count);
fprintf('staff_line_width_avg = %d\n',staff_line_width_avg);


% Note Cropping (Segmentation)
for g=1:count_grand_stave_start
    fprintf('\ng =  %d',g);
    lower_limit = grand_stave_start(g);
    if((g+1)<=count_grand_stave_start)
        upper_limit = grand_stave_start(g+1);
    else
        upper_limit = h;
    end
    fprintf('\nlower_limit =  %d & upper_limit = %d\n',lower_limit,upper_limit);
    jump=0;
    
    for i=1:w
        flag=0;
        if(i<(jump+50) && jump~=0)
            flag=1;
        end
        
        for j=1:count_staff_lines_mid_avg
            current_i = staff_lines_mid_avg(j);

            if (current_i>lower_limit && current_i<upper_limit)
                %fprintf('\ncurrent_i = %d',current_i);
             
                if(BW(current_i,i)==0 && flag==0 && BW(current_i,i+1)==1)
                    I = imcrop(BW, [i-25 lower_limit-20 50 120]);
                    imshow(I);
                    image_count=image_count+1;
                    filename = strcat('../Output/Symbol_', num2str(image_count),'.png');
                    imwrite(I,filename,'png');
                    jump=i;
                    flag=1;
                end
                
            end
        end    
    end    
end


bar=[];
bar_count=0;

for g=1:count_grand_stave_start
    flag=[];
    loop_counter=0;
    for i=grand_stave_start(g)-5:grand_stave_end(g)+5
        for j=1:w
            if (BW(i,j)==0 && BW(i+1,j)==0 && BW(i+2,j)==0)
                l=i;
                k=j;

                while(BW(l,k)~=1)
                    l=l+1;
                end

                if((l-i)>(0.9*grand_stave_thickness_avg))
                    value = find(flag==j);
                    if(isempty(value))
                        bar_count = bar_count+1;
                        flag = [flag j];
                        loop_counter = loop_counter+1;
                    end
                end
                
            end
        end
    end
    
    flag=sort(flag);
    
    while(loop_counter~=40)
        flag=[flag 0];
        loop_counter=loop_counter+1;
    end    
    bar = [bar; flag];
    
end
fprintf('Bar:\n');
disp(bar);

bar_limits=[];
lower_limit=[];
upper_limit=[];
[r,c]=size(bar);

for row=1:r
    array = bar(row,:);
    j=1;
    k=j+1;
    temp_lower=[];
    temp_upper=[];
    loop_counter=0;
    while(array(j)~=0)
        if ((array(k)-array(j))>2)
            temp_lower = [temp_lower array(j)];
            temp_upper = [temp_upper array(k)];
            loop_counter=loop_counter+1;
        end
        j=j+1;
        k=k+1;
    end
    
    while(loop_counter~=20)
        temp_lower=[temp_lower 0];
        temp_upper=[temp_upper 0];
        loop_counter=loop_counter+1;
    end
    bar_limits = [bar_limits; temp_lower];
    bar_limits = [bar_limits; temp_upper];
end
fprintf('bar_limits:\n');
disp(bar_limits);

[r,c]=size(bar_limits);
max_length=0;
fprintf('\nBar Lower Limit to Bar Upper Limit:');
for i=1:2:r
    fprintf('\n\nRow No = %d',i);
    j=1;
    while(bar_limits(i,j)~=0)
        fprintf('\n%d to %d   ',bar_limits(i,j),bar_limits(i+1,j));
        j=j+1;
    end
    if (j>=max_length)
        max_length=j;
    end
end

fprintf('\n\nmax_length = %d',max_length);
bar_limit_difference=[];
for i=1:2:r
    difference=0;
    loop_counter=0;
    temp=[]; 
    j=1;
    while(bar_limits(i,j)~=0)
        difference = bar_limits(i+1,j) - bar_limits(i,j);
        temp=[temp difference];
        loop_counter=loop_counter+1;
        j=j+1;
    end
    
    while(loop_counter~=max_length)
        temp=[temp 0];
        loop_counter=loop_counter+1;
    end 
    bar_limit_difference = [bar_limit_difference; temp];
end

fprintf('\nbar_limit_difference:\n');
disp(bar_limit_difference);
    
% X = imcrop(IM, [50 grand_stave_start(1) 332 110]);
% imshow(X);