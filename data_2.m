%1.	Data Creation and Storage: Create the following matrices: 
%a.	An 11x11 matrix containing zeros, and name it Z11
Z11 = zeros(11,11);

%b.	A 11x11 matrix of random integers, and name it R11
R11 = random('normal',5,1,11,11);
R11 = round(R11);

%2.	Data Extraction: Extract the following items from R11 created in part(a):
%a.	Element located on the 2nd row and 5th column, and name it E25
E25 = R11(2,5);

%b.	The entire fifth row, and name it Row5
Row5 = R11(5,:);
%c.	The entire 4th column, and name it Col4
Col4 = R11(:,4);

%d.	The Subsection of elements starting from the element 
%located on the 2nd row and 2nd column, and ending at the element located on the 10th row and 9th column, and name it Sub22109
Sub22109 = R11(2:10,2:9);

% 3.	Data Replacement: Replace the subsection, 
% Sub22109, in matrix R11, with the corresponding 
% subsection in matrix Z11, and name it R11Mod
 sz = size(Sub22109);
 sz2 = size(R11);
 start = sz2(1)-sz(1);
 stop = sz2(2)-start;
 R11Mod = R11;
 R11Mod(start:stop,start:stop) = Z11(start:stop,start:stop); 
 
% 4.	Searching Through Data: Search through matrix R11 to find a specific element, SE (e.g. SE = 5), using:
% a.	For loops and if statements
% b.	Logical matrices
% c.	The find function in Matlab

%4a
count = 0;
for i=1:sz2(1)*sz2(2)
    if R11(i)==5
        count = count + 1;
    end
end

%4b
logicSearch = R11==5;
%4c
findRes = find(R11==5);

% 5.	Sorting Data: sort matrix R11 by:
% a.	Rows
% b.	Columns

%4a
A= sortrows(R11);
%4b
B = sortrows(R11,1:11);

% 6.	Obtain Basic Statistics: obtain the mean, min, and max values from the:
% a.	entire matrix R11
% b.	Row 2 of matrix R11
% c.	Col 4 of matrix R11
% d.	Subsection Sub22109 of matrix R11, obtained in part 2d above

 max=-1; min=999999999999; sum=0; Row2sum=0; Row2max=max; Row2min=min;
 Col4min = min; Col4max= max; Col4sum = 0; 
 
     
for c = 1:sz2(2)
    for r = 1:sz2(1)
        %avg of R11
        sum = sum + R11(r,c);
        avg = sum/(sz2(1)*sz2(1));
        %max of R11
        if(max<R11(r,c))
            max=R11(r,c);
        end
        %min of R11
        if(min>R11(r,c))
            min=R11(r,c);
        end
        %row2 avg,max,min
        if(r==2)
        %row2 avg
        Row2sum = Row2sum + R11(r,c);
        Row2avg = Row2sum/(sz2(1));
        %row2 max
        if(Row2max<R11(r,c))
            Row2max=R11(r,c);
        end
        %row2 min
        if(Row2min>R11(r,c))
            Row2min=R11(r,c);
        end
        end
        %col 4 avg,max,min
        if(c==4)
            %col 4 avg
        Col4sum = Col4sum + R11(r,c);
        Col4avg = Col4sum/(sz2(2));
        %col 4 max
        if(Col4max<R11(r,c))
            Col4max=R11(r,c);
        end
        %col 4 min
        if(Col4min>R11(r,c))
            Col4min=R11(r,c);
        end
        end
    end
end 

  sumSub = 0; maxSub=0; minSub = 99999999999;
for c = 1:sz(2)
    for r = 1:sz(1)
        %avg of Subsection
        sumSub = sumSub + Sub22109(r,c);
        avgSub = sumSub/(sz(1)*sz(1));
        %max of Subsection
        if(maxSub<Sub22109(r,c))
            maxSub=Sub22109(r,c);
        end
        %min of Subsection
        if( minSub>Sub22109(r,c))
             minSub=Sub22109(r,c);
        end  
    end
end 

 %Q7 Sine wave plot
x = -2*pi:0.1:2*pi;
plot(x,sin(x)), grid on;
xlabel('radians');
ylabel('amplitude');
title('sin(x)');


 