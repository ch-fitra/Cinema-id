# Analisis Cinema ID

Tanggal: 8 November 2026 (Asia/Jakarta).

## Ruang lingkup dan metode

Audit mencakup seluruh folder `Cinema_Id_Laporan`: 14 berkas Dart aplikasi, tes widget, manifest dan konfigurasi platform, dependensi, catatan tugas, isi ZIP/APK, serta struktur container video. Peninjauan source dan hasil Flutter analyzer/test dilakukan pada sesi yang sama. Tidak ada perbaikan kode aplikasi dalam audit ini.

Folder ini awalnya tidak memiliki repository Git. Repository tujuan `ch-fitra/Cinema-id` kosong saat diperiksa. Riwayat awal dibuat pada root folder laporan agar seluruh artefak utama terwakili.

## Arsitektur dan fitur

- Framework: Flutter/Dart; constraint Dart pada pubspec `>=3.3.1 <4.0.0`.
- Dependensi langsung: Provider, carousel_slider, intl, cupertino_icons.
- `main.dart` menyediakan FilmProv, TiketProvider, dan DarkMode melalui MultiProvider.
- `lib/page/`: login, registrasi, beranda, pencarian, genre, detail film, dan histori.
- `lib/components/`: navbar bawah, banner, dan daftar rekomendasi.
- `lib/provider/`: katalog statis, state pemesanan/histori, dan tema.
- Folder Android, iOS, web, Windows, Linux, dan macOS tersedia. Keberadaan folder bukan bukti semua target berhasil dibangun.
- Alur: login/registrasi -> navbar -> katalog/detail -> pilihan bioskop/kursi/tanggal/jam -> histori.

## Hasil verifikasi

Lingkungan pemeriksaan: Flutter 3.47.4, Dart 3.13.3 pada Windows.

| Pemeriksaan | Hasil |
| --- | --- |
| `flutter analyze` | Gagal: 16 temuan, terdiri dari 3 error, 3 warning, dan 10 info |
| `flutter test --no-pub` | Gagal saat memuat tes karena konflik CarouselController; assertion tes belum dijalankan |
| Perbandingan ZIP dengan source/config lokal | Dari 18 berkas yang dibandingkan, hanya pubspec.lock dan analysis_options.yaml berbeda |
| Pemindaian pola kredensial pada source teks | Tidak ditemukan kecocokan pola umum API key/token/private key; bukan audit keamanan menyeluruh |
| Kandidat nama berkas rahasia dalam ZIP | Tidak ditemukan .env, keystore, JKS, PEM, P12, key.properties, atau nama credentials sesuai pola pemindaian |

Flutter otomatis memperbarui 16 dependensi transitif pada pubspec.lock dan menambahkan pengecualian direktori platform/build pada analysis_options.yaml ketika analyzer pertama kali dijalankan. Perubahan tooling ini dipertahankan dan didokumentasikan; source Dart sama dengan ZIP asli. Tidak dilakukan pembaruan dependensi langsung atau upgrade carousel.

## Temuan berprioritas tinggi

1. **Kompilasi terhambat.** `lib/components/banner.dart:16` memakai CarouselController yang ambigu antara carousel_slider 4.2.1 dan Flutter Material. Konflik juga terjadi di dalam paket carousel, sehingga mengganti alias pada aplikasi saja belum menyelesaikan seluruh error. Sesuaikan dependensi dan API controller dengan SDK target, lalu ulangi analyzer/test/build.
2. **Jumlah tab Genre tidak sesuai.** `lib/page/genre.dart:11` menghasilkan tiga tab; `hasil()` pada baris 30 menghasilkan lima halaman dari seluruh enum Kategori. TabController dan TabBarView tidak cocok. Gunakan daftar genre yang sama pada keduanya.
3. **Navigasi genre salah film.** `lib/page/genre.dart:44-48` memakai movies[index], sedangkan kartu menampilkan cari[index]. Pada Comedy/Romance, detail dapat membuka film Action. Gunakan item dari hasil filter.
4. **Pemesanan tidak tervalidasi lengkap.** `lib/page/detail_film.dart:262-275` hanya mewajibkan tanggal dan jam. Bioskop/kursi kosong dapat menghasilkan histori bernilai 0. Tidak ada validasi jam lampau pada hari ini, jadwal resmi, atau kursi yang telah terpesan.
5. **Autentikasi masih simulasi.** `lib/page/login/login.dart:93` hanya memeriksa input tidak kosong; `registrasi.dart:101` hanya memeriksa kedua password cocok dan tidak kosong. Email kosong dapat lolos registrasi. Tidak ada penyimpanan akun, pemeriksaan kredensial, atau sesi pengguna.
6. **Data transaksi tidak persisten.** Histori hanya berupa list di memori, tanpa database maupun identitas pengguna. Data dapat terbawa antarakses pengguna dalam proses aplikasi yang sama dan hilang saat aplikasi dimulai ulang. Belum tersedia backend pembayaran atau reservasi kursi bersama.

## Temuan lainnya

