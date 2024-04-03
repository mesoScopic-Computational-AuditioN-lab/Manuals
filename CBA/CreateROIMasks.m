clear
clc

% to make this work remove the line
% vox = vox .* voxres(nvox, :) + voxoff(nvox, :);
% in the voi_CreateMSK.m file

hemisphere = 'LH';

suffix = '';

% subjects = {'S04', 'S05', 'S06', 'S07', 'S08', 'S09', 'S10', 'S11', 'S12', 'S15', 'S17'};
subjects = {'S05', 'S06', 'S07', 'S08', 'S09', 'S10', 'S11', 'S12', 'S15', 'S17'};
subjects = {'S06'};

dirvoi = ['/mnt/hdd2/associative_learning/zARCHIVE/CBA/segmentations/', hemisphere, '/voi/-6_6/'];

xff(0,'transiosize','vtc', 12e4) % enable transio for vtcs > 12e4
for subnum = 1:length(subjects) 
    subject_id = subjects{subnum};
    sprintf('create masks for subject %s', subject_id)
    
    dirvtc = ['/mnt/hdd2/associative_learning/functional/', subject_id, '/'];
    
    vtc = xff([dirvtc, subject_id, '_WhatOn_run1_M.vtc']);
    voi = xff([dirvoi, subject_id, '_ROIs_', hemisphere, '.voi']);

    for voinum = 1:length(voi.VOI)
        voiname = voi(voinum).Name;
        mask = voi.CreateMSK(vtc, voinum);
        if (exist([dirvoi, subject_id, '_masks_-6_6/'], 'dir') == 0)
            mkdir([dirvoi, subject_id, '_masks_-6_6/']);
        end
        mask.SaveAs(['/home/mahdi/hdd2/associative_learning/masks/depth_-6_to_6/S06/', subject_id, '_', voiname, suffix, '.msk']);
    end
end 
