import 'package:cinema_id_v1/components/banner.dart';
import 'package:cinema_id_v1/components/rekomendasi.dart';
import 'package:cinema_id_v1/page/pencarian.dart';
import 'package:cinema_id_v1/provider/provider_dark_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Pastikan path ini sesuai dengan struktur proyek Anda

class Home extends StatelessWidget {
  final String title;
  const Home({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cinema ID"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MovieSearchDelegate());
              },
              icon: Icon(Icons.search)),
          _menus()
        ],
      ),
      drawer: _buildDrawer(context, title),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              MovieBanner(),
              padding("Rekomendasi"),

              Rekomendasi() // Tambahkan widget MovieBanner di sini
            ],
          ),
        ),
      ),
    );
  }

  Widget padding(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, String nama) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.amber,
              ),
            ),
            accountEmail: Text('${nama}@gmail.com'),
            accountName: Text(
              nama,
              style: TextStyle(fontSize: 24.0),
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
          ),
          _buildDrawerItem(
            trailing: CupertinoSwitch(
                value: Provider.of<DarkMode>(context, listen: false).isDarkMode,
                onChanged: (value) {
                  Provider.of<DarkMode>(context, listen: false)
                      .toggleDarkMode();
                }),
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to Settings page or handle tap
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required CupertinoSwitch trailing,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _menus() {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("About"),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Card(
                    child: Container(
                      height: 460,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _Content(
                            title: "About",
                            body: Text(
                              "Inovasi terbaru dalam dunia hiburan sinematik. Nikmati kenyamanan memesan tiket film favoritmu secara cepat dan mudah. Temukan pengalaman menonton yang tak terlupakan dengan aplikasi ini. Jelajahi berbagai pilihan film dan jadwal tayang terbaru hanya dengan sentuhan jari. Rasakan kemudahan dan keamanan dalam setiap transaksi tiketmu. Aplikasi ini adalah kunci untuk pengalaman sinema yang lebih baik dan terhubung dengan dunia film.",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          _Content(
                              title: "Kamu Bisa",
                              body: Row(
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.tv,
                                        size: 100,
                                      ),
                                      Text("Tonton Film")
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.money,
                                        size: 100,
                                      ),
                                      Text("Beli Tiket")
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        )
      ],
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