- `provider_tiket.dart:84-86` menjadwalkan penghapusan histori, lalu `detail_film.dart:283` menjadwalkannya lagi. Dua callback dijalankan untuk pesanan yang sama. Callback juga memanggil notifyListeners berulang dan tidak memiliki pengelolaan pembatalan saat provider dibuang.
- Penghapusan sesudah 12 jam menghapus histori, bukan mengubah status pesanan menjadi kedaluwarsa. Tidak ada status menunggu pembayaran/lunas/batal atau waktu kedaluwarsa persisten.
- `histori_page.dart:22` memakai nama film sebagai key Dismissible; dua pembelian film sama memiliki key identik. Gunakan ID pesanan unik.
- Pilihan tiket di-reset oleh tombol kembali khusus pada detail, tetapi belum ada penanganan setara untuk tombol kembali sistem. State pilihan dapat terbawa ke film berikutnya.
- Model Movie tidak mempunyai ID unik. Genre, rekomendasi, dan sedang tayang dicampur dalam satu enum; film diduplikasi sehingga pencarian dapat menampilkan hasil berulang dan data berbeda untuk judul sama.
- Getter movies mengembalikan list mutable; state dapat diubah dari luar tanpa notifyListeners. Model HistoriClass juga mutable.
- Controller input login/registrasi dibuat di build tanpa dispose, sehingga siklus hidup dan kestabilan input tidak terkelola.
- Logout dan Forgot Password belum memiliki aksi. Drawer menambahkan @gmail.com pada nama input, termasuk ketika input sudah berupa email.
- Gambar jaringan belum memiliki placeholder/errorBuilder. Tidak ada fallback saat poster gagal dimuat.
- Ukuran tetap pada beranda/dialog dan scroll bersarang perlu pengujian layar kecil, keyboard, dan pembesaran teks; audit ini belum mengonfirmasi overflow lewat pengujian UI.
- `analysis_options.yaml` menonaktifkan include flutter_lints. Peringatan analyzer mencakup parameter opsional tidak digunakan, import berlebih, dan API deprecated.
- `test/widget_test.dart` masih mengharapkan counter 0/1 serta tombol tambah bawaan Flutter, padahal aplikasi membuka LoginPage. Tes perlu diganti setelah kompilasi diperbaiki.

## Kesiapan platform dan rilis

- Android main manifest tidak mendeklarasikan INTERNET; izin hanya ditemukan pada debug/profile. Ini perlu diperbaiki untuk pemuatan poster di release.
- Android release masih memakai signing debug; application ID masih com.example.cinema_id_v1.
- Android menggunakan AGP 7.3.0, Kotlin 1.7.10, dan Gradle 7.6.3. Kesesuaian toolchain dengan SDK/JDK target belum diuji lewat build Android.
- android/local.properties berisi lokasi SDK dari komputer lama; berkas dikecualikan dari Git, dan harus dihasilkan pada mesin pengembang.
- Konfigurasi macOS belum menunjukkan entitlement network client; target macOS memerlukan pemeriksaan tambahan untuk gambar internet.
- Tidak ada bukti build release terbaru, pengujian perangkat, CI, atau validasi distribusi aplikasi.

## Artefak di root laporan

| Berkas | Ukuran | Pemeriksaan dan batasan |
| --- | --- | --- |
| 0706.mp4 | 121.974.145 byte (116,32 MiB) | Container MP4 terbaca, durasi 435,77 detik. Isi visual/audio belum ditinjau; tidak diklaim sebagai bukti fitur berjalan. |
| cinema_id.apk | 21.550.600 byte (20,55 MiB) | ZIP APK berisi classes.dex, manifest biner, aset Flutter, dan libapp/libflutter untuk arm64-v8a, armeabi-v7a, x86_64. Belum dipasang, diverifikasi sertifikatnya, atau dibuktikan sesuai source saat ini. |
| cinema_id_v1.zip | 765.987 byte | 253 entri; memuat source, konfigurasi platform, serta .idea/.gradle. Arsip asli dipertahankan, bukan paket source bersih baru. |
| laporan_tugas.txt | 792 byte | Daftar komponen UI tugas. Beberapa rujukan perlu diperbaiki: banner ada di components/banner.dart; tooltip pembelian ada di page/detail_film.dart; nama paket carousel_slider. |

Ketiga berkas biner menggunakan Git LFS. Pengguna perlu menjalankan git lfs pull untuk memperoleh isi lengkap setelah clone. Cache dan konfigurasi lokal di dalam ZIP lama tidak terpengaruh aturan .gitignore pada source yang diekstrak.

### SHA-256 artefak asli

```text
0706.mp4          914b71c32cd67a0621ec6b5174001b04351aa9d7eb5dc77088aa354c2135a741
cinema_id.apk    93df5d8e4e75e95aec0bed291f4ed8704a90a67602024fd730762ac3b95cab6e
cinema_id_v1.zip 1d334c04bb86651763736f1fca6c63965cd6a86af2b69eb2d2bbbb86a43a88e9
laporan_tugas.txt 49235f08564aef5ef32346d9ddb1dc2c00b21397df674cedac350111a246f2cd
```

## Urutan tindak lanjut

1. Pulihkan kompilasi dan perbaiki tes agar mencerminkan layar/alur aplikasi.
2. Perbaiki jumlah tab dan pemilihan film pada Genre.
3. Validasi seluruh data pesanan dan buat ID pesanan unik.
4. Pisahkan model film, genre, jadwal, kursi, dan transaksi; hindari duplikasi katalog.
5. Tambahkan autentikasi, penyimpanan persisten, otorisasi pengguna, dan reservasi kursi melalui backend.
6. Terapkan status pembayaran/kedaluwarsa, kemudian integrasi pembayaran sesuai kebutuhan.
7. Lengkapi konfigurasi release, dokumentasi, dan pengujian perangkat/CI.

Kesimpulan: struktur cukup sederhana untuk pembelajaran dan demonstrasi UI, tetapi masih ada penghambat kompilasi dan kekurangan logika inti sebelum layak dipakai untuk transaksi nyata.
