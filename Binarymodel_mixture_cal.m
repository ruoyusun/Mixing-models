%Monte Carlo Simulation to calculate the mixed isotope signatures of two end-members.

% This matlab code performs the simulation of mixing results for 2 (or several) end members. 
% For each run, it simulates the fractions and isotope compositons of two end members, and mixed the two end members to get mixed values.

clear all

S={'d1','d2', 'f1','f2','d_mix'};

km1=1;

inputfile = fopen('Binarymodel_mixture_cal.xls','w'); %creat an excel file for output

formatSpec = '%s\t';

[nrows,ncols] = size(S);
for cols = 1:ncols
    fprintf(inputfile,formatSpec,S{:,cols});
end

newline='\r\n\r\n';
fprintf(inputfile,newline);



for i=1:10000  % pseudorandom number generation 
    
    d1 = 3.13 + randn*0.97 ; %isotope signature of end-member1 
    d2 = 0.13 +randn*0.10;   %isotope signature of end-member2 
    
    c1 = 18+randn*7;        %MMHg conc of surface ocean
    c2 = 38+randn*19;       %MMHg conc of intermediate ocean
    f1= c1/(c1+c2);         %fraction of surface ocean
    f2= 1-f1;               %fraction of intermediate ocean
   
    d_mix = f1 * d1 + (1 - f1) * d2; %isotope signature of mixed samples
 
    
    if f1>0 && f1<1
        
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
