# Demo for high-dimensionality patch-based denoising (PROST and HD-PROST)

This demo file uses the Bustin_denoising_patch_mex_v4 package

Author:
  Aurelien Bustin (aurelien.bustin@ihu-liryc.fr)
  IHU LIRYC, May 2021

People who contributed to this code:
  - Thomas Kuestner (University Hospital of Tübingen, Tübingen, Germany)
  - Claudia Prieto (KCL, London, UK)
  - René Botnar (KCL, London, UK)
  - Gastao Cruz (KCL, London, UK)
  - Olivier Jaubert (UCL, London, UK)
  - Freddy Odille (IADI, Nancy, France)

<p align="center">
  <img src="https://user-images.githubusercontent.com/59660095/119362824-6b454d00-bcad-11eb-83e5-2f1edd54bdc0.png">
</p>


Papers using this code:

    | 1) Bustin A, Ginami G, Cruz G, Correia T, Ismail TF, Rashid I, Neji R, Botnar RM, Prieto C
    | Five-Minute Whole-Heart Coronary MRA with Sub-millimeter Isotropic Resolution,
    | 100% Respiratory Scan Efficiency and 3D-PROST Reconstruction.
    | Magnetic Resonance in Medicine, 2019, 81(1):102-115, DOI: 10.1002/mrm.27354
 
    | 2) A. Bustin et al.,
    | High-Dimensionality Undersampled Patch-Based Reconstruction (HD-PROST)
    | for Accelerated Multi-Contrast Magnetic Resonance Imaging.
    | Magnetic Resonance in Medicine, 2019, 81(6):3705-3719, DOI: 10.1002/mrm.27694
 
    | 3) Bustin A, Milotta G, Ismail TF, Neji R, Botnar RM, Prieto C
    | Accelerated free-breathing whole-heart 3D T2 mapping with high isotropic
    | resolution.
    | Magnetic Resonance in Medicine, 2020, 83(3):988-1002, DOI: 10.1002/mrm.27989
    
    
This demo will help you denoise different types of images:
  1) Real-valued single-contrast 2D image
  2) Real-valued single-contrast 2D images
  3) Complex-valued multi-contrast 2D MRI (MR fingerprinting images)


The code requires the installation of the GSL library (See INSTALL_GSL file)

# Results for Magnetic Resonance Fingerprinting images
<p align="center">
  <img src="https://user-images.githubusercontent.com/59660095/119360898-5ff12200-bcab-11eb-823a-3999b206ca5e.png">
</p>

# Results for multi-contrast images
<p align="center">
  <img src="https://user-images.githubusercontent.com/59660095/119360289-c0339400-bcaa-11eb-84bd-5417791f4014.png">
</p>




