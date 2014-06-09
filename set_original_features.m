% Extraction of original features

function [ original_chord ] = set_original_features( file,filename )


%input: filename: root_type_version_vamp_vamp-hpcp-mtg_MTG-HPCP_HPCP.csv
%output: original chord: root, rootname, type, typename


divided_filename = regexp(filename, '[_.]', 'split');
or_rootname = divided_filename{1};
or_typename =divided_filename{2};

switch (or_rootname)
    case 'A', 
    or_root = 1;
    case 'Bb', 
    or_root = 2;
     case 'B', 
    or_root = 3;
     case 'C', 
    or_root = 4;
     case 'Db', 
    or_root = 5;
     case 'D', 
    or_root = 6;
     case 'Eb', 
    or_root = 7;
     case 'E', 
    or_root = 8;
     case 'F', 
    or_root = 9;
     case 'Gb', 
    or_root = 10;
     case 'G', 
    or_root = 11;
     case 'Ab', 
    or_root = 12;
end
switch(or_typename)

     case 'maj7', 
    or_type = 1;
     case 'm7', 
    or_type = 2;
     case 'min7',
    or_type = 2;    
     case '7', 
    or_type = 3;
     case 'sdis', 
    or_type = 4;
     case 'aug7', 
    or_type = 5;
     case '7b9', 
    or_type = 6;
     case 'minmaj7', 
    or_type = 7;

  

end

original_chord.root = or_root;
original_chord.typename = or_typename;

original_chord.type = or_type; 
original_chord.rootname = or_rootname;


end

