function GUItable(especDetect ,especPrever, sensiDetect, sensiPrever, especDetectD ,especPreverD, sensiDetectD, sensiPreverD, FileName)

info=[sensiDetect especDetect;sensiPrever especPrever;sensiDetectD especDetectD;sensiPreverD especPreverD];
f = figure;
title(FileName);
set(gca, 'XTick', []);
set(gca, 'YTick', []);

t = uitable(f,'ColumnWidth',{70 70});
t.ColumnName = {'Sensibility' , 'Specificity'};
t.RowName = {'Detect Point by Point' , 'Predict Point by Point' , 'Detect 5 in 10 Points' , 'Predict 5 in 10 Points'};
t.Position(3:4)=t.Extent(3:4);

set(t, 'Data', info);
end