% Demo for high-dimensionality patch-based denoising for 2D and 3D images
% (for real- and complex-valued images)
%
% This demo file uses the Bustin_denoising_patch_mex_v4 package
%
% Author:
%   Aurelien Bustin (aurelien.bustin@ihu-liryc.fr)
%   IHU LIRYC, May 2021
%
% People who contributed to this code:
%   Thomas Kuestner, University Hospital of Tübingen, Tübingen, Germany
%   Claudia Prieto, KCL, London, UK
%   René Botnar, KCL, London, UK
%   Gastao Cruz, KCL, London, UK
%   Olivier Jaubert, UCL, London, UK
%   Freddy Odille, IADI, Nancy, France
%
% Papers using this code:
%
%     | 1) Bustin A, Ginami G, Cruz G, Correia T, Ismail TF, Rashid I, Neji R, Botnar RM, Prieto C
%     | Five-Minute Whole-Heart Coronary MRA with Sub-millimeter Isotropic Resolution,
%     | 100% Respiratory Scan Efficiency and 3D-PROST Reconstruction.
%     | Magnetic Resonance in Medicine, 2019, 81(1):102-115, DOI: 10.1002/mrm.27354
%  
%     | 2) A. Bustin et al.,
%     | High-Dimensionality Undersampled Patch-Based Reconstruction (HD-PROST)
%     | for Accelerated Multi-Contrast Magnetic Resonance Imaging.
%     | Magnetic Resonance in Medicine, 2019, 81(6):3705-3719, DOI: 10.1002/mrm.27694
%  
%     | 3) Bustin A, Milotta G, Ismail TF, Neji R, Botnar RM, Prieto C
%     | Accelerated free-breathing whole-heart 3D T2 mapping with high isotropic
%     | resolution.
%     | Magnetic Resonance in Medicine, 2020, 83(3):988-1002, DOI: 10.1002/mrm.27989
%     
%     
% This demo will help you denoise different types of images:
%   1) Real-valued single-contrast 2D image
%   2) Real-valued single-contrast 2D images
%   3) Complex-valued multi-contrast 2D MRI (MR fingerprinting images)
%
% More information on the parameters:
%   sig         : Regularization parameter (see recon_mode)
%   patch_sz    : Size of patches (depends on the image resolution)
%   max_patch   : Number of similar patches to be found
%   win         : Size of search window for patch selection
%   offset      : Patch offset (to accelerate the denoising)
%   debug       : Display some info
%   recon_mode  : Reconstruction mode (see below examples of modes)
%   type        : Thresholding type (0 = global thresholing / 1 = thresholding based on the highest singular value (percentage) / 2 = will only keep the first x (=sig) highest singular values)
%   sharpness   : Weight given to the high-pass filtering (the higher the sharper)
%   Ncores      : Number of cores to use
%   reference   : Image used for patch selection (useful for multi-contrast denoising)
%
% Reconstruction modes (recon_mode parameter):
%     [3]  2D single contrast (real-valued)
%     [4]  3D single contrast (real-valued)
%     [5]  2D multi contrast (complex-valued)
%     [6]  3D multi contrast (complex-valued)
%
% The code requires the installation of the GSL library (See INSTALL_GSL file)


%% 1) DEMO FOR 2D DENOISING (REAL-VALUED INPUT)

% This is the demo for 2D single-contrast denoising
% applied on real-world images

% Read image and resize
img = double(rgb2gray(imread('./DATA/London1.JPG')));

% Change the resolution according to your need
% High-Resolution:
img = imresize(img, .5);
% Low-Resolution:
% img = imresize(img, .1);

% Crop
img = img(372:798,1164:1507);
ori = img;

% Add noise
noise_std = 5;
img = img + noise_std*randn(size(img));

% Denoising parameters
sig         =  0.05; % regularization parameter
type        =  0;    % thresholding type
patch_sz    =  5;    % size of patches
max_patch   =  20;   % number of similar patches to select
win         =  80;   % size of search window
offset      =  4;    % patch offset (skip x pixels to accelerate)
debug       =  1;    % display some infos
recon_mode  =  3;    % reconstruction mode
sharpness   =  1.0;  % sharpness index
Ncores      =  100;  % will use the maximum number of cores available

scaling = double(max(img(:)));

