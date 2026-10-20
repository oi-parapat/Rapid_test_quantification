citra = imread('Positif_2.jpg');

hh = fspecial('motion', 5);
bb = imfilter(citra,hh);
r = bb(:,:,1); 
g = bb(:,:,2); % Channel Hijau yang dibutuhkan 
b = bb(:,:,3);

baris_mulai = 10; % Baris awal matriks
baris_akhir = 295; % Baris akhir matriks
kolom_mulai = 35; % Kolom awal matriks
kolom_akhir = 85; % Kolom akhir matriks

bagian_gambar = citra(baris_mulai:baris_mulai+baris_akhir-1, kolom_akhir:kolom_akhir+kolom_mulai-1);

% baris_mulai = 25; % Baris awal matriks
% baris_akhir = 270; % Baris akhir matriks
% kolom_mulai = 75; % Kolom awal matriks
% kolom_akhir = 105; % Kolom akhir matriks

x = baris_mulai:baris_mulai+baris_akhir-1;
y = kolom_akhir:kolom_akhir+kolom_mulai-1;

matriks = g(x, y);

gray_values = matriks(:);
% pixels = 1:numel(gray_values);

% % Mencari puncak terendah
% [peaks, peak_locs] = findpeaks(gray_, gray_values);

figure;
subplot(1, 2, 1);
imshow(matriks);
title('Matriks Citra');

subplot(1, 2, 2);
plot(matriks);
title('Grafik Matriks');
xlabel('Kolom');
ylabel('Baris');
% zlabel('Nilai');

% gray_values = matriks(:);
% pixels = 1:numel(gray_values);

% % Temukan puncak nilai terbawah dalam citra
% regionalMin = imregionalmin(matriks);
% 
% % Hitung jumlah puncak nilai terbawah
% numPeaks = sum(regionalMin(:));
% 
% % Tampilkan citra dengan puncak nilai terbawah yang diidentifikasi
% imshow(matriks);
% hold on;
% plotBoundaries = bwboundaries(regionalMin);
% for k = 1:length(plotBoundaries)
%     boundary = plotBoundaries{k};
%     plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
% end
% hold off;


% [~, idx] = max(matriks(:));
% [baris_puncak, kolom_puncak] = ind2sub(size(matriks), idx);
% 
% hold on;
% plot3(kolom_puncak, baris_puncak, matriks(baris_puncak, kolom_puncak), 'ro', 'MarkerSize', 10);

nilai_puncak_terendah = min(matriks(:));
disp(['Nilai Puncak Terendah: ', num2str(nilai_puncak_terendah)]);

sorted_values = sort(matriks(:)); % Mengurutkan nilai-nilai matriks secara menaik
puncak_terendah_kedua = sorted_values(2);

[~, idx] = min(matriks(:));
[baris_puncak, kolom_puncak] = ind2sub(size(matriks), idx);

hold on;
plot3(kolom_puncak, baris_puncak, matriks(baris_puncak, kolom_puncak), 'ro', 'MarkerSize', 10);

