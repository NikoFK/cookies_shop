// Mengabaikan berbagai peringatan dan saran terkait kode
// ignore_for_file: file_names, sort_child_properties_last, prefer_const_constructors, unused_local_variable, must_be_immutable, avoid_print, unnecessary_string_interpolations, deprecated_member_use, unused_element, unnecessary_null_comparison, unused_field

// Mengimpor paket yang diperlukan
import 'package:cloud_firestore/cloud_firestore.dart'; // Untuk akses Firebase Firestore
import 'package:cookies_shop/controllers/get-user-data-controller.dart'; // Kontroller untuk mengambil data pengguna
import 'package:cookies_shop/controllers/sign-in-controller.dart'; // Kontroller untuk proses sign in
import 'package:cookies_shop/models/user-model.dart'; // Model data pengguna
import 'package:cookies_shop/screens/admin-panel/admin-all-categories-screen.dart'; // Halaman kategori admin
import 'package:cookies_shop/screens/admin-panel/admin-all-orders-screen.dart'; // Halaman pesanan admin
import 'package:cookies_shop/screens/admin-panel/admin-all-products-screen.dart'; // Halaman produk admin
import 'package:cookies_shop/screens/admin-panel/admin-main-screen.dart'; // Halaman utama admin
import 'package:cookies_shop/screens/admin-panel/contact-screen.dart'; // Halaman kontak
import 'package:cookies_shop/screens/auth-ui/log-in-screen.dart'; // Halaman login
import 'package:cookies_shop/screens/admin-panel/all-users-screen.dart'; // Halaman semua pengguna admin
import 'package:cookies_shop/screens/user-panel/profile-screen.dart'; // Halaman profil pengguna
import 'package:cookies_shop/utils/app-constant.dart'; // Konstanta aplikasi
import 'package:firebase_auth/firebase_auth.dart'; // Autentikasi Firebase
import 'package:flutter/material.dart'; // Paket UI Flutter
import 'package:get/get.dart'; // Paket GetX untuk state management dan routing

// Kelas utama untuk widget drawer admin
class AdminDrawerWidget extends StatefulWidget {
  const AdminDrawerWidget({super.key}); // Konstruktor untuk widget

  @override
  State<AdminDrawerWidget> createState() => _AdminDrawerWidgetState(); // Mengembalikan state dari widget
}

// State untuk widget drawer admin
class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
  // Mendapatkan instance pengguna yang sedang login
  User? user = FirebaseAuth.instance.currentUser; // Mendapatkan pengguna yang sedang login dari Firebase
  final SignInController signInController = Get.put(SignInController()); // Inisialisasi SignInController
  final GetUserDataController getUserDataController = Get.put(GetUserDataController()); // Inisialisasi GetUserDataController

  String? userName; // Menyimpan nama pengguna
  String? firstLetter; // Menyimpan huruf pertama dari nama pengguna
  UserModel? userModel; // Menyimpan model pengguna

  // Mendapatkan data pengguna dari Firestore
  Future<dynamic> getUserData() async {
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0), // Padding untuk ListTile
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0), // Padding untuk ListTile jika pengguna tidak login
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
                  Get.offAll(() => AdminMainScreen()); // Navigasi ke layar utama admin
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
                  Get.to(() => AllUsersScreen()); // Navigasi ke layar semua pengguna admin
                },
                title: Text(
                  'Users', // Menampilkan "Users"
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.person, // Ikon untuk Users
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding untuk ListTile
              child: ListTile(
                onTap: () {
                  Get.to(() => AdminAllOrdersScreen()); // Navigasi ke layar semua pesanan admin
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
                  Get.to(() => AdminAllProductsScreen()); // Navigasi ke layar semua produk admin
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
                  Get.to(() => AdminAllCategoriesScreen()); // Navigasi ke layar semua kategori admin
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
                  Get.back(); // Kembali ke layar sebelumnya
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
