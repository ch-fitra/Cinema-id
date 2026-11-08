import 'dart:async';

import 'package:flutter/material.dart';

class HistoriClass {
  String nama;
  double totalHarga;
  double rating;
  String namaBioskop;
  List<String> jumlahKursiPilihan;
  String gambar;
  DateTime tanggalTonton;
  TimeOfDay jamTonton;

  HistoriClass({
    required this.nama,
    required this.totalHarga,
    required this.rating,
    required this.gambar,
    required this.namaBioskop,
    required this.jumlahKursiPilihan,
    required this.tanggalTonton,
    required this.jamTonton,
  });
}

class TiketProvider extends ChangeNotifier {
  List<String> namaBioskop = [
    "Bioskop 1",
    "Bioskop 2",
    "Bioskop 3",
  ];
  List<String> kursi = [
    "Bangku 1",
    "Bangku 2",
    "Bangku 3",
    "Bangku 4",
    "Bangku 5"
  ];

  List<HistoriClass> histori = [];

  String selectedBioskop = ""; // Untuk menyimpan pilihan bioskop
  List<String> selectedKursi = []; // Untuk menyimpan kursi yang dipilih
  DateTime? selectedTanggal;
  TimeOfDay? selectedJam;

  // Metode untuk memilih pilihan bioskop
  void selectOption(String bioskop) {
    selectedBioskop = bioskop;
    notifyListeners(); // Panggil notifyListeners() setelah mengubah state
  }

  // Metode untuk memeriksa kotak centang pada kursi
  void checkBox(String kursi) {
    if (selectedKursi.contains(kursi)) {
      selectedKursi.remove(kursi);
    } else {
      selectedKursi.add(kursi);
    }
    notifyListeners(); // Panggil notifyListeners() setelah mengubah state
  }

  // Metode untuk memilih tanggal tonton
  void selectTanggal(DateTime tanggal) {
    selectedTanggal = tanggal;
    notifyListeners();
  }

  // Metode untuk memilih jam tonton
  void selectJam(TimeOfDay jam) {
    selectedJam = jam;
    notifyListeners();
  }

  void aturTimer(HistoriClass historiClass) {
    Future.delayed(Duration(hours: 12), () {
      removeHistori(historiClass);
      notifyListeners();
    });
  }

  // Metode untuk menambahkan riwayat pembelian
  void tambahHistori(HistoriClass historiClass) {
    histori.add(historiClass);
    aturTimer(historiClass);
    notifyListeners();
  }

  void removeHistori(HistoriClass historiClass) {
    histori.remove(historiClass);
    notifyListeners();
  }

  // Metode untuk menghitung total harga berdasarkan bioskop yang dipilih
  double hitungTotalHarga(String namaBioskop, List<String> jumlahKursiPilihan) {
    double hargaPerKursi = 0.0;

    // Tentukan harga per kursi berdasarkan nama bioskop
    if (namaBioskop == "Bioskop 1") {
      hargaPerKursi = 20000;
    } else if (namaBioskop == "Bioskop 2") {
      hargaPerKursi = 15000;
    } else if (namaBioskop == "Bioskop 3") {
      hargaPerKursi = 35000;
    }

    // Hitung total harga berdasarkan jumlah kursi yang dipilih
    double totalHarga = hargaPerKursi * jumlahKursiPilihan.length;
    return totalHarga;
  }

  // Metode untuk mereset pilihan bioskop dan kursi
  void resetPilihan() {
    selectedBioskop = "";
    selectedKursi = [];
    selectedTanggal = null;
    selectedJam = null;

    notifyListeners();
  }
}