% note: we split real/imag parts just to the enter the mexfile, but the
% denoising is effectively done on complex-valued data (it is NOT performed
% on the real and imaginary parts separately).
input_real = double(real(img))./scaling;
input_imag = double(imag(img))./scaling;

% Run patch-based denoising
[hd_prost_reco_real, hd_prost_imag] = Bustin_denoising_patch_mex_v4(input_real, input_imag, sig, patch_sz, max_patch, win, offset, debug, recon_mode, type, sharpness, Ncores);

% Scale back
hd_prost_reco = (hd_prost_reco_real + 1i.*hd_prost_imag) * scaling;

% Display
figure,
imshow(cat(2,ori, abs(img), abs(hd_prost_reco)),[0 255]);
title('ORIGINAL / NOISY / DENOISED');


%% 2) DEMO FOR 2D + CONTRAST DENOISING

% Read image and resize
img = im2double(imread('./DATA/London1.JPG'));

% Change the resolution according to your need
% High-Resolution:
img = imresize(img, .5);
% Low-Resolution:
% img = imresize(img, .1);

% Crop
img = img(372:798,1164:1507,:);
ori = img;

% Add noise
noise_std = 0.04;
img = img + noise_std*randn(size(img));

% Denoising parameters
sig         =  0.05; % regularization parameter
type        =  0;    % thresholding type
patch_sz    =  5;    % size of patches
max_patch   =  20;   % number of similar patches to select
win         =  80;   % size of search window
offset      =  4;    % patch offset (skip x pixels to accelerate)
debug       =  1;    % display some infos
recon_mode  =  5;    % reconstruction mode
sharpness   =  1.0;  % sharpness index
Ncores      =  100;  % will use the maximum number of cores

scaling = double(max(img(:)));

input_real = double(real(img))./scaling;
input_imag = double(imag(img))./scaling; % the input noisy image is real here

% Run patch-based denoising
[hd_prost_reco_real, hd_prost_imag] = Bustin_denoising_patch_mex_v4(input_real, input_imag, sig, patch_sz, max_patch, win, offset, debug, recon_mode, type, sharpness, Ncores);

% Scale back
hd_prost_reco = (hd_prost_reco_real + 1i.*hd_prost_imag) * scaling;

% Display
figure,
imshow(cat(2,ori, abs(img), abs(hd_prost_reco)),[0 255]);
title('ORIGINAL / NOISY / DENOISED');


%% 3) DEMO FOR 2D + CONTRAST DENOISING (COMPLEX-VALUED INPUT)
% Magnetic Resonance Fingerprinting example (courtesy of O. Jaubert)

% Read image
load('./DATA/data_MRF_2D.mat');

% Dimension input.......... 2D 
% Number of contrast....... 10
% Size input............... 255 x 211 x 10

% Denoising parameters
sig         =  25;   % regularization parameter
patch_sz    =  7;    % size of patches
max_patch   =  30;   % number of similar patches to select
win         =  150;  % size of search window
offset      =  4;    % patch offset (to accelerate)
debug       =  1;    % display some infos
recon_mode  =  5;    % reconstruction mode
type        =  2;    % thresholding type
sharpness   =  1.3;  % sharpness index
Ncores      =  100;  % will use the maximum number of cores

% note: we split real/imag parts just to the enter the mexfile, but the
% denoising is effectively done on complex-valued data (it is NOT performed
% on the real and imaginary parts separately).
input_real = double(real(img));
input_imag = double(imag(img));

% Reference image (for patch selection)
reference = img(:,:,1);% or: mean(abs(input_real),3);

% Run HD-PROST reconstruction
[hd_prost_reco_real, hd_prost_imag] = Bustin_denoising_patch_mex_v4(input_real, input_imag, sig, patch_sz, max_patch, win, offset, debug, recon_mode, type, sharpness, Ncores, reference);

% Build the complex-valued denoised image
hd_prost_reco = (hd_prost_reco_real + 1i.*hd_prost_imag);

% Display
figure,
subplot(211),
imshow(cat(2, abs(img(:,:,1))*0.1, abs(img(:,:,2)), abs(img(:,:,4))),[0 10]);
title('Original');
subplot(212),
imshow(cat(2, abs(hd_prost_reco(:,:,1))*0.1, abs(hd_prost_reco(:,:,2)), abs(hd_prost_reco(:,:,4))),[0 10]);
title('Denoised');
colormap(hot);




