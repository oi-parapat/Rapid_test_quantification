%cam = ipcam('http://192.168.1.50:81/stream');
%preview (cam)
%img = snapshot(cam);
%webcamlist
% % Baca gambar 
% %gambar = imread('Negatif_1.jpg'); % Gambar Sudah dipotong Manual sebelumnya
% citra_inverted = 255 - img;
% 
% % Apply Average Filter Pada Gambar
% hh = fspecial('motion', 5);
% bb = imfilter(citra_inverted,hh);
% r = bb(:,:,1); 
% g = bb(:,:,2); % Channel Hijau yang dibutuhkan 
% b = bb(:,:,3);
% 
% % Konversi gambar ke citra biner menggunakan ambang batas adaptif
% ambang_batas = graythresh(g);
% 
% % Gambar biner dari konversi channel hijau dan nilai ambang batas
% gambar_biner = imbinarize(g, ambang_batas);
% 
% % Menentukan batas bagian yang diinginkan (misalnya, koordinat pojok kiri atas dan ukuran bagian)
% x = 85; % koordinat x pojok kiri atas
% y = 10; % koordinat y pojok kiri atas
% width = 35; % lebar bagian yang diinginkan
% height = 295; % tinggi bagian yang diinginkan
% 
% % Memotong bagian yang diinginkan dari gambar grayscale
% bagian_gambar = gambar_biner(y:y+height-1, x:x+width-1);
% 
% % Menampilkan bagian gambar grayscale
% figure;
% subplot(1, 4, 1);
% imshow(img);
% subplot(1, 4, 2);
% imshow(g);
% subplot(1, 4, 3);
% imshow(gambar_biner)
% subplot(1, 4, 4);
% imshow(bagian_gambar)
% 
% %Rectangle Fitting
% % Mengidentifikasi properti objek dalam citra biner
% properti_objek = regionprops(bagian_gambar, 'BoundingBox');
% 
% % Menghitung jumlah kotak yang ada
% disp(['Jumlah Kotak Terdeteksi: ', num2str(numel(properti_objek))]);
% 
% g2 = img(:,:,2);
% 
% baris_mulai = 10; % Baris awal matriks
% baris_akhir = 295; % Baris akhir matriks
% kolom_mulai = 35; % Kolom awal matriks
% kolom_akhir = 85; % Kolom akhir matriks
% 
% gambar_terdeteksi = g2(baris_mulai:baris_mulai+baris_akhir-1, kolom_akhir:kolom_akhir+kolom_mulai-1);
% 
% % Menampilkan citra biner
% figure;
% subplot (1,2,1);imshow(bagian_gambar);
% subplot (1,2,2);imshow(gambar_terdeteksi);
% hold on;
% 
% % Menggambar rectangle pada setiap objek dalam citra
% for i = 1:numel(properti_objek)
%     bounding_box = properti_objek(i).BoundingBox;
%     rectangle('Position', bounding_box, 'EdgeColor', 'r', 'LineWidth', 2);
%     intensitas_cahaya = mean(bounding_box);
%     disp(['Intensitas Cahaya ke-', num2str(i), ': ', num2str(intensitas_cahaya)]);
% end

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

gambar = imread('Positif_1.jpg');
gambar_inverted = 255-gambar;
g = gambar_inverted(:,:,2);
imshow(g);
num_boxes = 3; % Ganti sesuai dengan jumlah kotak yang ingin Anda buat
rectangles = cell(num_boxes, 1);

for i = 1:num_boxes
    h = drawrectangle; % Anda dapat menarik kotak pada citra menggunakan mouse
    % Tunggu pengguna menyelesaikan penarikan kotak
    rectangles{i} = h;
end

% Langkah 4: Hitung nilai-nilai citra dari setiap kotak yang dipilih
mean_values = zeros(num_boxes,1);

for i = 1:num_boxes
    pos = get(rectangles{i}).Position;
    x1 = round(pos(1));
    y1 = round(pos(2));
    width = round(pos(3));
    height = round(pos(4));
    x2 = x1 + width - 1;
    y2 = y1 + height - 1;

    selected_region = g(y1:y2, x1:x2, :);
    mean_values(i) = mean2(selected_region);
end

