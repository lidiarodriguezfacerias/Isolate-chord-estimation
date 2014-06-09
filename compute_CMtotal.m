% COMPUTE CONFUSION MATRIX

function [CM_total ] = compute_CMtotal (detected_chord, original_chord)
A=[1 2 3 4 5 6 7 8 9 10 11 12];
B=[1 2 3 4 5 6 7 8 9];
n=1;
for i=1:length(A)
    for j=1:length(B)
            classes(n,:)=([A(i),B(j)]');
            n=n+1;
    end
end

class = zeros(1,(length(A)*length(B)));
for i=1:(length(A)*length(B))
a1 = classes(i,1);
a2 = classes(i,2)-1;
b1 = num2str(a1);
b2 = num2str(a2);
c1 = strcat(b1,'.', b2);
class(i) = str2num(c1);
end


det_chord = zeros(1,length(detected_chord));
for i=1: length(detected_chord)
a1 = detected_chord(i).root;
a2 = detected_chord(i).type-1;
b1 = num2str(a1);
b2 = num2str(a2);
c1 = strcat(b1, '.', b2);
det_chord(i) = str2num(c1);
end

ori_chord = zeros(1,length(detected_chord));
for i=1: length(detected_chord)
a1 = original_chord(i).root;
a2 = original_chord(i).type-1;
b1 = num2str(a1);
b2 = num2str(a2);
c1 = strcat(b1,'.', b2);
ori_chord(i) = str2num(c1);
end

det_chord = det_chord';
ori_chord = ori_chord';

[CM_total,order] = confusionmat(ori_chord, det_chord);

end