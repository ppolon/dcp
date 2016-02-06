function feaVec = main(Input_Im, RegionRowNum, RegionColNum, Radius)
%% DESCRIPTION
%   	This function is to generate a holistic feature vector for the input 
%       face image by the DCP descriptor.
%
%   REFERENCE:
%       Changxing Ding, Jonghyun Choi, Dacheng Tao, and Larry S. Davis,
%       'Multi-Directional Multi-Level Dual-Cross Patterns for Robust Face 
%       Recognition', Vol.38, No.3, pp.518-531, TPAMI 2016.
% 
%   INPUT:
%       Input_Im:        the input image data;
%       RegionRowNum:    the number of rows of the divided regions;
%       RegionColNum:    the number of columns of the divided regions;
%       Radius:          the radius of the circle;
%
%   NOTE: 
%       Parameters for DCP and preprocessing in this code are optimal for FERET
%       database with image size 128*128 pixels. For the other databases, 
%       the optimal parameters may be slightly different.
%
%   OUTPUT:
%       feaVec:          the holistic DCP feature vector of the face.
%
%   AUTHOR:
%       Changxing Ding @ University of Technology Sydney
%
%   VERSION:
%       0.1 - 08/06/2013 first implementation
%       0.2 - 06/02/2016  second implementation
%       Matlab 2012a



%% Inspect the Input Parameters
if nargin < 4,     Radius = [4 6];         end;
if nargin < 3,     RegionColNum = 9;       end;
if nargin < 2,     RegionRowNum = 9;       end;

if size(Input_Im, 3) == 3
    Input_Im = rgb2gray(Input_Im);
end


%% Preproces the Input Image
% you may bypass the de-lighting step if the image is very noisy
Input_Im = TanTriggsImPreprocess(Input_Im, 0.2, 1.4, 2.0);


%% Encode the Image by DCP
feaVec = [];
OffSet = [0 pi/4];
for i = 1:length(OffSet)
    feaVec(:,i) = calDCPVec_sub(Input_Im, RegionRowNum, RegionColNum, 4, Radius, OffSet(i));
end


%% Rank the Feature Vectors Block by Block
blockNum = RegionRowNum*RegionColNum;
dimPerBlock = size(feaVec,1)/blockNum;
result = [];
for i = 1:size(feaVec, 2)
    temp = reshape(feaVec(:,i), dimPerBlock, blockNum);
    result = [result; temp];
end

feaVec = result(:);
end



