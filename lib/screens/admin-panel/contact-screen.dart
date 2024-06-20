// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// Mengimpor paket-paket yang diperlukan
import 'package:cookies_shop/screens/admin-panel/contact-aisma-screen.dart';
import 'package:cookies_shop/screens/admin-panel/contact-niko-screen.dart';
import 'package:cookies_shop/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Definisi kelas ContactScreen yang merupakan StatefulWidget
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key}); // Konstruktor untuk widget

  @override
  State<ContactScreen> createState() =>
      _ContactScreenState(); // Mengembalikan state dari widget
}

// State untuk ContactScreen
class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: AppConstant.appScendoryColor), // Warna ikon pada AppBar
        centerTitle: true, // Mengatur judul di tengah AppBar
        title: Text(
          "Contact Developer", // Judul AppBar
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppConstant.appScendoryColor,
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // Efek bouncing pada scroll
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 40, // Memberikan tinggi kosong
              ),
              Container(
                  alignment: Alignment.center, // Menyelaraskan konten di tengah
                  child: Column(
                    children: [
                      Text(
                        "Developer Cookies Shop", // Teks judul
                        style: TextStyle(
                            color: AppConstant.appMainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 20, // Memberikan tinggi kosong
                      ),
                    ],
                  )),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/aisma.jpg'), // Menampilkan gambar avatar
                  ),
                  title: Text(
                    "Aisma Nurlaili", // Nama developer
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppConstant.appScendoryColor,
                        fontSize: 18),
                  ),
                  subtitle: Text('22082010083'), // NIM developer
                  onTap: () {
                    Get.to(() =>
                        ProfileAismaScreen()); // Navigasi ke layar profil Aisma
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/niko.jpg'), // Menampilkan gambar avatar
                  ),
                  title: Text(
                    'Niko Fauza Kurniawan', // Nama developer
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppConstant.appScendoryColor,
                        fontSize: 18),
                  ),
                  subtitle: Text('22082010069'), // NIM developer
                  onTap: () {
                    Get.to(() =>
                        ProfileNikoScreen()); // Navigasi ke layar profil Niko
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
