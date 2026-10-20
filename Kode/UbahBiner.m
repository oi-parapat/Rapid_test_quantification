% Baca gambar 
gambar = imread('Positif_1.jpg'); % Gambar Sudah dipotong Manual sebelumnya
citra_inverted = 255 - gambar;

% Apply Average Filter Pada Gambar
%hh = fspecial('motion', 5);
%bb = imfilter(citra_inverted,hh);
% r = bb(:,:,1); 
g = citra_inverted(:,:,2); % Channel Hijau yang dibutuhkan 
% b = bb(:,:,3);

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

% Menampilkan bagian gambar grayscale
figure;
subplot(1, 4, 1);
imshow(gambar);
subplot(1, 4, 2);
imshow(g);
subplot(1, 4, 3);
imshow(gambar_biner)
subplot(1, 4, 4);
imshow(bagian_gambar)

%Rectangle Fitting
% Mengidentifikasi properti objek dalam citra biner
properti_objek = regionprops(bagian_gambar, 'BoundingBox');

% Menghitung jumlah kotak yang ada
disp(['Jumlah Kotak Terdeteksi: ', num2str(numel(properti_objek))]);

g2 = gambar(:,:,2);

baris_mulai = 10; % Baris awal matriks
baris_akhir = 295; % Baris akhir matriks
kolom_mulai = 35; % Kolom awal matriks
kolom_akhir = 85; % Kolom akhir matriks

gambar_terdeteksi = gambar(baris_mulai:baris_mulai+baris_akhir-1, kolom_akhir:kolom_akhir+kolom_mulai-1);

% Menampilkan citra biner
figure;
subplot (1,2,1);imshow(bagian_gambar);
subplot (1,2,2);imshow(gambar_terdeteksi);
imtool (gambar_terdeteksi)
hold on;
% Menggambar rectangle pada setiap objek dalam citra
for i = 1:numel(properti_objek)
    bounding_box = properti_objek(i).BoundingBox;
    rectangle('Position', bounding_box, 'EdgeColor', 'r', 'LineWidth', 2);
    intensitas_cahaya = mean(bounding_box);
    %disp(['Intensitas Cahaya ke-', num2str(i), ': ', num2str(intensitas_cahaya)]);
    if i == 1
      disp(['Control Line : ', num2str(intensitas_cahaya)]);
    elseif i == 2
      disp(['Test Line 1 : ', num2str(intensitas_cahaya)]);
    elseif i == 3
      disp(['Test Line 2 : ', num2str(intensitas_cahaya)]);
    elseif i > 3+i
      return
    end
end
hold off;

% y = plotBoundingBoxes(gambar_terdeteksi);
% subplot (1,2,2);imshow(y);
% function rectangleFitting(binaryImage)
%     % Menggunakan regionprops untuk mendapatkan properti objek dalam citra biner
%     props = regionprops(bagian_gambar, 'BoundingBox');
% 
%     % Menampilkan citra biner
%     imshow(binaryImage);
%     hold on;
% 
%     % Menggambar rectangle fitting untuk setiap objek
%     for i = 1:numel(props)
%         boundingBox = props(i).BoundingBox;
%         rectangle('Position', boundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
%     end
   







% %Grafik Green Channel
% x = baris_mulai:baris_mulai+baris_akhir-1;
% y = kolom_akhir:kolom_akhir+kolom_mulai-1;
% 
% matriks = g2(x, y);
% gray_values = matriks(:);
% 
% figure;
% subplot(1, 2, 1);
% imshow(matriks);
% title('Matriks Citra');
% 
% subplot(1, 2, 2);
% plot(matriks);
% title('Grafik Matriks');
% xlabel('Kolom');
% ylabel('Baris');
% 
% nilai_puncak_terendah = min(matriks(:));
% disp(['Nilai Puncak Terendah: ', num2str(nilai_puncak_terendah)]);
% 
% sorted_values = sort(matriks(:)); % Mengurutkan nilai-nilai matriks secara menaik
% puncak_terendah_kedua = sorted_values(2);
% 
% [~, idx] = min(matriks(:));
% [baris_puncak, kolom_puncak] = ind2sub(size(matriks), idx);
% 
% hold on;
% plot3(kolom_puncak, baris_puncak, matriks(baris_puncak, kolom_puncak), 'ro', 'MarkerSize', 10);


% Menyimpan gambar
% imwrite(bagian_gambar, "potong_biner_positif2.png");

% % Membuat Histogram
% [histrogram, nilai_piksel] = imhist(g);
% % Plot histogram
% figure;
% bar(nilai_piksel, histrogram);
% title('Histogram Kanal Hijau');
% xlabel('Intensitas Piksel');
% ylabel('Frekuensi');

% % Tampilkan gambar asli dan citra biner
% figure;
% subplot(1, 2, 1);
% imshow(gambar);
% title('Gambar Asli');
% subplot(1, 2, 2);
% imshow(gambar_biner);
% title('Citra Biner (Ambang Batas Adaptif)');

% % Menentukan batas bagian yang diinginkan (misalnya, koordinat pojok kiri atas dan ukuran bagian)
% x = 85; % koordinat x pojok kiri atas
% y = 45; % koordinat y pojok kiri atas
% width = 75; % lebar bagian yang diinginkan
% height = 220; % tinggi bagian yang diinginkan

% global imagel;
%            [filename,pathname] = uigetfile ({'".jpg'},"Open File");
%            fullpathname =strcat (pathname,filename);
%            imagel = imread(fullpathname);
%            imshow (imagel,'Parent',app.UIAxes);
