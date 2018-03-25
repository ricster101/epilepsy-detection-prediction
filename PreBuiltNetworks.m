function PreBuiltNetworks(FileName,PathName,patient)
global  TheTarget TheVector 
c=strcmp(patient,'Patient 2');
c1=strcmp(patient,'Patient 1');
if c1==1
    pat=load('patient1posProcess.mat');
    TheTarget=pat.tarjetos1;
    TheVector=pat.features1;
elseif c==1
    pat=load('patient2posProcess.mat');
    TheTarget=pat.tarjetos2;
    TheVector=pat.features2;
else
    [FileName1,PathName2] = uigetfile('*.mat','Select the MATLAB data file');
    File1= fullfile(PathName2, FileName1);
     sprintf('The new data is being processed. This may take a while.')
    [features , tarjetos]=dataProcess(File1);
    TheTarget=tarjetos;
    TheVector=features;
end

File = fullfile(PathName, FileName);
net1=load(File);
net=net1.net;
[especDetect especPrever sensiDetect sensiPrever especDetectD especPreverD sensiDetectD sensiPreverD]  = testarRede(net, TheVector,TheTarget);  
GUItable(especDetect ,especPrever, sensiDetect, sensiPrever, especDetectD ,especPreverD, sensiDetectD, sensiPreverD, FileName)


end