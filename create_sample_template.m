% Chord training: compute of new chord profiles based on mean detected
% chord HPCP


function [ sample_template , n_sample_template,chord ] = create_sample_template( detected_chord, hpcp, chord, original_chord )

%Input: detected_chord struct, hpcp of all chords, chord struct, %original_chord
%Output: 
%sample_template: new vector trained profiles
%n_sample_template: normalized sample template values
%chord: struct with new fields altprof, n_altprof

i1 = 1;
i2 = 1;
i3 = 1;
i4 = 1;
i5 = 1;
i6 = 1;
i7 = 1;
j = 1;
sample_template = [];
hpcp_sample1 = zeros(1,12);
hpcp_sample2 = zeros(1,12);
hpcp_sample3 = zeros(1,12);
hpcp_sample4 = zeros(1,12);
hpcp_sample5 = zeros(1,12);
hpcp_sample6 = zeros(1,12);
hpcp_sample7 = zeros(1,12);


for i= 1:length(detected_chord)
    
    if ((detected_chord(i).root == original_chord(i).root ) && (detected_chord(i).type == original_chord(i).type))
        hpcp_template(i,:) = circshift(hpcp(i,:), [0 (13-(detected_chord(i).root))]);
   
    switch(detected_chord(i).type)
         case 1, 
            hpcp_sample1(i1,:) = hpcp_template(i,:);
            i1= i1+1;
         case 2, 
            hpcp_sample2(i2,:) = hpcp_template(i,:);
            i2=i2+1;
         case 3, 
            hpcp_sample3(i3,:) = hpcp_template(i,:);
            i3=i3+1;
         case 4, 
            hpcp_sample4(i4,:) = hpcp_template(i,:);
            i4=i4+1;
         case 5, 
            hpcp_sample5(i5,:) = hpcp_template(i,:);
            i5=i5+1;
         case 6, 
            hpcp_sample6(i6,:) = hpcp_template(i,:);
            i6=i6+1;
         case 7, 
            hpcp_sample7(i7,:) = hpcp_template(i,:);
            i7=i7+1;
 
    end
    j = j+1;
    end
end

    sample_template(1,:) = mean(hpcp_sample1(:,:));
    sample_template(2,:) = mean(hpcp_sample2(:,:));
    sample_template(3,:) = mean(hpcp_sample3(:,:));
    sample_template(4,:) = mean(hpcp_sample4(:,:));
    sample_template(5,:) = mean(hpcp_sample5(:,:));
    sample_template(6,:) = mean(hpcp_sample6(:,:));
    sample_template(7,:) = mean(hpcp_sample7(:,:));
    
    n_sample_template(1,:) = sample_template(1,:) ./ max(sample_template(1,:));
    n_sample_template(2,:) = sample_template(2,:) ./ max(sample_template(2,:));
    n_sample_template(3,:) = sample_template(3,:) ./ max(sample_template(3,:));
    n_sample_template(4,:) = sample_template(4,:) ./ max(sample_template(4,:));
    n_sample_template(5,:) = sample_template(5,:) ./ max(sample_template(5,:));
    n_sample_template(6,:) = sample_template(6,:) ./ max(sample_template(6,:));
    n_sample_template(7,:) = sample_template(7,:) ./ max(sample_template(7,:));

for i = 1:7
     chord(i).altprof = sample_template(i,:);
     chord(i).n_altprof = n_sample_template(i,:); 
end

end

