# Cinema ID

Prototipe aplikasi katalog film dan simulasi pemesanan tiket menggunakan Flutter dan Provider.

## Isi repository

| Lokasi | Isi |
| --- | --- |
| `cinema_id_v1/cinema_id_v1/` | Source proyek Flutter, termasuk konfigurasi platform |
| `cinema_id.apk` | APK yang sudah tersedia; bukan hasil build pada audit ini |
| `cinema_id_v1.zip` | Arsip proyek asli yang dipertahankan |
| `0706.mp4` | Video yang disertakan, durasi container sekitar 7 menit 16 detik |
| `laporan_tugas.txt` | Catatan komponen antarmuka untuk tugas |
| `ANALISIS_PROJECT.md` | Hasil audit source, konfigurasi, pengujian, dan artefak |

## Mengambil seluruh berkas

Video, APK, dan ZIP disimpan menggunakan Git LFS. Pasang Git LFS terlebih dahulu, kemudian jalankan:

```sh
git lfs install
git clone https://github.com/ch-fitra/Cinema-id.git
cd Cinema-id
git lfs pull
```

## Menyiapkan aplikasi

```sh
cd cinema_id_v1/cinema_id_v1
flutter pub get
flutter analyze
flutter test
flutter run
```

**Status audit 8 November 2026:** aplikasi belum berhasil dikompilasi dengan Flutter 3.47.4 karena konflik `CarouselController` pada `carousel_slider 4.2.1`. Langkah di atas adalah alur pengembangan, bukan jaminan build berhasil. Lihat laporan analisis sebelum melakukan perubahan.

Login, registrasi, dan pembelian masih berupa simulasi lokal. Belum ada backend autentikasi, database transaksi, atau integrasi pembayaran.

Cache, keluaran build sementara, konfigurasi IDE, dan konfigurasi mesin lokal dikecualikan dari source yang dilacak. APK, ZIP, dan video asli tetap disertakan sebagai artefak tugas. ZIP asli masih dapat memuat cache dan konfigurasi lokal lama.
