function [especDetect especPrever sensiDetect sensiPrever especDetectD especPreverD sensiDetectD sensiPreverD] = testarRede(net, features, tarjetos)
Y = net(features,'useGPU','yes');

results = [];

for i=1:size(features,2)
   anal = Y(:,i);
   maxY= max(anal);
   findster = find(anal==maxY);
   results=[results findster]; 
end

results2=[];
for i=1:size(features,2)
   anal = tarjetos(:,i);
   maxY= max(anal);
   findster = find(anal==maxY);
   results2=[results2 findster]; 
    
end

resultsDif = [];
for i=1:size(features,2)
    if (i>10)
        a = 0;
        b = 0;
        c = 0;
        d = 0;
        for j=i-9:i
            w = results(j);
            if w==0
                a = a + 1;
            elseif w==1
                b = b + 1;
            elseif w==2
                c = c + 1;
            else
                d = d + 1;
            end
        end
        ww = [a b c d];
        ww = max(ww);
        if ww==a
            resultsDif = [resultsDif 0];
        elseif ww==b
            resultsDif = [resultsDif 1];
        elseif ww==c
            resultsDif = [resultsDif 2];
        elseif ww==d
            resultsDif = [resultsDif 3];
        end
        
    else
        resultsDif =[resultsDif results(i)];
        
    end
    
end
    

TPprev = 0;
TNprev = 0;
FPprev = 0;
FNprev = 0;

for i=1:size(features,2)
    a = results(i);
    b = results2(i);
    if (b==2)
        if (a==2)
            TPprev = TPprev + 1;
        else
            FNprev = FNprev + 1;
        end
    else
        if (a==2)
            FPprev = FPprev + 1;
        else
            TNprev = TNprev + 1;
        end
    end
end

TPdet = 0;
TNdet = 0;
FPdet = 0;
FNdet = 0;

for i=1:size(features,2)
    a = results(i);
    b = results2(i);
    if (b==3)
        if (a==3)
            TPdet = TPdet + 1;
        else
            FNdet = FNdet + 1;
        end
    else
        if (a==3)
            FPdet = FPdet + 1;
        else
            TNdet = TNdet + 1;
        end
    end
end

TPprevD = 0;
TNprevD = 0;
FPprevD = 0;
FNprevD = 0;

for i=1:size(features,2)
    a = results(i);
    b = resultsDif(i);
    if (b==2)
        if (a==2)
            TPprevD = TPprevD + 1;
        else
            FNprevD = FNprevD + 1;
        end
    else
        if (a==2)
            FPprevD = FPprevD + 1;
        else
            TNprevD = TNprevD + 1;
        end
    end
end

TPdetD = 0;
TNdetD = 0;
FPdetD = 0;
FNdetD = 0;

for i=1:size(features,2)
    a = results(i);
    b = resultsDif(i);
    if (b==3)
        if (a==3)
            TPdetD = TPdetD + 1;
        else
            FNdetD = FNdetD + 1;
        end
    else
        if (a==3)
            FPdetD = FPdetD + 1;
        else
            TNdetD = TNdetD + 1;
        end
    end
end


especDetect = TNdet*1.0/(TNdet + FPdet)*1.0;
especDetect = especDetect*100;
sensiDetect = TPdet*1.0/(TPdet + FNdet)*1.0;
sensiDetect = sensiDetect * 100;
especPrever = TNprev*1.0/(TNprev + FPprev)*1.0;
especPrever = especPrever * 100;
sensiPrever = TPprev*1.0/(TPprev + FNprev)*1.0;
sensiPrever = sensiPrever * 100;
especDetectD = TNdetD*1.0/(TNdetD + FPdetD)*1.0;
especDetectD = especDetectD*100;
sensiDetectD = TPdetD*1.0/(TPdetD + FNdetD)*1.0;
sensiDetectD = sensiDetectD * 100;
especPreverD = TNprevD*1.0/(TNprevD + FPprevD)*1.0;
especPreverD = especPreverD * 100;
sensiPreverD = TPprevD*1.0/(TPprevD + FNprevD)*1.0;
sensiPreverD = sensiPreverD * 100;
end