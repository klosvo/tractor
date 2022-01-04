function T = separatefarms(farmnum,Inputfile)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    for i =1:lastrow
        for Inputfile.farmNum(i) = farmnum
            T.Sensor(i) = Inputfile.Sensor(i);
            T.NDVI(i) = Inputfile.NDVI(i);
            T.NDRE(i) = Inputfile.NDRE(i);
            T.NIR(i) = Inputfile.NIR(i);
            T.R(i) = Inputfile.R(i);
            T.Course(i) = Inputfile.COURSE(i);
        end
    end

end

