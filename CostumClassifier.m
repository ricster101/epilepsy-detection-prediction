function CostumClassifier(dataSet,trFcn,actvFcn,classifier,nrLayNeur)
global  TheTarget TheVector
c=strcmp(dataSet,'Patient 2');
c1=strcmp(dataSet,'Patient 1');

if c1==1
     pat=load('patient1posProcess.mat');
    TheTarget=pat.tarjetos1;
    TheVector=pat.features1;
elseif c==1
    pat=load('patient2posProcess.mat');
    TheTarget=pat.tarjetos2;
    TheVector=pat.features2;
else
   [FileName,PathName] = uigetfile('*.mat','Select the MATLAB data file');
   File1= fullfile(PathName, FileName);
   sprintf('The new data is being processed. This may take a while.')
   [features , tarjetos]=dataProcess(File1);
   TheTarget=tarjetos;
   TheVector=features;
   
end

if strcmp(classifier,'Layrecnet')
    
    net =layrecnet(1:2,nrLayNeur,trFcn);
    net=init(net);
    net.divideFcn = 'divideblock';
    for i=1:size(nrLayNeur,2)
        net.layers{i}.transferFcn=actvFcn;
    end
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
    net.trainParam.max_fail = 100;

    net.trainParam.epochs = 1000;
    
    net = train(net,TheVector,TheTarget,'useGPU','yes');
    [especDetect especPrever sensiDetect sensiPrever especDetectD especPreverD sensiDetectD sensiPreverD] = testarRede(net, TheVector,TheTarget);
    GUItable(especDetect ,especPrever, sensiDetect, sensiPrever, especDetectD ,especPreverD, sensiDetectD, sensiPreverD);
    sprintf('A costum network will be saved on the workspace. It will be named Costum.mat')
    save('Costum.mat','net');
elseif strcmp(classifier,'FeedForward')
       
    net=feedforwardnet(nrLayNeur,trFcn);
    net=init(net);
    net.divideFcn = 'divideblock';
    for i=1:size(nrLayNeur,2)
        net.layers{i}.transferFcn=actvFcn;
    end
    
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
    net.trainParam.max_fail = 100;

    net.trainParam.epochs = 1000;
    
    net = train(net,TheVector,TheTarget,'useGPU','yes');
    [especDetect especPrever sensiDetect sensiPrever especDetectD especPreverD sensiDetectD sensiPreverD] = testarRede(net, TheVector,TheTarget);
    GUItable(especDetect ,especPrever, sensiDetect, sensiPrever, especDetectD ,especPreverD, sensiDetectD, sensiPreverD);
    sprintf('A costum network will be saved on the workspace. It will be named Costum.mat')
    save Costum.mat net;
end

end

