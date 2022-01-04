function T_med_avg = fwbw(T)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
  maxrow = height(T);
    for j = 1:maxrow 
        if T.Course(j)<=100
            T.NDRE_Forward_pass(j) = T.NDRE(j);
            T.NDRE_Backward_pass(j) = NaN;
        else
            T.NDRE_Backward_pass(j) = T.NDRE(j);
            T.NDRE_Forward_pass(j) = NaN;
        end
    end
    
    
    for k = 1:maxrow 
        sensor = T.Sensor(k);
        switch sensor
            case 1
                T_med_avg.Median(sensor) = nanmedian(NDRE_Backward_pass(:));
    
end

