clc;
clear all;
close all;




FID1=fopen('list of wav file name');
    
i=1;
while ~feof(FID1)
    
    
   line1=fgetl(FID1);
%%%%%%%%%%%%%%%%%  pitch modification %%%%%%%%%%%%%%%%%%%%%%
pitch_modification(line1, -2);

%%%%%%%%%%%%%%%%%  speaking-rate modification  %%%%%%%%%%%%%%%%%%%%%%
speaking-rate_using_stftm(line1, 0.8);

i=i+1
end



