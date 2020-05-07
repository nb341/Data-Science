
clc;
close all;
clear all;
%reads csv file as a table to get all values (text and numeric)
T = readtable('Eco-Totem_Broadway_Bicycle_Count.csv');
%stores all strings and text data in textdata
textdata = T(:,1:4);
%stores all numeric value in data
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
%initialises matrix to all zeros to prevent garbage data and test matrix
%processng ability and if enough memory is available
Data_Matrix = zeros(NoSamples,9);
%stores the year, month and day in columns 1 to 3
Data_Matrix(:,1:3) = Vec_Dates(:,1:3);
%stores the hours, minutes in cols 4 to 5
Data_Matrix(:,4:5) = Vec_Times(:,4:5);
%stores the total amount of cyclist on a particular day in col 6
Data_Matrix(:,6) = data(1:NoSamples,1);
%stores the total amount of cyclist on a particular day on the westbound
%side in col 7
Data_Matrix(:,7) = data(1:NoSamples,2);
%stores the total amount of cyclist on a particular day on the eastbound
%side in col 8
Data_Matrix(:,8) = data(1:NoSamples,3);
%forgot to include vec_days initially so placed in last column (9)
Data_Matrix(:,9) = Vec_Day;

%Start of Question 1

%creates a logical vector column to highlight the range of indexes between 
%2017 and 2018   
data2017_18 = (Data_Matrix(:,1)<=2018)&(Data_Matrix(:,1)>=2017);
%intializes a row vector to the length of the all rows in the imported data
%set
dataIndex = 1:NoSamples;
%gets the actual indices of the range of data to be used
indices_data2017_18 = dataIndex(data2017_18>0);
%gets the actual values within the range stores it in a matrix
Data_data2017_18 = Data_Matrix(indices_data2017_18,:);
%sums of up the total cyclists in the data set
totalCyclist2017_18 = sum(Data_data2017_18(:,6));
  
  
  %sort matrix according to the months to run faster
   Data_data2017_18= sortrows(Data_data2017_18,2);

  %initialises matrices to all zeros to hold months and total cyclists
  months = zeros(12,2);
%gets the total cyclist for each month between 2017 and 2018
for month=1:12
    %logical matrix to find values for the month during iteration
     data2017_18_month_L = (Data_data2017_18(:,2)==month);
     %gets the indices of the values of the particular month
     data2017_18_month_I = 1:length(data2017_18_month_L);
     %gets the indices for the relevant month
     indices = data2017_18_month_I(data2017_18_month_L>0);
     %gets the actual values and stores it
     data2017_18_month_E = Data_data2017_18( indices,:);
     %store the current month being processed in the 1st column
     months(month,1) = month;
     %stores the sum of the current month in the 2nd column
     months(month,2) = sum(data2017_18_month_E(:,6));       
