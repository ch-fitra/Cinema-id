# Cinema ID

**Aplikasi katalog film dan simulasi pemesanan tiket bioskop berbasis Flutter.**

Cinema ID dibuat untuk pembelajaran pengembangan aplikasi: menampilkan katalog film, mencari judul, memilih bioskop dan kursi, serta melihat riwayat pemesanan. State aplikasi dikelola menggunakan Provider.

> **Status proyek:** prototipe. Login dan registrasi belum memverifikasi akun, data pemesanan hanya tersimpan selama aplikasi berjalan, dan pembayaran belum terintegrasi. Pemeriksaan pada 8 November 2026 menemukan penghambat kompilasi dan beberapa bug fungsional. Lihat [laporan analisis](ANALISIS_PROJECT.md).

## Daftar isi

- [Fitur](#fitur)
- [Teknologi](#teknologi)
- [Struktur repository](#struktur-repository)
- [Instalasi](#instalasi)
- [Menjalankan dan memeriksa aplikasi](#menjalankan-dan-memeriksa-aplikasi)
- [Alur penggunaan](#alur-penggunaan)
- [Berkas pendukung](#berkas-pendukung)
- [Masalah yang diketahui](#masalah-yang-diketahui)
- [Prioritas pengembangan](#prioritas-pengembangan)

## Fitur

| Fitur | Implementasi saat ini |
| --- | --- |
| Login dan registrasi | Form dengan validasi dasar, belum terhubung ke layanan autentikasi |
| Beranda | Banner film sedang tayang dan daftar rekomendasi |
| Pencarian | Pencarian judul dari katalog lokal |
| Genre | Action, Comedy, dan Romance; masih memiliki bug tab dan navigasi |
| Detail film | Poster, tanggal rilis, rating, dan sinopsis |
| Pemesanan | Pilihan bioskop, kursi, tanggal, jam, dan perhitungan harga |
| Riwayat | Daftar pesanan, dialog struk, dan penghapusan item |
| Tema | Pergantian mode terang dan gelap |

Katalog film ditulis langsung di kode. Poster dimuat dari `image.tmdb.org` dan memerlukan koneksi internet. Label sedang tayang menggunakan data statis, bukan jadwal bioskop terkini.

## Teknologi

| Teknologi | Peran |
| --- | --- |
| Flutter / Dart | Antarmuka dan logika aplikasi |
| `provider` | Pengelolaan state film, tiket, dan tema |
| `carousel_slider` | Carousel banner film |
| `intl` | Format tanggal |
| `flutter_test` | Pengujian widget |
| Git LFS | Penyimpanan video, APK, dan ZIP |

Konfigurasi Android, iOS, web, Windows, Linux, dan macOS tersedia. Seluruh target tersebut belum diverifikasi melalui build pada audit ini.

## Struktur repository

```text
Cinema-id/
|-- README.md
|-- ANALISIS_PROJECT.md
|-- laporan_tugas.txt
|-- 0706.mp4
|-- cinema_id.apk
|-- cinema_id_v1.zip
`-- cinema_id_v1/
    `-- cinema_id_v1/             # Root aplikasi Flutter
        |-- lib/
        |   |-- main.dart        # Entry point dan konfigurasi Provider
        |   |-- components/      # Banner, navbar, dan rekomendasi
        |   |-- page/            # Halaman dan alur aplikasi
        |   `-- provider/        # Data film, state tiket, dan tema
        |-- test/                # Tes widget
        |-- android/
        |-- ios/
        |-- web/
        |-- windows/
        |-- linux/
        |-- macos/
        `-- pubspec.yaml         # Dependensi dan konfigurasi Flutter
```

Folder bertingkat `cinema_id_v1/cinema_id_v1` dipertahankan sesuai susunan proyek asli. Jalankan perintah Flutter dari folder tersebut.

## Instalasi

Siapkan Git, Git LFS, Flutter SDK beserta Dart, serta perangkat atau emulator untuk platform tujuan. Untuk Android, siapkan Android SDK dan selesaikan konfigurasi toolchain yang dilaporkan oleh `flutter doctor`.

### 1. Clone repository

```sh
git lfs install
git clone https://github.com/ch-fitra/Cinema-id.git
cd Cinema-id
git lfs pull
```

`git lfs pull` mengambil isi lengkap video, APK, dan ZIP. Jika berkas tersebut hanya berisi teks yang diawali `version https://git-lfs.github.com/spec/v1`, isi Git LFS belum terunduh.

### 2. Siapkan dependensi

```sh
cd cinema_id_v1/cinema_id_v1
flutter doctor
flutter pub get
```

`pubspec.yaml` menetapkan constraint Dart `>=3.3.1 <4.0.0`. Versi SDK yang bisa digunakan juga dipengaruhi dependensi dan `pubspec.lock`. Audit menggunakan **Flutter 3.47.4 / Dart 3.13.3** dan menemukan konflik carousel; versi tersebut belum menjadi konfigurasi build yang berhasil.

Konfigurasi SDK lokal seperti `android/local.properties` tidak dilacak Git. Sesuaikan lokasi SDK dengan komputer pengembang.

## Menjalankan dan memeriksa aplikasi

Setelah penghambat kompilasi diperbaiki, jalankan:

```sh
flutter devices
flutter run -d <device-id>
```

Ganti `<device-id>` dengan ID perangkat dari `flutter devices`.

Untuk analisis dan pengujian:

```sh
flutter analyze
flutter test
```

Hasil pemeriksaan pada 8 November 2026:

| Pemeriksaan | Hasil |
| --- | --- |
| `flutter analyze` | 16 temuan: 3 error, 3 warning, dan 10 info |
| `flutter test --no-pub` | Gagal pada tahap kompilasi karena konflik `CarouselController` |
| Build release dan pengujian perangkat | Belum dilakukan pada audit ini |

Tes yang tersedia masih berupa tes counter bawaan Flutter dan perlu disesuaikan dengan aplikasi Cinema ID.

## Alur penggunaan

1. Buka form login atau registrasi untuk masuk ke antarmuka utama.
2. Telusuri rekomendasi, banner, atau hasil pencarian film.
3. Buka detail film, lalu tekan tombol pembelian.
4. Pilih bioskop, kursi, tanggal, dan jam tonton.
5. Tekan **Buy Now** untuk menambahkan pesanan ke riwayat lokal.
6. Buka **Purchase History** untuk melihat pesanan dan dialog struk.

Alur ini menggambarkan implementasi prototipe. Tombol pembelian belum menjalankan pembayaran atau reservasi kursi pada sistem bioskop.

## Berkas pendukung

| Berkas | Keterangan |
| --- | --- |
| [Laporan analisis](ANALISIS_PROJECT.md) | Temuan kode, hasil pemeriksaan, batasan audit, dan urutan perbaikan |
| [Catatan tugas](laporan_tugas.txt) | Daftar komponen antarmuka dan rujukan implementasi |
| [APK](cinema_id.apk) | APK yang disertakan sejak awal; belum dipasang atau dibuktikan sesuai source saat ini |
| [Arsip proyek](cinema_id_v1.zip) | ZIP asli sebagai referensi; masih memuat cache dan konfigurasi lokal lama |
| [Video](0706.mp4) | Video sekitar 7 menit 16 detik; isi visual dan audio belum ditinjau pada audit |

APK, ZIP, dan video disimpan melalui Git LFS. Cache, build sementara, dan konfigurasi mesin lokal pada folder source dikecualikan melalui `.gitignore`.

## Masalah yang diketahui

- **Kompilasi:** `carousel_slider 4.2.1` mengalami konflik `CarouselController` dengan Flutter pada lingkungan audit. Konflik juga terjadi di dalam paket tersebut.
- **Genre:** jumlah tab tidak sesuai jumlah halaman, dan navigasi detail menggunakan indeks daftar film yang belum difilter.
- **Pemesanan:** bioskop dan kursi belum diwajibkan; belum ada pemeriksaan ketersediaan kursi atau jadwal resmi.
- **Akun dan data:** belum ada autentikasi, pemisahan data per pengguna, atau penyimpanan persisten.
- **Riwayat:** timer penghapusan dijadwalkan dua kali dan key item belum unik untuk pembelian film yang sama.
- **Rilis Android:** izin internet pada main manifest belum tersedia dan signing release masih memakai konfigurasi debug.

Lihat [ANALISIS_PROJECT.md](ANALISIS_PROJECT.md) untuk lokasi kode dan penjelasan dampak setiap temuan.

## Prioritas pengembangan

1. Selesaikan konflik kompilasi dan sesuaikan tes dengan alur aplikasi.
2. Perbaiki tab Genre, navigasi detail, dan validasi pemesanan.
3. Tambahkan ID unik untuk film dan pesanan, lalu rapikan model data.
4. Implementasikan autentikasi, database, dan reservasi kursi melalui backend.
5. Tambahkan status pesanan, pengelolaan kedaluwarsa, dan integrasi pembayaran.
6. Lengkapi konfigurasi release serta pengujian perangkat dan CI.
