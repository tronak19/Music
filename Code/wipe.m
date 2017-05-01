clc;

count=52;
image_count=0;
k=0;
l=0;
staff_lines_horizontal=[];
horizontal_count=0;
staff_lines_vertical=[];
vertical_count=0;

for t=1:count
    filename = strcat('../Output/Symbol_', num2str(t),'.png');
    %filename = strcat('../Output/Symbol_5.png');
    I = imread(filename);
    %imshow(I);
    [h,w] = size(I);
    J=I;
    
    % Finding Staff Lines
    for i=1:1:h
        flag_horizontal=0;
        for j=1:1:w
            if (I(i,j)==0)
                l=i;k=j;

                while(I(l,k)~=1 && k<w)
                    k=k+1;
                end

                if((k-j)>0.5*w)
                    if(flag_horizontal==0)
                        staff_lines_horizontal = [staff_lines_horizontal i];
                        horizontal_count = horizontal_count+1;
                        flag_horizontal=1;
                    end
                end

                %h1=j;
                %h2=k;
                
                for m=j:k
                    if (I(l,m)==0 && flag_horizontal==1)
                        J(l,m)=1;
                    end  
                end

            end
        end
    end

    
    for i=1:1:w
        flag_vertical=0;
        for j=1:1:h
            if (I(j,i)==0)
                l=j;
                k=i;
                
                while(I(l,k)~=1 && l<h)
                    l=l+1;
                end
                
                if((l-j)>0.6*h)
                    if(flag_vertical==0)
                        staff_lines_vertical = [staff_lines_vertical i];
                        vertical_count = vertical_count+1;
                        flag_vertical=1;
                    end
                end

                %v1=j;
                %v2=l;
                
                for m=j:l
                    if (I(m,k)==0 && flag_vertical==1)
                        J(m,k)=1;
                    end  
                end
                
            end
        end
    end

%     j=h1;
%     k=h2;
% 
%     for i=1:h
%         for m=j:k
%             if (I(l,m)==0 && flag_horizontal==1)
%                 J(l,m)=1;
%             end  
%         end
%     end
% 
%     j=v1;
%     l=v2;
% 
%     for i=1:w
%         for m=j:l
%             if (I(m,k)==0 && flag_vertical==1)
%                 J(m,k)=1;
%             end  
%         end
%     end


%     fprintf('horizontal_count = %d\n',horizontal_count);
%     disp(staff_lines_horizontal);
%     fprintf('vertical_count = %d\n',vertical_count);
%     disp(staff_lines_vertical);
%     imshow(J);
%     pause(1);
    
    black_pixel=0;
    white_pixel=0;
    height_smallest=h;
    height_largest=0;
    width_smallest=w;
    width_largest=0;
    
    for i=1:h
        for j=1:w
                    
            if J(i,j)==0
                black_pixel = black_pixel+1;
            else
                white_pixel = white_pixel+1;
            end

%             if J(i,j)==0
%                 if (j<width_smallest)
%                     width_smallest=j;
%                 elseif (j>width_largest)
%                     width_largest=j;
%                 end
%                 
%                 if (i<height_smallest)
%                     height_smallest=i;
%                 elseif (i>height_largest)
%                     height_largest=i;
%                 end
%             end

        end
    end
    
    number_of_pixels = numel(J);
    
%     fprintf('black_pixel = %d\n',black_pixel);
%     fprintf('white_pixel = %d\n',white_pixel);
%     fprintf('number_of_pixels = %d\n',number_of_pixels);
    
%     fprintf('width_smallest = %d\n',width_smallest);
%     fprintf('width_largest = %d\n',width_largest);
%     fprintf('height_smallest = %d\n',height_smallest);
%     fprintf('height_largest = %d\n',height_largest);
    
    if(black_pixel>100)
        image_count=image_count+1;
        %J = imcrop(J, [width_smallest height_smallest width_largest height_largest]);
        imshow(J);
        filename = strcat('../Wipe/Symbol_', num2str(image_count),'.png');
        imwrite(J,filename,'png');
    end

end