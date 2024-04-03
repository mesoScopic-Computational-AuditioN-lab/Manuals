clear
clc

hemisphere = 'RH';

dirpois = '/mnt/hdd2/associative_learning/CBA/Glasser/high density CBA sphere resampled BrainVoyager HCP atlas/';

dirdata = ['/mnt/hdd2/associative_learning/CBA/segmentations/', hemisphere, '/'];

poi = xff([dirpois,'HCP-Glasser2016_resampled_', hemisphere, '_parcels_HIGHRES.poi']);

ssm = xff([dirdata,'GroupAlignedAveragedFoldedCortex_', hemisphere, '_N-11_HIRES_SPH_ALIGNED_TO_HCP-Glasser2016_INV.ssm']);

poi2 = poi.CopyObject;

for i=1:poi.NrOfPOIs
    data = zeros(poi.NrOfMeshVertices,1);
    data(poi.POI(i).Vertices)  = 1;
    newdata = data(ssm.SourceOfTarget);
    indexPOI = find(newdata);
    
    poi2.POI(i).NrOfVertices = length(indexPOI);
    poi2.POI(i).Vertices = indexPOI;

end

if (exist([dirdata, '/pois/'], 'dir') == 0); mkdir([dirdata, '/pois/']); end
poi2.SaveAs([dirdata, '/pois/', 'Average_GlasserPOIs_', hemisphere, '_IndexCorrected.poi']);