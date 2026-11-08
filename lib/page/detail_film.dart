import 'package:cinema_id_v1/provider/provider_tiket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  final String image;
  final String title;
  final String jadwalTayang;
  final String overview;
  final double rating;

  const Details({
    Key? key,
    required this.image,
    required this.title,
    required this.jadwalTayang,
    required this.overview,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Tooltip(
        message:
            'Lakukan Pembelian', // The text you want to display in the tooltip
        child: FloatingActionButton(
          foregroundColor: Theme.of(context).colorScheme.background,
          onPressed: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              context: context,
              builder: (BuildContext context) => isi(context),
            );
          },
          child: Icon(Icons.monetization_on),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500$image',
                  height: 280, // Ubah tinggi gambar sesuai kebutuhan
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  bottom: 8,
                  left: 8,
                ),
                InkWell(
                  onTap: () {
                    Provider.of<TiketProvider>(context, listen: false)
                        .resetPilihan();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0, top: 35),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Theme.of(context).colorScheme.background,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Content(
                    title: 'Release Date',
                    body: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          size: 25.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          jadwalTayang,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _Content(
                    title: 'Rating',
                    body: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _Content(
                    title: "Overview",
                    body: Text(
                      overview,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget isi(BuildContext context) {
    final tiketProvider = Provider.of<TiketProvider>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Content(
              title: "Pilih Bioskop",
              body: Column(
                children: tiketProvider.namaBioskop
                    .map(
                      (nama) => RadioListTile(
                        title: Text(nama),
                        value: nama,
                        groupValue: tiketProvider.selectedBioskop,
                        onChanged: (value) {
                          tiketProvider.selectOption(value.toString());
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            _Content(
              title: "Pilih Kursi",
              body: Wrap(
                spacing: 8.0,
                children: tiketProvider.kursi
                    .map(
                      (kursi) => Chip(
                        label: Text(kursi),
                        backgroundColor:
                            tiketProvider.selectedKursi.contains(kursi)
                                ? Colors.blue
                                : Colors.grey,
                        labelStyle: TextStyle(
                          color: tiketProvider.selectedKursi.contains(kursi)
                              ? Colors.white
                              : Colors.black,
                        ),
                        onDeleted: () {
                          tiketProvider.checkBox(kursi);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            Consumer<TiketProvider>(
              builder: (_, tiketProvider, __) {
                double totalHarga = tiketProvider.hitungTotalHarga(
                  tiketProvider.selectedBioskop,
                  tiketProvider.selectedKursi,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Content(
                        title: "Total Harga : ",
                        body: Text(totalHarga.toStringAsFixed(0))),
                    _Content(
                        title: "Bioskop :",
                        body: Text(tiketProvider.selectedBioskop)),
                    _Content(
                        title: "Bangku :",
                        body: Text(tiketProvider.selectedKursi.join(', '))),
                    _Content(
                      title: "Pilih Date :",
                      body: ElevatedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            tiketProvider.selectTanggal(pickedDate);
                          }
                        },
                        child: Text(
                          tiketProvider.selectedTanggal != null
                              ? "${tiketProvider.selectedTanggal!.toLocal()}"
                                  .split(' ')[0]
                              : "Pilih Tanggal",
                        ),
                      ),
                    ),
                    _Content(
                      title: "Pilih Jam Tonton :",
                      body: ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            tiketProvider.selectJam(pickedTime);
                          }
                        },
                        child: Text(
                          tiketProvider.selectedJam != null
                              ? "${tiketProvider.selectedJam!.format(context)}"
                              : "Pilih Jam",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.background,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () {
                        if (tiketProvider.selectedTanggal != null &&
                            tiketProvider.selectedJam != null) {
                          // Create HistoriClass object from selected data
                          HistoriClass historiClass = HistoriClass(
                            nama: title,
                            totalHarga: totalHarga,
                            rating: rating,
                            namaBioskop: tiketProvider.selectedBioskop,
                            jumlahKursiPilihan: tiketProvider.selectedKursi,
                            gambar: image,
                            tanggalTonton: tiketProvider.selectedTanggal!,
                            jamTonton: tiketProvider.selectedJam!,
                          );

                          // Add history using provider
                          tiketProvider.tambahHistori(historiClass);

                          // Reset selected seats after purchase
                          tiketProvider.resetPilihan();

                          tiketProvider.aturTimer(historiClass);
                          Navigator.pop(context);
                        } else {
                          // Show an error message if date or time is not selected
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Silakan pilih tanggal dan jam tonton"),
                            ),
                          );
                        }
                      },
                      child: Text('Buy Now'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
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
            top: 12,
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
      ],
    );
  }
}
