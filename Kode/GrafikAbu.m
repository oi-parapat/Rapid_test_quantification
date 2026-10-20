% Membaca gambar
gambar = imread('Positif_2.jpg');
converted = 255 - gambar;

% Mengubah Gambar ke Channel Hijau
g = converted(:,:,2); % Channel Hijau yang dibutuhkan 
% g = gambar(:,:,2); % Channel Hijau yang dibutuhkan 

% Gambar biner dari konversi channel hijau dan nilai ambang batas
gambar_biner = imbinarize(g);

% Memotong Gambar
baris_mulai = 10; % Baris awal matriks
baris_akhir = 295; % Baris akhir matriks
kolom_mulai = 35; % Kolom awal matriks
kolom_akhir = 85; % Kolom akhir matriks

bagian_gambar = gambar_biner(baris_mulai:baris_mulai+baris_akhir-1, kolom_akhir:kolom_akhir+kolom_mulai-1);
bagian_asli = g(baris_mulai:baris_mulai+baris_akhir-1, kolom_akhir:kolom_akhir+kolom_mulai-1);

properti_objek = regionprops(bagian_gambar, 'BoundingBox');

imshow (bagian_asli);
hold on
% Menggambar rectangle pada setiap objek dalam citra
for i = 1:numel(properti_objek)
    bounding_box = properti_objek(i).BoundingBox;
    rectangle('Position', bounding_box, 'EdgeColor', 'r', 'LineWidth', 2);
    intensitas_cahaya = mean(bounding_box);
    disp(['Intensitas Cahaya ke-', num2str(i), ': ', num2str(intensitas_cahaya)]);
end

% % Menentukan batas bagian yang diinginkan (misalnya, koordinat pojok kiri atas dan ukuran bagian)
% x = 100; % koordinat x pojok kiri atas
% y = 200; % koordinat y pojok kiri atas
% width = 300; % lebar bagian yang diinginkan
% height = 200; % tinggi bagian yang diinginkan
% 
% % Memotong bagian yang diinginkan dari gambar grayscale
% bagian_gambar = g(y:y+height-1, x:x+width-1);
% 
% % Menampilkan bagian gambar grayscale
% figure;
% imshow(bagian_gambar);
% colormap gray; % Mengatur colormap menjadi grayscale
% 
% % Opsional: Menambahkan batas pada bagian yang diinginkan
% hold on;
% rectangle('Position', [x, y, width, height], 'EdgeColor', 'r', 'LineWidth', 2);


% % Lakukan segmentasi menggunakan k-means
% [idx, centers] = kmeans(gambar, nColors);
% 
% % Konversi matriks indeks menjadi matriks label yang sesuai dengan ukuran gambar
% labels = reshape(idx, size(gambar));
% 
% % Hitung kotak pembatas untuk setiap cluster
% props = regionprops(labels, 'BoundingBox');
% 
% % Loop melalui setiap kotak pembatas dan gambari pada gambar
% figure;
% imshow(gambar);
% hold on;

