function [features , tarjetos] =  dataProcess(name)

sick = load(name);
trgSick = sick.Trg;
featureSick = sick.FeatVectSel;


lenSick = size(trgSick,1);

s = 0;
ics = [];
preics = [];
posics = [];
targets = [];
targetsn = [];
index = [];

i = 1;
while (i<lenSick)
    x = trgSick(i);
    if (x == 1)
        s = s+1;
        preics = [preics i-300];
        ics = [ics i];
        while (x == 1)
            x = trgSick(i);
            if (x == 0)
                posics = [posics i];
            end
            i = i+1;
        end
    end
    i = i+1;
end


totalpre = [];
totalic = [];
totalpos = [];
for i=1:size(ics,2)
    j = 0;
    vect = [];
    pres = preics(i):ics(i)-1;
    icts = ics(i):posics(i)-1;
    posicts = posics:posics+250;
    totalpre = [totalpre; pres];
    totalic = [totalic icts];
    totalpos = [totalpos posicts];
end

seizures = [];
tarjetos = [];
for i=1:size(ics,2)
    inter = [];
    j = 0;
    pres = preics(i):ics(i)-1;
    icts = ics(i):posics(i)-1;
    posicts = posics(i):posics(i)+250;
    tamanho = size([pres icts posicts], 2);
    while j < tamanho
        interRand = randi(lenSick);
        if (any(totalic == interRand))
            continue;
        end
        if (any(totalpre == interRand))
            continue;
        end
        if (any(totalpos == interRand))
            continue;
        end
        inter = [inter interRand];
        j = j+1;
    end
    seizures = [seizures inter pres icts posicts];

    interTrg  = repmat([1;0;0;0], 1, size(inter,2));
    presTrg  = repmat([0;1;0;0], 1, size(pres,2));
    icsTrg   = repmat([0;0;1;0], 1, size(icts,2));
    possTrg  = repmat([0;0;0;1], 1, size(posicts,2));
    tarjetos = [tarjetos interTrg presTrg icsTrg possTrg];
end

features = [];
for i=1:size(seizures, 2)
    xx = seizures(1, i);
    features = [features; featureSick(xx, :)];
end

features = transpose(features);
%sizeF = size(features,2);
%[trainInd,valInd,testInd] = divideind(sizeF,1:(sizeF*0.8),(sizeF*0.8+1):(sizeF*0.90),(sizeF*0.9+1):sizeF);
end