end

 
%plots cyclists vs months for two years 2017 and 2018
figure(1);
bar(months,3);
ylabel('Total Cyclist');
xlabel('Months');
set(gca,'xtick',1:12,...
 'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});

%Question 1 ends


%Question 2 starts


%creates boolean vector with indices of relevant row 
%for the first week of April
data_aprL = (Data_data2017_18(:,1)==2017)&(Data_data2017_18(:,2)==4)&((Data_data2017_18(:,3)>=1)&(Data_data2017_18(:,3)<=7));
%gets the number of rows to be used as indice
indices = 1:length(data_aprL);
%gets the indice of the relevant rows
dataindex_apr = data_aprL(indices>0);
%gets the actual values in the row
data_apr = Data_data2017_18(dataindex_apr,:);
data_apr = sortrows(data_apr,3);

%creates boolean vector with indices of relevant row 
%for the first week of July
data_julL = (Data_data2017_18(:,1)==2017)&(Data_data2017_18(:,2)==7)&((Data_data2017_18(:,3)>=1)&(Data_data2017_18(:,3)<=7));
%gets the number of rows to be used as indice
indices = 1:length(data_julL);
%gets the indice of the relevant rows
dataindex_jul = data_julL(indices>0);
%gets the actual values in the row
data_jul = Data_data2017_18(dataindex_jul,:);
%sort to verify data later on by sight
data_jul = sortrows(data_jul,3);
%initialises 7x3 matrix with all zeros to hold total 
% for first week in april and july
   days=zeros(7,3);
   
   %searches for the relevant days and get the total cyclists for days
   %for 1st week of selected months
for day=1:7
    days(day,1) = day;
    %logical matrix to find values for the day during iteration
     day_L_apr = (data_apr(:,3)==day);
     %gets the indexes of the values of the particular day
     day_I_apr = 1:length(day_L_apr);
     %gets the indice for the specific days
     indices_apr = day_I_apr(day_L_apr>0);
     %gets the actual values and stores it
     day_E_apr = data_apr( indices_apr,:);
     
     %stores the sum of the current day in April in the 2nd column
     days(day,2) = sum(day_E_apr(:,6));  
     
      %%logical matrix to find values for the day during iteration
     day_L_jul = (data_jul(:,3)==day);
     %gets the indexes of the values of the particular day
     day_I_jul = 1:length(day_L_jul);
     %gets the indice for the specific days
     indices_jul = day_I_jul(day_L_jul>0);
     %gets the actual values and stores it
     day_E_jul = data_jul( indices_jul,:);
     %store the current day being processed
     %stores the sum of the current day in the 3rd column
     days(day,3) = sum(day_E_jul(:,6));  
end

%Plots cyclists vs days of the week using a bar graph
figure(2);
bar(days(1:7,2:3));
ylabel('Number of Cyclist');
xlabel('Days');
set(gca,'xtick',1:7,...
 'xticklabel',{'Sun','Mon','Tues','Wed','Thurs','Fri','Sat'});

%Question 2 ends

%Question 3 starts
%creates boolean column vector with true values for
%the location of relevant row pertaining to Monday and Sat
data_2daysL = (data_jul(:,9)==2)|(data_jul(:,9)==7);
%gets length of vector to be used as row index
indices_2days = 1:length(data_2daysL);
%gets only true values ie relevant row locations
dataindex_2days = data_2daysL(indices_2days>0);
%gets relevant values and stores it
data_2days = data_jul(dataindex_2days,:);
%sort to very by sight later on
sortrows(data_2days,4);
%initalise matrix to all zeros to prevent garbage values
hours = zeros(24,3);
%initialises first column to 0 to 23
%first hour starts at 0 ends at 1 etc
hours(1:24,1) = 0:23;
for i=1:1:24
    %%% obtain logical matrix for each hour of saturday
    hoursSatL = (data_2days(:,9)==7)&(data_2days(:,4))==hours(i,1);
    %%% obtain hourly values
    hoursSat = data_2days(hoursSatL,6);
    %%% sum the hourly values for sat stored in col 3
    hours(i,3) = sum(hoursSat);
    
     %%% obtain logical matrix for each hour of Monday
    hoursMonL = (data_2days(:,9)==2)&(data_2days(:,4))==hours(i,1);
    %%% obtain hourly values
    hoursMon = data_2days(hoursMonL,6);
    %%% sum the hourly values for monday stored in col 2
    hours(i,2) = sum(hoursMon);
end

%plots cyclists versus hours bar graph
figure(3);
bar(hours(1:24,2:3));
ylabel('Number of Cyclist');
xlabel('Hours');
set(gca,'xtick',1:24,...
 'xticklabel',{'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24'});

%Question 3 ends

%extra to confirm get pecertages
sattot = sum(data_jul(193:288,6));
sattot2 = sum(hours(1:24,2));
Tcy = sum(Data_Matrix(:,6));
MonthsT = sum(months(:,2));
Monthsper = 100*sum(months(:,2))/Tcy;
winterM = 100*sum(months(1:3,2))/MonthsT;
springM = 100*sum(months(4:6,2))/MonthsT;
summerM = 100*sum(months(7:9,2))/MonthsT;
fallM = 100*sum(months(10:12,2))/MonthsT;



