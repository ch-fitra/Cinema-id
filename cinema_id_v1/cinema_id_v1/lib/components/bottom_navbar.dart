import 'package:cinema_id_v1/page/genre.dart';
import 'package:cinema_id_v1/page/histori_page.dart';
import 'package:cinema_id_v1/page/home.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final String nama;

  const BottomNavbar({Key? key, required this.nama}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _index = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      Home(title: widget.nama),
      HistoriPage(),
      Genre(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Purchase History"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Genre"),
        ],
      ),
    );
  }
}
