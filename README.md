# Cinema ID

**Aplikasi katalog film dan simulasi pemesanan tiket bioskop berbasis Flutter.**

Cinema ID merupakan proyek pembelajaran pengembangan aplikasi yang menggabungkan katalog film, pencarian, informasi film, dan alur pemesanan tiket dalam satu antarmuka. Pengguna dapat memilih bioskop, kursi, tanggal, dan jam menonton, lalu melihat ringkasan pesanan melalui riwayat pembelian.

## Fitur

- **Beranda:** banner film sedang tayang dan daftar rekomendasi.
- **Pencarian film:** mencari judul dari katalog yang tersedia.
- **Kategori genre:** Action, Comedy, dan Romance.
- **Detail film:** poster, sinopsis, rating, dan tanggal rilis.
- **Simulasi pemesanan:** pilihan bioskop, kursi, tanggal, jam, serta perhitungan total harga.
- **Riwayat pemesanan:** daftar pesanan, dialog struk, dan penghapusan item.
- **Login dan registrasi:** form untuk masuk ke alur utama aplikasi.
- **Mode terang dan gelap:** pengaturan tema melalui drawer di beranda.

> Aplikasi masih berupa prototipe. Form akun belum terhubung ke autentikasi, pesanan hanya tersimpan di memori, dan tombol pembelian belum memproses pembayaran atau memesan kursi pada sistem bioskop. Katalog dan label sedang tayang menggunakan data statis.

## Teknologi

| Teknologi | Kegunaan |
| --- | --- |
| Flutter dan Dart | Antarmuka serta logika aplikasi |
| Provider | Pengelolaan state film, tiket, dan tema |
| Carousel Slider | Banner film pada beranda |
| Intl | Format tanggal pada riwayat |
| Flutter Test | Pengujian widget |

Poster film dimuat dari `image.tmdb.org`, sehingga membutuhkan koneksi internet.

## Struktur proyek

```text
Cinema-id/
|-- lib/
|   |-- main.dart                 # Entry point dan konfigurasi Provider
|   |-- components/               # Banner, navigasi bawah, dan rekomendasi
|   |-- page/
|   |   |-- login/                # Form login dan registrasi
|   |   |-- home.dart             # Beranda
|   |   |-- pencarian.dart        # Pencarian film
|   |   |-- genre.dart            # Kategori film
|   |   |-- detail_film.dart      # Informasi film dan pemesanan
|   |   `-- histori_page.dart     # Riwayat dan struk pesanan
|   `-- provider/                 # State katalog, pemesanan, dan tema
|-- test/                         # Tes widget
|-- android/
|-- ios/
|-- web/
|-- windows/
|-- linux/
|-- macos/
|-- pubspec.yaml                  # Konfigurasi dan dependensi
`-- README.md
```

Konfigurasi beberapa platform tersedia, tetapi keberadaannya belum berarti seluruh target telah berhasil dibangun dan diuji.

## Persiapan

Siapkan:

1. Git untuk mengambil source.
2. Flutter SDK beserta Dart.
3. Perangkat atau emulator untuk menjalankan aplikasi.
4. Android SDK jika menjalankan target Android.

Periksa lingkungan pengembangan dengan:

```sh
flutter doctor
```

Constraint Dart pada `pubspec.yaml` adalah `>=3.3.1 <4.0.0`. Kesesuaian SDK juga mengikuti dependensi dan `pubspec.lock`.

## Instalasi dan menjalankan aplikasi

```sh
git clone https://github.com/ch-fitra/Cinema-id.git
cd Cinema-id
flutter pub get
flutter devices
```

Setelah masalah kompatibilitas yang dijelaskan di bawah diselesaikan, jalankan pada perangkat yang terhubung:

```sh
flutter run
```

Jika terdapat beberapa perangkat, tentukan ID perangkat dari hasil `flutter devices`:

```sh
flutter run -d <device-id>
```

Seluruh perintah Flutter dijalankan dari root repository, yaitu folder yang berisi `pubspec.yaml`. Konfigurasi SDK lokal seperti `android/local.properties` disesuaikan dengan komputer pengembang dan tidak dilacak Git.

## Cara menggunakan aplikasi

### 1. Masuk ke aplikasi

Pada halaman **Login**, isi kolom email/nomor telepon dan password, kemudian tekan **Login**. Jika ingin mencoba form registrasi, pilih **Register**, isi email, password, dan konfirmasi password yang sama.

Pada versi ini, form hanya melakukan validasi dasar. Akun belum dibuat atau diverifikasi melalui server.

### 2. Menemukan film

Di halaman **Home**, telusuri banner dan daftar rekomendasi. Gunakan ikon pencarian untuk mengetik judul dan mengirim pencarian. Menu **Genre** pada navigasi bawah menyediakan kategori film.

### 3. Melihat informasi film

Tekan kartu atau poster film untuk membuka detail berisi tanggal rilis, rating, dan sinopsis. Tanggal rilis yang ditampilkan merupakan informasi film, bukan jadwal tayang bioskop.

### 4. Membuat simulasi pesanan

1. Tekan tombol pembelian dengan ikon uang di halaman detail.
2. Pilih salah satu bioskop.
3. Pilih kursi menggunakan kontrol pada chip kursi.
4. Tentukan tanggal dan jam menonton.
5. Periksa pilihan dan total harga, lalu tekan **Buy Now**.

Harga pada prototipe dihitung berdasarkan jumlah kursi:

| Bioskop | Harga per kursi |
| --- | --- |
| Bioskop 1 | Rp20.000 |
| Bioskop 2 | Rp15.000 |
| Bioskop 3 | Rp35.000 |

Harga tersebut merupakan nilai contoh di kode, bukan tarif bioskop aktual. Pemesanan belum memeriksa jadwal resmi atau ketersediaan kursi.

### 5. Melihat riwayat

Pilih **Purchase History** pada navigasi bawah. Tekan pesanan untuk membuka dialog struk, atau geser item untuk menghapusnya. Riwayat disimpan sementara dan dapat hilang ketika aplikasi dimulai ulang; implementasi juga menjadwalkan penghapusan sesudah 12 jam.

### 6. Mengganti tema

Buka drawer di halaman beranda, lalu gunakan sakelar pada bagian **Settings** untuk berganti antara mode terang dan gelap.

## Status pengembangan

Pemeriksaan pada 8 November 2026 menggunakan **Flutter 3.47.4 / Dart 3.13.3** menemukan:

- Konflik `CarouselController` antara `carousel_slider 4.2.1` dan Flutter, termasuk di dalam paket carousel, sehingga kompilasi belum berhasil pada lingkungan tersebut.
- Ketidaksesuaian jumlah tab dan halaman pada Genre, serta pemilihan data yang dapat membuka detail film berbeda.
- Validasi pemesanan yang belum mewajibkan bioskop dan kursi.
- Tes widget yang masih memakai contoh counter bawaan Flutter.
- Konfigurasi release Android yang masih memerlukan izin internet pada main manifest dan signing release.

Karena itu, instruksi menjalankan aplikasi di atas merupakan alur pengembangan setelah kendala diselesaikan. Fitur **Logout** dan **Forgot Password** juga belum memiliki aksi.

Untuk memeriksa source dan menjalankan tes:

```sh
flutter analyze
flutter test
```

Pengembangan berikutnya dapat difokuskan pada kompatibilitas dependensi, perbaikan alur genre dan pemesanan, autentikasi, penyimpanan persisten, serta integrasi pembayaran.
