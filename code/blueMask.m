function [BW,maskedRGBImage] = blueMask(RGB)
%blueMask  Threshold RGB image using auto-generated code from colorThresholder app.
%  [BW,MASKEDRGBIMAGE] = blueMask(RGB) thresholds image RGB using
%  auto-generated code from the colorThresholder App. The colorspace and
%  minimum/maximum values for each channel of the colorspace were set in the
%  App and result in a binary mask BW and a composite image maskedRGBImage,
%  which shows the original RGB image values under the mask BW.

% Auto-generated by colorThresholder app on 09-Jun-2017
%------------------------------------------------------


% Convert RGB image to chosen color space
I = rgb2hsv(RGB);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.532;
channel1Max = 0.669;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.286;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

% Morphological transformations
% Erode to remove small parts
BW = imdilate(BW, strel('square',3));
BW = imerode(BW, strel('square',3));
% Remove small parts
BW = bwareaopen(BW, 100);
% Select largest object
labeled = bwlabel(BW, 4);
stats = regionprops(labeled);
% Get the largets blob
% (In case of more people, we have to sort instead of max)
[~, maxid] = max([stats.Area]);
BW = labeled == maxid;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
