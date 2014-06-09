% reads a csv file, calculates the temporal mean for each 12 bin and plots
% the hpcp chromagram and each bin's mean

function [ chroma_mean ] = hpcpread(csv, o_chord)
%input: csv and original chord
%output: chroma mean: vector HPCP 12 bin mean
nbins = 12;
showfig = 0;

[a,b] = size(csv);


%% HPCP from 120 to 12 bins ponderation
for k = 1:a
    j = 1;
    for i=2:10:b

        if  (i == 2)
            HPCP12(k,j) = (csv(k,2) + 0.4*csv(k,3) + 0.3*csv(k,4) + 0.2*csv(k,5) + 0.1*csv(k,6) ...
            + 0.4*csv(k,121) + 0.3*csv(k,120) + 0.2*csv(k,119) + 0.1*csv(k,118))/3;
        else
            HPCP12(k,j) = (0.1*csv(k,i-4) + 0.2*csv(k,i-3) + 0.3*csv(k,i-2) + 0.4*csv(k,i-1) + csv(k,i) ...
            + 0.1*csv(k,i+4) + 0.2*csv(k,i+3) + 0.3*csv(k,i+2) + 0.4*csv(k,i+1))/3;    
        end
    j = j+1;
    end
    
HPCP12(:,13) = 0;

end

for i = 1:nbins
    chroma_mean(i) = mean(HPCP12(:,i)); %Mean chroma for each bin
end

aux_csv = csv(:,2:121);

%Plots

if showfig

subplot 211
tx = 1:13;
ty = 1:a;
surf (tx,ty,HPCP12);
xlabel('bin');
str = sprintf('HPCP 12 bins for %s %s',chord.rootname, chord.typename);
title(str);
ylabel('window');
view(90,-90);

subplot 212
plot(chroma_mean,'-o'),
str = sprintf('Chroma mean for %s %s',chord.rootname, chord.typename);
title(str);

aux=(1:nbins);
xlabel('notes');
ylabel('HPCP mean value');
set(gca,'xtick',aux); set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#'});
grid on
end
    
end