function Output_Im = TanTriggsImPreprocess(Input_Im, gamma, sigma0, sigma1)
%%  DESCRIPTION:
%       Preprocess the input image for robust face recognition under
%       difficult lighting conditions.
%
%   REFERENCE:
%       Xiaoyang Tan & Bill Triggs, 
%       'Enhanced Local Texture Feature Sets for Face Recognition under
%       Difficult Lighting Conditions', TIP 2009,
%
%   NOTE: 
%
%   INPUT:
%       Input_Im:        the input image data;
%       gamma:           exponent for the power law (parameter for Gamma Correction);
%       sigma0:          standard deviation for the inner (smaller) Gaussian of DoG;
%       sigma1:          standard deviation for the outer (larger) Gaussian of DoG;
%
%   OUTPUT:
%       Output_Im:       image data after preprocessing.
%
%   AUTHOR:
%       Changxing Ding @ University of Technology Sydney
%
%   VERSION:
%       0.1 - 17/12/2012 First implementation
%       Matlab 2012a


%% Checking for Input Arguments
if nargin < 4,    sigma1 = 2.0;    end;
if nargin < 3,    sigma0 = 1.4;    end;  
if nargin < 2,    gamma = 0.2;     end;


%% Gamma Correction
if gamma == 0
    Gamma_Im = double(Input_Im);  % means pass the gamma transformation step
else
    Gamma_Im = (double(Input_Im)).^gamma;
end


%% DoG Filtering (Difference of Gaussian)
if sigma0 == 0.0
    F2 = fspecial('gaussian', 2*ceil(3*sigma1) + 1, sigma1);
    DoG_Im = Gamma_Im - imfilter(Gamma_Im, F2, 'replicate', 'same');
else
    F1 = fspecial('gaussian', 2*ceil(3*sigma0) + 1, sigma0);
    F2 = fspecial('gaussian', 2*ceil(3*sigma1) + 1, sigma1);
    DoG_Im = imfilter(Gamma_Im, F1, 'replicate', 'same') - imfilter(Gamma_Im, F2, 'replicate', 'same');
end


%% Contrast Equalization
tao = 10;
alpha = 0.1;
Output_Im = DoG_Im./mean(mean(abs(DoG_Im).^alpha))^(1/alpha);
Output_Im = Output_Im./mean(mean(min(tao, abs(Output_Im)).^alpha))^(1/alpha);
Output_Im = tao*tanh(Output_Im/tao);


%% Pixel Normalization
Output_Im = normalize8(Output_Im);
        

