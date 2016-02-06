function blockFea = calSpatialHistogram(Map, BinSeq, BlockRowNum, BlockColNum)
%%  DESCRIPTION:
%       Calculate spatial histogram for encoded maps.
%
%   INPUT:
%       Map:             encoded maps by DCP;
%       BinSeq:          the bin sequence for histogram statistics;
%       BlockRowNum:     number of blocks in the vertical direction;
%       BlockColNum:     number of blocks in the horizontal direction;
%
%   OUTPUT:
%       blockFea:        a vector or matrix containing features of the blocks.
%
%   AUTHOR:
%       Changxing Ding @ University of Technology Sydney
%
%   VERSION:
%       0.1 - 21/02/2013 First implementation
%       Matlab 2012a


%% Check Input Parameters
if nargin < 2
    error('Not enough input parameters');
end

if nargin == 3
    BlockColNum = BlockRowNum;
end


%% Divid the Code Map
RegionRowNum = round(BlockRowNum);
RegionColNum = round(BlockColNum);

% calculate the dimension of the blocks
mapHeight = size(Map, 1);
mapWidth = size(Map, 2);

regionHeightUnit =  floor(mapHeight/RegionRowNum);  % the height for each region
regionWidthUnit = floor(mapWidth/RegionColNum);     % the width for each region

startHeight = floor((mapHeight - regionHeightUnit*RegionRowNum)/2) + 1;
startWidth = floor((mapWidth - regionWidthUnit*RegionColNum)/2) + 1;


%% Extract the normalized LBP histogram vector for each region
histoDim = length(BinSeq);
regionFeaMat = zeros(RegionRowNum, RegionColNum, histoDim);  % preallocate the feature vector

for i = 1:RegionRowNum
    for j = 1:RegionColNum
        % Get the coordinates for each block first
        regionCoordinates(1) = startHeight + (i-1)*regionHeightUnit;
        regionCoordinates(2) = regionCoordinates(1) + regionHeightUnit - 1;
        regionCoordinates(3) = startWidth + (j-1)*regionWidthUnit;
        regionCoordinates(4) = regionCoordinates(3) + regionWidthUnit - 1;
        
        if i == 1,               regionCoordinates(1) = 1;          end;
        if i == RegionRowNum,    regionCoordinates(2) = mapHeight;  end;
        if j == 1,               regionCoordinates(3) = 1;          end;
        if j == RegionColNum,    regionCoordinates(4) = mapWidth;   end;

        % calcuate the histogram for each sub-block
        regionMap = Map(regionCoordinates(1):regionCoordinates(2), regionCoordinates(3):regionCoordinates(4));
        regionMap = hist(regionMap(:), BinSeq);
        regionFeaMat(i,j,:) = regionMap/sum(regionMap);                
   end
end


%% Concatenate the Regional Histograms
blockFea = zeros(size(regionFeaMat, 1)*size(regionFeaMat, 2)*size(regionFeaMat, 3), 1);
startIndex = 1;
endIndex = histoDim;
for i = 1:RegionRowNum
    for j = 1:RegionColNum
        blockFea(startIndex: endIndex) = regionFeaMat(i,j,:);
        startIndex = endIndex + 1;
        endIndex = endIndex + histoDim;
    end
end

