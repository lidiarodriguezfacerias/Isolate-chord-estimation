
% General script. Chooses the HPCP folder and run de isolate chord detection
% for this folder

compute1 = 1; % First method (Original profiles)

if compute1
clear all;
clc;
close all;

% Change for dictionary and HPCP .csv files path
run('/Users/apple/Isolate-chord-estimation/diccionari.m')
addpath('/Users/apple/Isolate-chord-estimation/csv') %Assign HPCP folder
list = dir('csv/*.csv');

compute2 = 1; % 2nd method (Trained profiles)
compute3 = 1; % 3rd method (Trained and normalized profiles)

original_chord=struct;
hpcp = zeros(length(list), 12);

%% 1st estimator
display (' -----------ROUND 1-------------- ');

for i=1:length(list)
    
    filename = list(i).name;
    fprintf('%d: ', i);
    [o_chord] = set_original_features(i,filename); % Read original features

    csv = csvread(filename); 
    hpcp(i,:) = hpcpread(csv,o_chord); % Returns HPCP 12 mean vector [1x12]

    % Compute chord detection for file i
    [detected_chord_aux, r, R]=chord_estimation(hpcp(i,:),chord,root,o_chord);

    % Store information
    detected_chord(i).root = detected_chord_aux.root;
    detected_chord(i).rootname = detected_chord_aux.rootname;
    detected_chord(i).type = detected_chord_aux.type;
    detected_chord(i).typename = detected_chord_aux.typename;
    original_chord(i).root = o_chord.root;
    original_chord(i).rootname = o_chord.rootname;
    original_chord(i).type = o_chord.type;
    original_chord(i).typename = o_chord.typename;

end

end

% Evaluate accuracy and compute confusion matrix
[CM_roots, CM_types, CM_total] = evaluation(original_chord, detected_chord);

% Compute profile training
[sample_template, n_sample_template, chord] = create_sample_template(detected_chord,hpcp,chord, original_chord);


%% 2nd estimator
if compute2

display (' -----------ROUND 2-------------- ');

for i=1:length(list)

    filename = list(i).name;
    fprintf('%d: ', i);

    o_chord = original_chord(i);

    csv = csvread(filename);
    hpcp2(i,:) = hpcpread(csv,o_chord);

    [detected_chord(i).altroot, detected_chord(i).alttype, detected_chord(i).altrootname, detected_chord(i).alttypename, r, R]=chord_estimation_alt(hpcp2(i,:),chord,root,o_chord);

    original_chord(i).root = o_chord.root;
    original_chord(i).rootname = o_chord.rootname;
    original_chord(i).type = o_chord.type;
    original_chord(i).typename = o_chord.typename;

end
end

[CM_altroot, CM_alttype] = altevaluation(original_chord, detected_chord);


if compute3

display ('-----------ROUND 3--------------');
    
for i=1:length(list)
    
    filename = list(i).name;
    fprintf('%d: ', i);

    o_chord = original_chord(i);

    csv = csvread(filename);
    hpcp3(i,:) = hpcpread(csv, o_chord);

    [detected_chord(i).n_altroot, detected_chord(i).n_alttype, detected_chord(i).n_altrootname, detected_chord(i).n_alttypename, r, R]=chord_n_estimation_alt(hpcp3(i,:),chord,root,o_chord);

    original_chord(i).root = o_chord.root;
    original_chord(i).rootname = o_chord.rootname;
    original_chord(i).type = o_chord.type;
    original_chord(i).typename = o_chord.typename;

end

[CM_n_altroot, CM_n_alttype] = n_altevaluation(original_chord, detected_chord);
end

