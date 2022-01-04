function CC = open_cc_sheet(farm) % uses the farm number to get the corresponding excel sheet and outputs to table CC
% opens excel sheet depending on the farm
filename = 'CropCircle_SDI3.xls';       %opens excel file
opts = detectImportOptions(filename,'Sheet',farm);  % selects sheet corresponding to specified farm
opts.VariableNames = {'SENSOR_ADDR','NDRE','NDVI','RE','NIR','R'}; % these are the variable that exist in the sheet
opts.SelectedVariableNames = {'SENSOR_ADDR','NDRE','NDVI'}; % these are the variables that we want
opts = setvartype(opts,{'SENSOR_ADDR'},'double'); % sets sensor address variable to type double so we can use it in the switch case
CC = readtable(filename,opts); % reads the sheet in to a table named "CC"
end
