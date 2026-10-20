% Membaca citra biner
citra_biner = imread('potong_biner_negatif1.png');

% Mengidentifikasi properti objek dalam citra biner
properti_objek = regionprops(citra_biner, 'BoundingBox');

% Menghitung jumlah kotak yang ada
disp(['Jumlah Kotak Terdeteksi: ', num2str(numel(properti_objek))]);

citra = imread('Negatif_1.jpg');

hh = fspecial('motion', 5);
bb = imfilter(citra,hh);
r = bb(:,:,1); 
g = bb(:,:,2); % Channel Hijau yang dibutuhkan 
b = bb(:,:,3);

baris_mulai = 10; % Baris awal matriks
baris_akhir = 295; % Baris akhir matriks
kolom_mulai = 35; % Kolom awal matriks
kolom_akhir = 85; % Kolom akhir matriks

bagian_gambar = g(baris_mulai:baris_mulai+baris_akhir-1, kolom_akhir:kolom_akhir+kolom_mulai-1);

% Menampilkan citra biner
figure;
subplot (1,2,1);imshow(citra_biner);
subplot (1,2,2);imshow(bagian_gambar);
hold on;

% Menggambar rectangle pada setiap objek dalam citra
for i = 1:numel(properti_objek)
    bounding_box = properti_objek(i).BoundingBox;
    rectangle('Position', bounding_box, 'EdgeColor', 'r', 'LineWidth', 2);
end
