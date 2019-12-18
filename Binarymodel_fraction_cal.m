%Monte Carlo Simulation to calculate the fraction of two end-members


% This matlab code performs the simulation of mixing results between 2  end members
% For each run it simulates the isotopic composition of two end members and mixes them together by a random fraction
% then it compares the isotopic composition of the modeled mixed sample with the isotopic composition of a measured sample
clear all

S={'d1','d2', 'f1','f2','d_mix'};

km1=1;

inputfile = fopen('Binarymodel_fraction_cal.xls','w');

formatSpec = '%s\t';

[nrows,ncols] = size(S);
for cols = 1:ncols
    fprintf(inputfile,formatSpec,S{:,cols});
end

newline='\r\n\r\n';
fprintf(inputfile,newline);

d_sample =1.7;           % isotope signature of sample
d_2SD = 0.10;            % analytical precision of isotope signature


for i=1:10000  % pseudorandom number generation 
    
    
   
    
    d1 = 3.84 + randn*1.15 ; %isotope signature of end-member 1 
    d2 = 0.16 +randn*0.09;   %isotope signature of  end-member 2
        
    f1= rand; % fraction of end-member 1, relative to sample
    f2= 1-f1; % fraction of end-member 2, relative to sample

    
    d_mix = f1 * d1 + (1 - f1) * d2; % isotope signature of mixed samples
 
    if all(abs(d_mix - d_sample)<= d_2SD)
        
        param={d1,d2,f1,f2,d_mix};
                
        formatSpec = '%f\t';
        
        [nrows,ncols] = size(param);
        for cols = 1:ncols
            fprintf(inputfile,formatSpec,param{:,cols});
        end
        
       newline='\r\n';
       fprintf(inputfile,newline);
                
        km1=km1+1;
    end
    
end

fclose(inputfile);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


