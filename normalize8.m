function Output_Im = normalize8(Input_Im)
%%  DESCRIPTION:
%       The function adjusts the dynamic range of the grey scale image to 
%       the interval [0,255].
%
%   INPUT:
%       Input_Im:        a grey-scale face image;
%
%   AUTHOR:
%       Changxing Ding @ University of Technology Sydney
%
%   VERSION:
%       0.1 - 02/04/2013 First implementation
%       Matlab 2012a



Input_Im = double(Input_Im);
[a,b] = size(Input_Im);


%% Adjust the dynamic range to the 8-bit interval
max_val = max(Input_Im(:));
min_val = min(Input_Im(:));

if max_val == min_val
    Output_Im = zeros(a, b);
else
    Output_Im = (Input_Im - min_val)./(max_val - min_val)*255;
end

Output_Im = uint8(Output_Im);


