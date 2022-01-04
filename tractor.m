%initialize variables and project files
projectdir = '/Users/kama/Desktop/INTERNSHIP/Tractor/';
outputfile=fullfile(projectdir,'CropCircleSDI3av.xls');
outputfile2=fullfile(projectdir,'CropCircleSDI3avbyFarm.xls');
Farm = {'Farm12A(117)','Farm11A(118)','Farm3A(119)','Farm5A(120)','Farm6A(121)','Farm7A(122)','Farm14A(123)','Farm16A(124)','Farm10A(125)','Farm15A(126)','Farm13A(127)','Farm9A(128)','Farm1A(141)','Farm4A(142)','Farm8A(143)','Farm2A(144)','Farm11B(145)','Farm10B(146)','Farm5B(146)','Farm12B(148)','Farm3B(149)','Farm8B(150)','Farm7B(151)','Farm2B(152)','Farm14B(165)','Farm6B(166)','Farm16B(167)','Farm15B(168)','Farm4B(169)','Farm1B(170)','Farm13B(171)','Farm9B(172)','Farm16C(173)','Farm12C(174)','Farm14C(175)','Farm11C(176)','Farm13C(189)','Farm10C(190)','Farm9C(191)','Farm7C(192)','Farm3C(193)','Farm15C(194)','Farm2C(195)','Farm8C(196)','Farm6C(197)','Farm5C(198)','Farm1C(199)','Farm4C(200)'};
    
NDREmedian = [];
NDVImedian = [];
SensorNum = [];
B = 0;
U = 0;
T1NDVI = [];
T2NDVI = [];
T3NDVI = [];
T4NDVI = [];
T1NDRE = [];
T2NDRE = [];
T3NDRE = [];
T4NDRE = [];
CCNDRE1 = [];
CCNDRE2 = [];
CCNDRE3 = [];
CCNDRE4 = [];
CCNDVI1 = [];
CCNDVI2 = [];
CCNDVI3 = [];
CCNDVI4 = [];
n_sensor1 =0;
n_sensor2 =0;
n_sensor3 =0;
n_sensor4 =0;
ST = table('Size', [1 3], 'VariableTypes', {'uint8','double','double'},'VariableNames',{'SensorNum','NDREmedian','NDVImedian'});
T = table('Size', [1 11], 'VariableTypes', {'string','double','double','double','double','double','double','double','double','double','double'},'VariableNames',{'Farm','NDREmedian1','NDVImedian1','NDREmedian2','NDVImedian2','NDREmedian3','NDVImedian3','NDREmedian4','NDVImedian4','NDREavg','NDVIavg'});
%opens the excel sheet for the farm number i
CC = open_tractor_sheet();
l_CC = height(CC);
% go through document

for r=1:l_CC % go through each of the 24 farms starting with the first
     for fn = 1:24
         for CC.farmNum(r) = fn
         for
    l=height(CC); % calculates number of rows
    for j=1:l
        sensor = CC.SENSOR_ADDR(j);     % gets the sensor address
        switch sensor   % is the sensor address 1, 2, 3, or 4?
            case 1
                CCNDRE1 = CC.NDRE(j);           % adds NDRE value to 
                T1NDRE = [T1NDRE; CCNDRE1];     % a table
                CCNDVI1 = CC.NDVI(j);           % adds NDVI value to   
                T1NDVI = [T1NDVI; CCNDVI1];     % a table
                n_sensor1 = n_sensor1+1;
            case 2
                CCNDRE2 = CC.NDRE(j);
                T2NDRE = [T2NDRE; CCNDRE2];
                CCNDVI2 = CC.NDVI(j);
                T2NDVI = [T2NDVI; CCNDVI2];
                n_sensor2 = n_sensor2+1;
            case 3
                CCNDRE3 = CC.NDRE(j);
                T3NDRE = [T3NDRE; CCNDRE3];
                CCNDVI3 = CC.NDVI(j);
                T3NDVI = [T3NDVI; CCNDVI3];
                n_sensor3 = n_sensor3+1;
            case 4
                CCNDRE4 = CC.NDRE(j);
                T4NDRE = [T4NDRE; CCNDRE4];
                CCNDVI4 = CC.NDVI(j);
                T4NDVI = [T4NDVI; CCNDVI4];
                n_sensor4 = n_sensor4+1;
            otherwise
                B = B+1; % calculates number of errors due to the sensor address value not bein a 1-4
        end
    end
        
    v = [n_sensor1,n_sensor2,n_sensor3,n_sensor4];
    d = max(v);
    diff1 = d-v(1);
    diff2 = d-v(2);
    diff3 = d-v(3);
    diff4 = d-v(4);
    T1NDRE = padarray(T1NDRE,diff1,NaN,'post');
    T2NDRE = padarray(T2NDRE,diff2,NaN,'post');
    T3NDRE = padarray(T3NDRE,diff3,NaN,'post');
    T4NDRE = padarray(T4NDRE,diff4,NaN,'post');
    T1NDVI = padarray(T1NDVI,diff1,NaN,'post');
    T2NDVI = padarray(T2NDVI,diff2,NaN,'post');
    T3NDVI = padarray(T3NDVI,diff3,NaN,'post');
    T4NDVI = padarray(T4NDVI,diff4,NaN,'post');

    NDREtable = [T1NDRE,T2NDRE,T3NDRE,T4NDRE];
    NDVItable = [T1NDVI,T2NDVI,T3NDVI,T4NDVI];
    n_sensor1 = 0;
    n_sensor2 = 0;
    n_sensor3 = 0;
    n_sensor4 = 0;
    for m = 1:4
        ST.SensorNum(m) = m;
        % take median ignoring NaN values
        ST.NDREmedian(m) = nanmedian(NDREtable(:,m));
        ST.NDVImedian(m) = nanmedian(NDVItable(:,m));
    end
    writetable(ST,outputfile2,'Sheet',i,'UseExcel',true);
    T.Farm(i) = Farm(i);
    % creates table column for sensor row
    T.NDREmedian1(i) = ST.NDREmedian(1); % creates table column for NDRE median
    T.NDVImedian1(i) = ST.NDVImedian(1);  % creates table column for NDVI median
  
    T.NDREmedian2(i) = ST.NDREmedian(2);
    T.NDVImedian2(i) = ST.NDVImedian(2);
  
    T.NDREmedian3(i) = ST.NDREmedian(3);
    T.NDVImedian3(i) = ST.NDVImedian(3);

    T.NDREmedian4(i) = ST.NDREmedian(4);
    T.NDVImedian4(i) = ST.NDVImedian(4);

    T.NDREavg(i) = (T.NDREmedian1(i)+ T.NDREmedian2(i)+ T.NDREmedian3(i)+ T.NDREmedian4(i))/4; %computes average
    T.NDVIavg(i) = (T.NDVImedian1(i)+ T.NDVImedian2(i)+ T.NDVImedian3(i)+ T.NDVImedian4(i))/4; %computes average      

    clear ST.SensorNum(:) ST.NDREmedian(:) ST.NDVImedian(:);
    T1NDVI = [];
    T2NDVI = [];
    T3NDVI = [];
    T4NDVI = [];
    T1NDRE = [];
    T2NDRE = [];
    T3NDRE = [];
    T4NDRE = [];
end
writetable(T,outputfile,'UseExcel',true);