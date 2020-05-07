
clc;
close all;
clear all;
%Reads in Boston weather and cyclists dataset as a table
temp = readtable('Boston weather_clean.csv');
T = readtable('Eco-Totem_Broadway_Bicycle_Count.csv');
%stores all strings and text data for cyclists in textdata 
textdata = T(:,1:4);
%stores all numeric value for cyclists in data
data=T{:,5:7};
NoSamples = length(data);
%converts date string to numbers
Vec_Dates = datevec(textdata{1:NoSamples,3},'mm/dd/yyyy');
%converts time string to numbers
Vec_Times = datevec(textdata{1:NoSamples,4},'HH:MM:SS');
%gets days of the week and store it in a column vector
Vec_Day = textdata{1:NoSamples,2};
%converts days of the week to their corresponding num ie sat =7 
Vec_Day = weekday(datenum(Vec_Day,'dddd'));
%converts date to day of the year
d = datetime(textdata{:,3});
Vec_day_of_year = day(d,'dayofyear');
%initialises matrix to all zeros to prevent garbage data and test matrix
%processng ability and if enough memory is available
Data_Matrix = zeros(NoSamples,10);
%stores the year, month and day in columns 1 to 3
Data_Matrix(:,1:3) = Vec_Dates(:,1:3);
%stores the hours, minutes in cols 5 to 6
Data_Matrix(:,5:6) = Vec_Times(:,4:5);
%stores the total amount of cyclist on a particular day in col 7
Data_Matrix(:,7) = data(1:NoSamples,1);
%stores the total amount of cyclist on a particular day on the westbound
%side in col 8
Data_Matrix(:,8) = data(1:NoSamples,2);
%stores the total amount of cyclist on a particular day on the eastbound
%side in col 9
Data_Matrix(:,9) = data(1:NoSamples,3);
% vec_days initially so placed in last column (4)
Data_Matrix(:,4) = Vec_Day;
%stores the converted date to day of the year 
Data_Matrix(:,10) = Vec_day_of_year;
%stores the weather info in data_temp
Data_Temp = temp{:,1:23};

%gets cyclists records for the year 2017
cycDataL = Data_Matrix(:,1)==2017;
cycDataIndex = 1:NoSamples;
cycIndices = cycDataIndex(cycDataL>0);
cyc2017 = Data_Matrix(cycIndices,:);
%sorts rows for eye test
cyc2017=sortrows(cyc2017,2:5);
cyc2017Sum=sum(cyc2017(:,7));
%gets temperature for the year 2017
tempDataL = Data_Temp(:,1)==2017;
tempDataIndex = 1:length(Data_Temp);
tempIndices = tempDataIndex(tempDataL>0);
temp2017 = Data_Temp(tempIndices,:);
temp2017=sortrows(temp2017,2:3);
%QUESTION 1 start here
  %stores the the month, total cyc per month, avg temp per month, avg
  %cyc per month
  months = zeros(12,4);
  months(:,1) = 1:12;
  %used to calculate avg per month
  days = [31 28 31 30 31 30 31 31 30 31 30 31];
for month= 1:1:12
    %gets the total cyclists entries per month in 2017
    cycML = cyc2017(:,2)==month;
    cycMIndex = 1:length(cyc2017);
    cycMIndices = cycMIndex(cycML>0);
    cycM = cyc2017(cycMIndices,:);
    %stores the total cyclists per month in 2017
    sumCyc = sum(cycM(:,7));
    %stores the total cyclist of the month being processed in months
    months(month,2) = sumCyc;
    %stores the avg cyclist per month in months
    months(month,4) = sumCyc/days(month);
    %gets temperature per month in 2017 
    tempML = temp2017(:,2)==month;
    tempMIndex = 1:length(temp2017);
    tempMIndices = tempMIndex(tempML>0);
    tempM = temp2017(tempMIndices,:);
    %calculates the avg temp per month and stores it in months
    months(month,3) = sum(tempM(:,5))/length(tempM);
