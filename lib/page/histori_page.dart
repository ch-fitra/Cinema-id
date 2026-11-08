import 'package:cinema_id_v1/provider/provider_tiket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Histori Pembelian Tiket'),
      ),
      body: Consumer<TiketProvider>(
        builder: (_, tiketProvider, __) {
          return ListView.builder(
            itemCount: tiketProvider.histori.length,
            itemBuilder: (context, index) {
              HistoriClass historiItem = tiketProvider.histori[index];

              return Dismissible(
                key: Key(historiItem
                    .nama), // Pastikan setiap item memiliki key yang unik
                onDismissed: (direction) {
                  tiketProvider.removeHistori(historiItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('${historiItem.nama} telah dihapus')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  height: 500,
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Struk Pembelian Tiket',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Divider(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _Content(
                                            title: "Nama Film :",
                                            body: Text(
                                              '${historiItem.nama}',
                                            ),
                                          ),
                                          _Content(
                                            title: "Nama Bioskop :",
                                            body: Text(
                                              '${historiItem.namaBioskop}',
                                            ),
                                          ),
                                          _Content(
                                            title: "Kursi Pilihan :",
                                            body: Text(
                                              '${historiItem.jumlahKursiPilihan}',
                                            ),
                                          ),
                                          _Content(
                                            title: "Waktu :",
                                            body: Text(
                                              '${DateFormat('yyyy-MM-dd').format(historiItem.tanggalTonton)}',
                                            ),
                                          ),
                                          _Content(
                                            title: "Jam :",
                                            body: Text(
                                              '${historiItem.jamTonton.format(context)}',
                                            ),
                                          ),
                                          _Content(
                                            title: "Pemberitahuan :",
                                            body: Text("Bayar Sebelum 12 Jam"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${historiItem.gambar}',
                                height: 200,
                                width: 140,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    historiItem.nama,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            14.0), // Sesuaikan ukuran font jika perlu
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size:
                                            16.0, // Sesuaikan ukuran jika perlu
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        historiItem.rating.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                                14.0), // Sesuaikan ukuran font jika perlu
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.title,
    required this.body,
    this.padding = 3.0,
  });

  final String title;
  final Widget body;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 3,
            left: padding,
            right: padding,
            bottom: 8.0,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
        Divider(),
      ],
    );
  }
}