% Tampilkan nilai-nilai mean dari setiap kotak
disp('Nilai Mean dari Setiap Kotak:');
disp(mean_values);
% h = drawrectangle('Color',[1 0 0]);
% pos = h.Position;
% 
% % Langkah 4: Ambil posisi kotak yang diambil oleh pengguna
% x1 = round(pos(1));
% y1 = round(pos(2));
% width = round(pos(3));
% height = round(pos(4));
% x2 = x1 + width - 1;
% y2 = y1 + height - 1;
% 
% % Langkah 5: Hitung nilai citra di dalam kotak yang dipilih
% selected_region = gambar(y1:y2, x1:x2, :);
% sum_value = mean(selected_region(:)); % Menghitung jumlah nilai piksel di dalam kotak
% 
% % Tampilkan kotak yang dipilih dan jumlah nilai piksel
% figure;
% imshow(gambar);
% hold on;
% rectangle('Position', [x1, y1, width, height], 'EdgeColor', 'r', 'LineWidth', 2);
% hold off;
% title(['Kotak Terpilih dan Jumlah Nilai Piksel: ', num2str(sum_value)]);

%-----------APP DESIGNER----------------
%             imshow(app.img3);
%             app.num_boxes = 2; % Jumlah kotak yang ingin Anda gambar
%             rect = drawrectangle;
%             app.rectangles = cell(1, app.num_boxes);
%             app.rectangles{1} = rect;
% 
%             for i = 2:app.num_boxes
%                 app.rectangles{i} = copyobj(rect, gca);
%             end
% 
%             imshow (app.img3,"Parent",app.UIAxes_7);
%             hold on
%             app.result = {};
%             app.IntensitasTextArea.Value = " ";
%             for i = 1:app.num_boxes   
%                % Ambil posisi kotak yang diambil oleh pengguna
%                pos = app.rectangles{i}.Position;
%                x1 = round(pos(1));
%                y1 = round(pos(2));
%                width = round(pos(3));
%                height = round(pos(4));
%                x2 = x1 + width - 1;
%                y2 = y1 + height - 1;
%                rectangle(app.UIAxes_7,'Position', [x1, y1, width, height], 'EdgeColor', 'r', 'LineWidth', 2);
%                selected_region = app.img3(y1:y2, x1:x2, :);
%                app.mean_values(i) = mean2(selected_region);
%                Intensitas = num2str(app.mean_values(i));
%                if str2double(Intensitas) >=0 && str2double(Intensitas) <121
%                   Hasil = "+1";
%                elseif str2double(Intensitas) >=121 && str2double(Intensitas) <180
%                   Hasil = "2";
%                elseif str2double(Intensitas) >=180
%                   Hasil = "+3";
%                end
%                app.result{i,1}= char(append("Kotak",num2str(i),": ", Hasil," ","Nilai",num2str(i),": ", Intensitas));
%                app.IntensitasTextArea.Value = app.result;
%                % Geser posisi untuk kotak berikutnya
%                y1 = y1 + height + 230; % Ganti angka 20 sesuai dengan jarak antar kotak
%             end
%             hold off

%-----------APP DESIGNER 2-----------
%             imshow(g);
%             for i = 1:num_boxes
%             h = drawrectangle; % Anda dapat menarik kotak pada citra menggunakan mouse
%             app.rectangles{i} = h;
%             end
% 
%             % Hitung nilai-nilai citra dari setiap kotak yang dipilih
%             app.mean_values = zeros(num_boxes, 1);
%             
%             imshow(g,"Parent", app.UIAxes_12);
%             hold on
%             app.result = {};
%             for i = 1:num_boxes
%                 pos = app.rectangles{i}.Position;
%                 x1 = round(pos(1));
%                 y1 = round(pos(2));
%                 width = round(pos(3));
%                 height = round(pos(4));
%                 x2 = x1 + width - 1;
%                 y2 = y1 + height - 1;
%                 selected_region = g(y1:y2, x1:x2, :);
%                 app.mean_values(i) = mean2(selected_region);
%                 Intensitas = num2str(app.mean_values(i));
%                 if str2double(Intensitas) >=0 && str2double(Intensitas) <50
%                    Hasil = "+3";
%                 elseif str2double(Intensitas) >=50 && str2double(Intensitas) <80
%                    Hasil = "+2";
%                 elseif str2double(Intensitas) >=80
%                    Hasil = "+1";
%                 end
%                 rectangle(app.UIAxes_12,'Position', [x1, y1, width, height], 'EdgeColor', 'r', 'LineWidth', 2);
%                 app.result{i,1}= char(append("Kotak",num2str(i),": ", Hasil," ","Nilai",num2str(i),": ", app.mean_values));
%                 app.IntensitasTextArea_2.Value = app.result;
%             end
%             
%            
