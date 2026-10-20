gambar = imread('Positif_2.jpg');

% Proses Segmentasi
cform = makecform ("srgb2lab");
lab = applycform(gambar, cform);

ab = double(lab(:,:,2:3));
nrows = size (ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
nColors = 2;
[cluster_idx,cluster_center] = kmeans(ab,nColors,"distance","sqEuclidean","Replicates",3);
pixel_labels=reshape(cluster_idx,nrows,ncols);
RGB = label2rgb(pixel_labels);

% Mengubah citra menjadi vektor fitur
[rows, cols, ~] = size(gambar);
features = reshape(gambar, rows * cols, 3);

% Melakukan segmentasi menggunakan K-means
[idx, ~] = kmeans(double(features), nColors);

% Mengubah indeks kluster menjadi citra segmen
segmentedImg = reshape(idx, rows, cols);

% % Melakukan thresholding pada citra segmen
% binaryImg = segmentedImg == 1; % Ubah angka kluster sesuai kebutuhan
% 
% % Menampilkan citra biner
% imshow(binaryImg, []);

% Proses Biner Citra Asli
citra_inverted = 255 - gambar;

% Apply Average Filter Pada Gambar
hh = fspecial('motion', 5);
bb = imfilter(citra_inverted,hh);
r = bb(:,:,1); 
g = bb(:,:,2); % Channel Hijau yang dibutuhkan 
b = bb(:,:,3);

% Konversi gambar ke citra biner menggunakan ambang batas adaptif
ambang_batas = graythresh(g);

% Gambar biner dari konversi channel hijau dan nilai ambang batas
gambar_biner = imbinarize(g, ambang_batas);

% Menentukan batas bagian yang diinginkan (misalnya, koordinat pojok kiri atas dan ukuran bagian)
x = 85; % koordinat x pojok kiri atas
y = 10; % koordinat y pojok kiri atas
width = 35; % lebar bagian yang diinginkan
height = 295; % tinggi bagian yang diinginkan

% Memotong bagian yang diinginkan dari gambar grayscale
bagian_gambar = gambar_biner(y:y+height-1, x:x+width-1);

% Hitung kotak pembatas untuk setiap cluster
props = regionprops(bagian_gambar, 'BoundingBox');

% Loop melalui setiap kotak pembatas dan gambari pada gambar
figure;
imshow (RGB, []);
hold on;

for i = 1:numel(props)
    bounding_box = props(i).BoundingBox;
    rectangle('Position',bounding_box, 'EdgeColor', 'r', 'LineWidth', 2);
end

hold off;



