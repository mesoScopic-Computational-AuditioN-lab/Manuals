clear
clc

hemisphere = 'RH';

subjects = {'S04', 'S05', 'S06', 'S07', 'S08', 'S09', 'S10', 'S11', 'S12', 'S15', 'S17'};

dirpois = ['/mnt/hdd2/associative_learning/CBA/segmentations/', hemisphere, '/pois/'];

for subnum = 1:length(subjects) 
    subject_id = subjects{subnum};
%     fprintf('processing subject %s.\n', subject_id)
    
    dirdata = ['/mnt/hdd2/associative_learning/CBA/segmentations/', hemisphere, '/subjects/'];

    poi = xff([dirpois,'Average_GlasserPOIs_', hemisphere, '_IndexCorrected.poi']);

    fprintf('%s\n', [dirdata, subject_id, '_UNI_reframed_WM-GM_*', hemisphere, '_Mid-GM_*_HIRES_SPH_GROUPALIGNED_INV.ssm'])
    filename = dir([dirdata, subject_id, '_UNI_reframed_WM-GM_*', hemisphere, '_Mid-GM_*_HIRES_SPH_GROUPALIGNED_INV.ssm']);
    fprintf('%s\n', [filename.folder, '/', filename.name])
    ssm = xff([filename.folder, '/', filename.name]);
        
    poi2 = poi.CopyObject;
    
    for i=1:poi.NrOfPOIs
        data = zeros(poi.NrOfMeshVertices,1);
        data(poi.POI(i).Vertices)  = 1;
        newdata = data(ssm.SourceOfTarget);
        indexPOI = find(newdata);
        
        poi2.POI(i).NrOfVertices = length(indexPOI);
        poi2.POI(i).Vertices = indexPOI;
    
    end
    
    fprintf('saving at %s.\n', [dirpois, subject_id, '_GlasserPOIs_', hemisphere, '.poi'])
    poi2.SaveAs([dirpois, subject_id, '_GlasserPOIs_', hemisphere, '.poi']);

end 
