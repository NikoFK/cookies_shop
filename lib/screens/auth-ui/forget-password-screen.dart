// Mengimpor paket dan file yang diperlukan
import 'package:cookies_shop/controllers/forget-password-controller.dart'; // Mengimpor controller untuk logika lupa password.
import 'package:cookies_shop/utils/app-constant.dart'; // Mengimpor konstanta yang digunakan di seluruh aplikasi.
import 'package:flutter/material.dart'; // Flutter framework UI widgets.
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'; // Paket untuk mendeteksi visibilitas keyboard.
import 'package:get/get.dart'; // Library manajemen state GetX.
import 'package:lottie/lottie.dart'; // Paket untuk menampilkan animasi Lottie.

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key}); // Konstruktor untuk widget layar lupa password.

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState(); // Membuat state untuk layar lupa password.
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  // Menginisialisasi ForgetPasswordController menggunakan GetX untuk manajemen state
  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController()); // Instance dari ForgetPasswordController.

  // Controller untuk input email pengguna
  TextEditingController userEmail = TextEditingController(); // Controller untuk input email pengguna.

  @override
  Widget build(BuildContext context) {
    // KeyboardVisibilityBuilder untuk menangani perubahan UI saat keyboard muncul atau tidak
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      // Scaffold untuk struktur layar secara keseluruhan
      return Scaffold(
        appBar: AppBar(
          // Menyesuaikan app bar dengan warna tema dan judul
          iconTheme: IconThemeData(color: AppConstant.appScendoryColor), // Mengatur warna ikon app bar.
          centerTitle: true, // Mengatur judul app bar berada di tengah.
          title: Text(
            "Forget Password",
            style: TextStyle(
              fontWeight: FontWeight.bold, // Mengatur teks judul dengan tebal.
              color: AppConstant.appScendoryColor, // Mengatur warna teks judul.
              fontSize: 20, // Mengatur ukuran teks judul.
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // Efek bouncing saat scroll
          child: Container(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: Get.width * 0.4, // Mengatur lebar animasi.
                      height: Get.width * 0.4, // Mengatur tinggi animasi.
                      child: Lottie.asset('assets/splash-icon.json'), // Menampilkan animasi Lottie sebagai ikon splash.
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height / 20, // Memberi jarak vertikal.
                ),
                Container(
                  alignment: Alignment.center, // Mengatur posisi teks di tengah.
                  child: Column(
                    children: [
                      Text(
                        "Masukkan alamat email untuk mendapatkan tautan reset password",
                        style: TextStyle(
                          color: AppConstant.appMainColor, // Mengatur warna teks.
                          fontWeight: FontWeight.bold, // Mengatur teks dengan tebal.
                          fontSize: 12, // Mengatur ukuran teks.
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height / 20, // Memberi jarak vertikal.
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0), // Mengatur margin horizontal.
                  width: Get.width, // Mengatur lebar container sesuai dengan lebar layar.
                  child: Padding(
                    padding: const EdgeInsets.all(10.0), // Mengatur padding di dalam container.
                    child: TextFormField(
                      // Field teks untuk memasukkan email
                      controller: userEmail, // Menghubungkan controller ke field teks.
                      cursorColor: AppConstant.appScendoryColor, // Mengatur warna kursor teks.
                      keyboardType: TextInputType.emailAddress, // Mengatur tipe keyboard sebagai email.
                      decoration: InputDecoration(
                        labelText: "Email", // Label teks.
                        hintText: "Masukkan email Anda", // Hint teks.
                        floatingLabelBehavior: FloatingLabelBehavior.auto, // Label teks akan bergerak naik saat input aktif.
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0), // Padding konten di dalam field teks.
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Mengatur radius border.
                        ),
                        filled: true, // Mengatur field teks terisi dengan warna.
                        fillColor: Colors.grey[200], // Mengatur warna field teks saat terisi.
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppConstant.appScendoryColor), // Mengatur warna border saat fokus.
                          borderRadius: BorderRadius.circular(10.0), // Mengatur radius border saat fokus.
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Mengatur warna border saat tidak fokus.
                          borderRadius: BorderRadius.circular(10.0), // Mengatur radius border saat tidak fokus.
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20, // Memberi jarak vertikal.
                ),
                Material(
                  child: Container(
                    width: Get.width / 2, // Mengatur lebar tombol.
                    height: Get.height / 18, // Mengatur tinggi tombol.
                    decoration: BoxDecoration(
                      color: AppConstant.appScendoryColor, // Mengatur warna background tombol.
                      borderRadius: BorderRadius.circular(20.0), // Mengatur radius border tombol.
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // Aksi tombol untuk memulai proses reset password
                        String email = userEmail.text.trim(); // Mengambil teks email dan menghilangkan spasi berlebih.

                        if (email.isEmpty) {
                          // Menampilkan snackbar error jika email kosong
                          Get.snackbar(
                            "Error", // Judul snackbar.
                            "Silakan masukkan semua detail", // Pesan snackbar.
                            snackPosition: SnackPosition.BOTTOM, // Posisi snackbar di bawah.
                            backgroundColor: AppConstant.appScendoryColor, // Warna background snackbar.
                            colorText: AppConstant.appTextColor, // Warna teks snackbar.
                          );
                        } else {
                          // Memanggil metode forget password dari controller
                          forgetPasswordController.ForgetPasswordMethod(email); // Memanggil metode untuk mengirim tautan reset password.
                        }
                      },
                      child: Text(
                        "Forget", // Teks pada tombol.
                        style: TextStyle(color: AppConstant.appTextColor), // Mengatur warna teks tombol.
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20, // Memberi jarak vertikal.
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}