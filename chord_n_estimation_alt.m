
function [d_root, type, rootname, typename r, R]=chord_n_estimation_alt(hpcp,chord,root, original_chord)

% d_root: estimated root
% mode: estimated type
% rootname: name of estimated root
% typename: name of estimated type
% r: maximum correlation
% R: correlation matrix

showfig=0;
hpcpsize = length(hpcp);

% Compute Correlations
mean_hpcp = mean(hpcp);
var_hpcp  = sqrt( sum( (hpcp-mean_hpcp).*(hpcp-mean_hpcp) ) );

Nchords = 7;
for i=1:Nchords
    mean_profile(i) = mean(chord(i).n_altprof);
    var_profile(i) = var(chord(i).n_altprof);
end

R = zeros(13,hpcpsize);


for i=1:(hpcpsize)
    for j=1:Nchords
    vector = [chord(j).n_altprof(hpcpsize-(i-1):hpcpsize) chord(j).n_altprof(1:hpcpsize-i)];
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

detected_chord.altroot = d_root;
detected_chord.alttype = type;
detected_chord.altrootname = rootname;
detected_chord.alttypename = typename;

% PLOTS

if showfig
    aux=(1:12);
    f = figure;
    subplot(311)
    plot(hpcp)
    ylabel('HPCP value');    
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#';});
    grid;
    
    subplot(312);
    plot(R(1,:));
    xlabel('key note');
    ylabel('corr coeff Major');
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#'});
    grid;
    subplot(313);
    plot(R(2,:));
    xlabel('key note');
    ylabel('corr coeff  minor');
    set(gca,'xtick',aux);
    set(gca,'XTickLabel',{'A';'#';'B';'C';'#';'D';'#';'E';'F';'#';'G';'#';});
    grid;
    
end
end

