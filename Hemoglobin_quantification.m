% Molar attenuation coefficient
% The molar attenuation coefficient is a measurement of how strongly a chemical species attenuates light at a given wavelength.


% Absorbance
% The absorbance of a material that has only one attenuating species also depends on the 
% pathlength and the concentration of the species, according to the Beer–Lambert law
% A =Epsilon *c *l
% Epsilon is the molar attenuation coefficient of that material
% c is the molar concentration of those species;
% l is the pathlength


%These values are for the molar extinction coefficient : Epsilon in [cm-1/(moles/liter)]

% nm    HbO2     Hb
% 630	610     5148.8
% 632	561.2	4930.8
% 634	512.4	4730.8
% 636	478.8	4602.4
% 638	460.4	4473.6
% 640	442     4345.2
% 642	423.6	4216.8
% 644	405.2	4088.4
% 646	390.4	3965.08
% 648	379.2	3857.6
% 650	368     3750.12
% 652	356.8	3642.64
% 654	345.6	3535.16
% 656	335.2	3427.68
% 658	325.6	3320.2
% 660	319.6	3226.56
%.......
% 930	1222	763.84
% 932	1219.6	752.28
% 934	1217.2	737.56
% 936	1215.6	722.88
% 938	1214.8	708.16
% 940	1214	693.44
% 942	1213.2	678.72
% 944	1212.4	660.52
% 946	1210.4	641.08
% 948	1207.2	621.64
% 950   1204    602.24
% 952	1200.8	583.4
% 954	1197.6	568.92
% 956	1194	554.48
% 958	1190	540.04
% 960	1186	525.56

% To convert this data to absorbance A, multiply by the molar concentration and the pathlength. 
% For example, if x is the number of grams per liter and a 1 cm cuvette is being used, then the absorbance is given by

 %       (e) [(1/cm)/(moles/liter)] (x) [g/liter] (1) [cm]
 % A =  ---------------------------------------------------
 %                         64,500 [g/mole]

% Molar extinction coefficient



E_650_O = 368;  %E at 650 nm of oxy hemoglobin
E_650_D = 3750; %E at 650 nm of deoxy hemoglobin

E_940_O = 1214; %E at 940 nm of oxy hemoglobin
E_940_D = 678;  %E at 940 nm of deoxy hemoglobin


% cuffed
%%%%%%%%%%%%%%%%%%%%%%%%%
video_650 = 'input.avi'
obj_650 = VideoReader(video_650);

Frames_650 = squeeze(im2single(read(obj_650)));



Image_650_cuffed = mean(Frames_650,3);

% figure;imshow(Image_650_cuffed,[]);

Extract_residual_650_cuffed = 1-segmentImage(Image_650_cuffed); 

m_i_650_c = mean(Image_650_cuffed(Extract_residual_650_cuffed==1),'all');


% m_i_650_c = mean(Image_650_cuffed,'all');

%%%%%%%%%%%%%%%%%%%%%%%%%%
Image_950 = '20211105_Chuqin_950_cuffed_1.avi'
obj_950 = VideoReader(Image_950);

Frames_950 = squeeze(im2single(read(obj_950)));

Image_950_cuffed = mean(Frames_950,3);

Extract_residual_950_cuffed = 1-segmentImage(Image_950_cuffed); 

figure;imshow(Extract_residual_950_cuffed,[]);

m_i_950_c = mean(Image_950_cuffed(Extract_residual_950_cuffed==1),'all');


% m_i_950_c = mean(Image_950_cuffed,'all');


clear obj_650 obj_950

% uncuffed
%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%% normalization  %%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%% cuffed
 
% select the ROI from images


% cuffed 

% 650 nm
Extract_img_650_cuffed = segmentImage(Image_650_cuffed); % extract palm from 940 images
Image_650_cuffed(Extract_img_650_cuffed==0) =0;


% 950 nm



%%%%%%%%%%%%%%%%%%%%% uncuffed 


% im2double

Image_650_cuffed = im2double(Image_650_cuffed);
Image_950_cuffed = im2double(Image_950_cuffed);



% Segmentation (predefined mask)

Mask_650_cuffed = segmentImage(Image_650_cuffed);
Mask_950_cuffed = segmentImage(Image_950_cuffed);



Image_650_cuffed(Mask_650_cuffed==0)=0;
Image_950_cuffed(Mask_950_cuffed==0)=0;

% Normalization
Image_650_cuffed = Image_650_cuffed./max(Image_650_cuffed,[],'all');
Image_950_cuffed = Image_950_cuffed./max(Image_950_cuffed,[],'all');



%% show prcessed images

figure;
set(gcf,'Position',[0,0,2400,400]);
subplot(1,4,1);
imagesc(Image_650_cuffed);
title('Image 650 cuffed');
colorbar();
subplot(1,4,2);
imagesc(Image_950_cuffed);
title('Image 950 cuffed');
colorbar();



% figure;
% subplot(1,4,1);
% imshow(Image_650_cuffed);
% title('Image 650 cuffed');
% subplot(1,4,2);
% imshow(Image_950_cuffed);
% title('Image 950 cuffed');




%% Hemoglobin quantification

% cuffed
 C_HbO2_cuffed = ((1-Image_650_cuffed)-(E_650_D/E_940_D)*(1-Image_950_cuffed))./(E_650_O-(E_650_D/E_940_D)*E_940_O);
 C_HbO2_cuffed = C_HbO2_cuffed./max(C_HbO2_cuffed,[],'all');
 C_HbO2_cuffed(Mask_650_cuffed==0)=0;



 figure;imagesc(C_HbO2_cuffed);title('Oxy-hemoglobin distribution cuffed');colorbar();
    saveas(gcf,['output/oxy.png']);
 

 
 C_Hb_cuffed = ((1-Image_650_cuffed)-(E_650_O/E_940_O)*(1-Image_950_cuffed))./(E_650_D-(E_650_O/E_940_O)*E_940_D);
 C_Hb_cuffed = C_Hb_cuffed./max(C_Hb_cuffed,[],'all'); 
 C_Hb_cuffed(Mask_650_cuffed==0)=0;



  figure;imagesc(C_Hb_cuffed); title('Deoxy-hemoglobin distribution cuffed');colorbar();
    saveas(gcf,['output/deoxy.png']);
  
  

 