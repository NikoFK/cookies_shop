// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers

// Mengimpor paket-paket yang diperlukan
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookies_shop/controllers/get-user-data-controller.dart';
import 'package:cookies_shop/controllers/sign-in-controller.dart';
import 'package:cookies_shop/models/user-model.dart';
import 'package:cookies_shop/screens/admin-panel/contact-screen.dart';
import 'package:cookies_shop/screens/auth-ui/log-in-screen.dart';
import 'package:cookies_shop/screens/user-panel/all-categories-screen.dart';
import 'package:cookies_shop/screens/user-panel/all-orders-screen.dart';
import 'package:cookies_shop/screens/user-panel/all-products-screen.dart';
import 'package:cookies_shop/screens/user-panel/profile-screen.dart';
import 'package:cookies_shop/screens/user-panel/user-main-screen.dart';
import 'package:cookies_shop/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Definisi kelas DrawerWidget yang merupakan StatefulWidget
class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key}); // Konstruktor untuk widget

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState(); // Mengembalikan state dari widget
}

// State untuk DrawerWidget
class _DrawerWidgetState extends State<DrawerWidget> {
  User? user = FirebaseAuth.instance.currentUser; // Mendapatkan pengguna yang sedang login
  final SignInController signInController = Get.put(SignInController()); // Inisialisasi SignInController
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController()); // Inisialisasi GetUserDataController

  String? userName; // Menyimpan nama pengguna
  String? firstLetter; // Menyimpan huruf pertama dari nama pengguna
  UserModel? userModel; // Menyimpan model pengguna

  // Fungsi untuk mendapatkan data pengguna dari Firestore
  Future<void> getUserData() async {
    if (user != null) { // Jika ada pengguna yang sedang login
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid.toString())
          .get(); // Mengambil data pengguna dari Firestore berdasarkan UID

      userModel = UserModel.fromMap(snapshot.data() as Map<String, dynamic>); // Mengubah data snapshot menjadi UserModel
      userName = userModel?.username; // Menyimpan nama pengguna
      firstLetter = userModel?.username[0]; // Menyimpan huruf pertama dari nama pengguna
      setState(() {}); // Memperbarui UI dengan data pengguna baru
    }
  }

  // Memanggil getUserData saat widget diinisialisasi
  @override
  void initState() {
    super.initState(); // Memanggil inisialisasi dari superclass

    if (user != null) { // Jika ada pengguna yang sedang login
      getUserData(); // Memanggil metode getUserData
    }
  }

  // Membangun UI drawer
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25), // Memberikan padding di bagian atas drawer
      child: Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        )), // Membuat sudut drawer melengkung
        child: Wrap(
          runSpacing: 10, // Memberikan jarak antar widget dalam Wrap
          children: [
            // Menampilkan informasi pengguna jika login, atau "Guest" jika tidak login
            user != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0), // Padding untuk ListTile
                    child: ListTile(
                      onTap: () {
                        if (userModel != null) { // Jika userModel tidak null
                          Get.back(); // Kembali ke layar sebelumnya
                          Get.to(() => ProfileScreen(userModel: userModel!)); // Navigasi ke layar profil dengan userModel
                        }
                      },
                      titleAlignment: ListTileTitleAlignment.center, // Mengatur alignment judul
                      title: Text(
                        userName ?? '', // Menampilkan nama pengguna atau string kosong jika userName null
                        style: TextStyle(color: AppConstant.appTextColor), // Mengatur gaya teks
                      ),
                      subtitle: Text(
                        AppConstant.appVersion, // Menampilkan versi aplikasi
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: CircleAvatar(
                        radius: 22.0, // Ukuran avatar
                        backgroundColor: AppConstant.appMainColor, // Warna latar belakang avatar
                        child: Text(
                          firstLetter ?? '', // Menampilkan huruf pertama nama pengguna atau string kosong jika firstLetter null
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0), // Padding untuk ListTile jika pengguna tidak login
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center, // Mengatur alignment judul
                      title: Text(
                        "Guest", // Menampilkan "Guest" jika pengguna tidak login
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      subtitle: Text(
                        AppConstant.appVersion, // Menampilkan versi aplikasi
                        style: TextStyle(color: Colors.grey),
                      ),
                      leading: CircleAvatar(
                        radius: 22.0, // Ukuran avatar
                        backgroundColor: AppConstant.appMainColor, // Warna latar belakang avatar
                        child: Text(
                          "G", // Menampilkan "G" untuk Guest
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      ),
                    ),
                  ),
            Divider(
              indent: 10.0, // Indentasi divider dari kiri
              endIndent: 10.0, // Indentasi divider dari kanan
              thickness: 1.5, // Ketebalan divider
              color: Colors.grey, // Warna divider
            ),
            // Daftar menu dalam drawer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding untuk ListTile
              child: ListTile(
                onTap: () {
                  Get.offAll(() => MainScreen()); // Navigasi ke layar utama
                },
                title: Text(
                  'Home', // Menampilkan "Home"
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.home_outlined, // Ikon untuk Home
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding untuk ListTile
              child: ListTile(
                onTap: () {
                  Get.to(() => AllOrdersScreen()); // Navigasi ke layar semua pesanan
                },
                title: Text(
                  'Orders', // Menampilkan "Orders"
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.shopping_bag, // Ikon untuk Orders
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding untuk ListTile
              child: ListTile(
                onTap: () {
                  Get.back(); // Kembali ke layar sebelumnya
                  Get.to(() => AllProductsScreen()); // Navigasi ke layar semua produk
                },
                title: Text(
                  'Products', // Menampilkan "Products"
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.production_quantity_limits, // Ikon untuk Products
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding untuk ListTile
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center, // Mengatur alignment judul
                onTap: () async {
                  Get.back(); // Kembali ke layar sebelumnya
                  Get.to(() => AllCategoriesScreen()); // Navigasi ke layar semua kategori
                },
                title: Text(
                  'Categories', // Menampilkan "Categories"
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.category, // Ikon untuk Categories
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding untuk ListTile
              child: ListTile(
                onTap: () {
                  Get.to(() => ContactScreen()); // Navigasi ke layar kontak
                },
                title: Text(
                  'Contact', // Menampilkan "Contact"
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.help, // Ikon untuk Contact
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding untuk ListTile
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center, // Mengatur alignment judul
                title: Text(
                  "Logout", // Menampilkan "Logout"
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                leading: Icon(
                  Icons.logout, // Ikon untuk Logout
                  color: AppConstant.appTextColor,
                ),
                onTap: () {
                  Get.defaultDialog(
                    title: "Confirm Logout", // Judul dialog konfirmasi logout
                    middleText: "Are you sure you want to logout?", // Teks tengah dialog konfirmasi logout
                    textCancel: "No", // Teks tombol batal
                    textConfirm: "Yes", // Teks tombol konfirmasi
                    confirmTextColor: Colors.white, // Warna teks tombol konfirmasi
                    buttonColor: Colors.red, // Warna tombol konfirmasi
                    cancelTextColor: Colors.black, // Warna teks tombol batal
                    onConfirm: () {
                      FirebaseAuth.instance.signOut(); // Logout dari Firebase
                      Get.offAll(() => LogInScreen()); // Navigasi ke layar login
                    },
                  );
                },
              ),
            ),
          ],
        ),
        width: Get.width - 80.0, // Lebar drawer
        backgroundColor: AppConstant.appScendoryColor, // Warna latar belakang drawer
      ),
    );
  }
}
