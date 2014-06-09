% Confusion matrix computation for 1st detector

function [ CM_roots, CM_types, CM_total ] = evaluation(original_chord, detected_chord )

% Input: original_chord struct and detected_chord struct
% Output: Confusion matrix for Roots and Types, Confusion matrix total

total = length(original_chord);
correct_root = 0;
correct_type = 0;
incorrect_root = 0;
incorrect_type = 0;
correct_total = 0;
incorrect_total=0;

for i=1:total
    
    if (detected_chord(i).root==original_chord(i).root)
        correct_root=correct_root+1;
    else
        incorrect_root=incorrect_root+1;
    end
    
    if(detected_chord(i).type==original_chord(i).type)
        correct_type =correct_type+1;
    else
        incorrect_type=incorrect_type+1;
    end
    
    if ((detected_chord(i).type==original_chord(i).type) && (detected_chord(i).root==original_chord(i).root))
        correct_total =correct_total+1;
    end
    
    if ((detected_chord(i).type~=original_chord(i).type) && (detected_chord(i).root~=original_chord(i).root))
        incorrect_total =incorrect_total+1;
    end

end

    fprintf('\nTotal analyzed chords: %i\n\n',total);
    fprintf('Totally correct estimation: %i (per cent) \n',(correct_total));
    fprintf('Totally incorrect estimation: %i (per cent) \n\n',(incorrect_total));
    fprintf('Correct root estimation: %i (per cent) \n',(correct_root));
    fprintf('Correct type estimation: %i (per cent)\n\n',(correct_type));
    fprintf('Incorrect root estimation: %i (per cent)\n',(incorrect_root));
    fprintf('Incorrect type estimation: %i(per cent)\n',(incorrect_type));
    
CM_roots = confusionmat([original_chord.root], [detected_chord.root]); 
CM_types = confusionmat([original_chord.type], [detected_chord.type]);

[CM_total] = compute_CMtotal(detected_chord, original_chord);
   
end


