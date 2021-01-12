
%% Import train data from text file.

%% Initialize variables.
filename = 'C:\Users\mina\Desktop\exercise\iris_train.txt';
delimiter = ',';

%% Read columns of data as text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4]
    % Converts text in the input cell array to numbers. Replaced non-numeric
    % text with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData(row), regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if numbers.contains(',')
                thousandsRegExp = '^[-/+]*\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end


%% Create output variable
iristrain = table;
iristrain.VarName1 = cell2mat(raw(:, 1));
iristrain.VarName2 = cell2mat(raw(:, 2));
iristrain.VarName3 = cell2mat(raw(:, 3));
iristrain.VarName4 = cell2mat(raw(:, 4));

%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp;

train1 = table2array(iristrain);
i0=ones(120,1);
train = [i0,train1];   % data set (x)

% Defining classes with numbers 1,2 and 3;
for i=1:120
    if i<41
        class(i) = 1;
    else if i>40 && i<81
            class(i) = 2;
        else
            class(i) = 3;
        end
    end
end

k = 1;
w = -rand(3,5);  % First weight matrix with all entries 
MSE = 4 ;    % Mean square error value
grth_rate = 0.01 ; % Growth rate

% Training Loop
m = 1;  % Iteration number for the whole process

 while m < 40
     
  % Obtain number of misclassified training data in pocket(m)
    Ans_Matrix = w * train';
    n11 = 0;
    n21 = 0;
    for i=1:3      
        for  j=1:120

            if i==1 && j<41 || i==2 && j>40 && j<81 || i==3 && j>80

                if Ans_Matrix(i,j) < 0
                    n11 = n11 + 1;
                end
            else

                if Ans_Matrix(i,j) > 0
                    n21 = n21 + 1;
                end
            end      
        end
    end
    pocket_miscl(m) = n11 + n21; % # of misclassified training data in pocket(m)
    
  % Weight update using error correction -------------------------------------
    for i=1:120
        max_iteration = 100;
        if i<41
            k = 1;
            while k < max_iteration 
                eta = grth_rate ;  
                if (1 - w(1,:)*train(i,:)')^2 > MSE
                    w_up = w(1,:)' + eta*(1 - w(1,:)*train(i,:)')*train(i,:)';
                    w(1,:) = w_up';          
                end
                k = k+1;
            end
        else if i>40 && i<81
             k = 1;
            while k < max_iteration
                eta = grth_rate;     
                if (1 - w(2,:)*train(i,:)')^2 > MSE
                    w_up = w(2,:)' + eta*(1 - w(2,:)*train(i,:)')*train(i,:)';
                    w(2,:) = w_up';       
                end
                k = k+1;
            end
            else
             k = 1;
            while k < max_iteration 
                eta = grth_rate;
                if (1-w(3,:)*train(i,:)')^2 > MSE
                    w_up = w(3,:)' + eta*(1 - w(3,:)*train(i,:)')*train(i,:)';
                    w(3,:) = w_up';      
                end
               k = k+1;
            end
            end
        end
    end
    %w(m+1) = w;
    Ans_Matrix = w * train';
    n12 = 0;
    n22 = 0;
    for i=1:3      
        for  j=1:120

            if i==1 && j<41 || i==2 && j>40 && j<81 || i==3 && j>80

                if Ans_Matrix(i,j) < 0
                    n12 = n12 + 1;
                end
            else

                if Ans_Matrix(i,j) > 0
                    n22 = n22 + 1;
                end
            end      
        end
    end

     pocket_miscl(m+1) = n12 + n22;
% Comparing two pockets 
     if pocket_miscl(m+1)<= pocket_miscl(m) 
         break
         w
     else
         m = m+1;
     end
 end
 
pocket_miscl

w

%Testing----------------------------------------------------------------------------------------------------

%% Import test data from text file.

%% Initialize variables.
filename = 'C:\Users\mina\Desktop\exercise\iris_train.txt';
delimiter = ',';

%% Read columns of data as text:
formatSpec = '%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4]
    % Converts text in the input cell array to numbers. Replaced non-numeric
    % text with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData(row), regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if numbers.contains(',')
                thousandsRegExp = '^[-/+]*\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end


%% Create output variable
iristest = table;
iristest.VarName1 = cell2mat(raw(:, 1));
iristest.VarName2 = cell2mat(raw(:, 2));
iristest.VarName3 = cell2mat(raw(:, 3));
iristest.VarName4 = cell2mat(raw(:, 4));

%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp;


test1 = table2array(iristest);
i0=ones(30,1);
test = [i0,test1];

% Defining classes with numbers 1,2 and 3
for i=1:30
    if i<11
        class(i) = 1;
    else if i>10 && i<21
            class(i) = 2;
        else
            class(i) = 3;
        end
    end
end

% Accuracy
k1 = 0;
k2 = 0;
k3 = 0;
for i=1:30
    if class(i)==1
        if w(1,:)*test(i,:)'>0 && w(2,:)*test(i,:)'<=0 && w(3,:)*test(i,:)'<=0
            k1 = k1 + 1;
        end
    else if class(i)==2
        if w(2,:)*test(i,:)'>0 && w(1,:)*test(i,:)'<=0 && w(3,:)*test(i,:)'<=0
            k2 = k2 + 1;
        end
        else
        if w(3,:)*test(i,:)'>0 && w(1,:)*test(i,:)'<=0 && w(2,:)*test(i,:)'<=0
            k3 = k3 + 1;
        end
        end
    end
end
Accuracy = (k1+k2+k3)/30*100




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Running response for random weight factors

w =

      -0.7729      0.16264      0.17159     -0.29502     -0.91007
     -0.41181      0.31028    -0.096217     -0.11447     -0.54481
     -0.42268    -0.027135     -0.13821      0.17345     0.062601


Accuracy =

       43.333

