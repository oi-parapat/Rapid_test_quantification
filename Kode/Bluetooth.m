gambar = imread('Positif_1.jpg');
gambar_inverted = 255-gambar;
g = gambar_inverted(:,:,2);
crop = imcrop(g);
disp(mean2(crop));