
function [detected_chord, r, R]=chord_estimation(hpcp,chord,root, original_chord)

%detected chord: struct with fields: root, rootname, type,typename
% r: maximum correlation
% R: correlation matrix

showfig=0;
hpcpsize = length(hpcp);
Nchords = 7;

% Compute Correlations
mean_hpcp = mean(hpcp);
var_hpcp  = sqrt( sum( (hpcp-mean_hpcp).*(hpcp-mean_hpcp) ) );

for i=1:Nchords
    mean_profile(i) = mean(chord(i).profile);
    var_profile(i) = var(chord(i).profile);
end

for i=1:(hpcpsize)
    for j=1:Nchords
    vector = [chord(j).profile(hpcpsize-(i-1):hpcpsize) chord(j).profile(1:hpcpsize-i)];
    R(j,i+1) = sum( (hpcp-mean_hpcp) .* (vector-mean_profile(j)) ) / (var_hpcp*var_profile(j));         
    end
end


[fila index] = max(R');
[r type] = max(fila);
d_root = index(type);

if(d_root == 13) 
    d_root = 1;
end

rootname = root(d_root).name;
typename = chord(type).name;

X = fprintf('Original chord: %s %s ||  ', original_chord.rootname, original_chord.typename);
X = fprintf('Detected chord: %s %s\n', rootname, typename);

detected_chord.root = d_root;
detected_chord.type = type;
detected_chord.rootname = rootname;
detected_chord.typename = typename;

%% PLOTS

if showfig
    aux=(1:12);
    f = figure;
    subplot(421)
    plot(hpcp)
    title('HPCP value');    
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#';});
    grid;
    subplot(422);
    plot(R(1,:));
    xlabel('key note');
    title('Corr coeff Maj7');
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#'});
    grid;
    
    subplot(423);
    plot(R(2,:));
    xlabel('key note');
        ylabel('corrcoef');

    title('Corr coeff Min7');
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#'});
    grid;
    
    subplot(424);
    plot(R(3,:));
    xlabel('key note');
    title('Correlation with 7');
        ylabel('corrcoef');

    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#';});
    grid;
    
    subplot(425);
    plot(R(4,:));
    xlabel('key note');
        ylabel('corrcoef');

    title('Correlation with min7(b5)');
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#';});
    grid;    
    subplot(426);
    plot(R(5,:));
    xlabel('key note');
        ylabel('corrcoef');

    title('Correlation with aug7');
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#';});
    grid;    
    subplot(427);
    plot(R(6,:));
    xlabel('key note');
        ylabel('corrcoef');

    title('Correlation with 7(b9)');
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#';});
    grid;    
    subplot(428);
    plot(R(7,:));
    xlabel('key note');
    ylabel('corrcoef');
    grid;
    title('Correlation with min(maj7)');
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#';});
   
end
end

