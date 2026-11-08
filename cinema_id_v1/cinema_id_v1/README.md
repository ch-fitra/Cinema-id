# Cinema ID - Aplikasi Flutter

Folder ini merupakan root aplikasi Flutter untuk katalog film dan simulasi pemesanan tiket Cinema ID.

Dokumentasi fitur, struktur repository, persiapan SDK, cara menjalankan aplikasi, dan masalah yang diketahui tersedia di [README utama](../../README.md). Hasil pemeriksaan kode tersedia di [laporan analisis](../../ANALISIS_PROJECT.md).

## Perintah pengembangan

Jalankan dari folder ini:

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

**Status pemeriksaan 8 November 2026:** kompilasi pada Flutter 3.47.4 terhambat konflik `CarouselController` pada `carousel_slider 4.2.1`. Perbaiki masalah tersebut sebelum menjalankan aplikasi. Tes widget juga masih memakai contoh counter bawaan Flutter.

Login, registrasi, dan pemesanan masih berupa simulasi lokal tanpa backend autentikasi atau pembayaran.