end
  %plots the total cyclist per month vs avg temp per month
 figure (1);
 title('Average Temperature vs Cyclists Per Month');
 %plots the total cyclists per month using a bar graph
 % with the scale on the left y axis
 yyaxis left
    bar(months(:,2),'y')
     ylabel('Total Cyclists Per Month');
     %Plots the avg temp per month with the scale on the
     %right y-axis
     %plotted using  curve
     yyaxis right
    
    plot(months(:,1),months(:,3),'-bs',...
    'LineWidth',3,...
    'MarkerSize',5,...
    'MarkerEdgeColor','r');
 ylabel('Average Temperature Per Month');
 set(gca,'xtick',1:12,...
  'xticklabel',{'Jan','Feb','Mar','Apr',...
  'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
legend('Cyclists','Temperature');
%QUESTION 1 ends here-----------------------------------------------

%QUESTION 2 starts here--------------------------------------------
temp2017=sortrows(temp2017,1:3);
%caculates the avg precipitation for 2017
avg_pecip = (sum(temp2017(:,22))+sum(temp2017(:,23)))/365;
%stores total precipitation for each day in first column
p2017(:,1) = temp2017(:,22)+temp2017(:,23);
%stores day of the year in 2nd column
p2017(:,2)=1:365;
%finds all the rows above average precipitation  
aboveAvgPreL = p2017(:,1)>avg_pecip;
aboveAvgIndex = 1:length(p2017);
aboveAvgIndices = aboveAvgIndex(aboveAvgPreL>0);
aboveAvgPre = p2017(aboveAvgIndices,:);
%initialises matrix to store relevant values to plot
cyc_pre = zeros(length(aboveAvgPre),4);

for i=1:1:length(aboveAvgPre)
    %gets the cyclists rows that matches the date in aboveAvgPre
     cyc_preL = cyc2017(:,10)==aboveAvgPre(i,2);
     cyc_preIndex = 1:length(cyc2017);
     cyc_preIndices = cyc_preIndex(cyc_preL>0);
     cyc_preT = cyc2017(cyc_preIndices,:);
     %stores avg precipitation in the 1st col of cyc_pre
     cyc_pre(i,1) = aboveAvgPre(i,2);
     %stores the total cyclists for the current day being processed
     cyc_pre(i,2) = sum(cyc_preT(:,7));
     %converts day of year back to date to match month
     Dt = datetime('1-Jan-2017')+aboveAvgPre(i,2)-1;
     Dt = datevec(Dt);
     %looks for the month the day belongs to and stores the 
     %avg cyclists for that month in the same row as the total cyclists
     %per day
     for j=1:1:12
         if(months(j,1)==Dt(2))
           cyc_pre(i,3) = months(j,1);
           cyc_pre(i,4) = months(j,4);
         end
     end
end
%to calculate % for results section
s = sum(months(:,2));
%plots total cyclist per day (above avg precipitation
%vs avg cyclists per month
figure(2);
%plots total cyc per day using a bar graph
yyaxis left
bar(cyc_pre(:,2),'y');
x = cyc_pre(:,1).';
y = cyc_pre(:,2).';
ylabel('Total Cyclist Per Day')
yyaxis right
%plots avg cyclists per month using line plot (forms a curve)
 plot(cyc_pre(:,4),'-bs',...
     'LineWidth',3,...
     'MarkerSize',5,...
     'MarkerEdgeColor','r');

ax=gca();
ax.XTick = x(1:64);
r1=ax.YAxis(1);
r2=ax.YAxis(2);
%links the axis so the y scale values are the same when comparing
linkprop([r1 r2],'Limits');   
set(gca,'xtick',1:4:64,...
  'xticklabel',{x(1:4:64)});
ylabel('Average Monthly Cyclist')
legend('Total Cyclists Per Day','Average Cyclists Per Month');


