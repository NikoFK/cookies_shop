// Mengabaikan peringatan kode yang tidak perlu terkait null
// ignore_for_file: unnecessary_null_comparison

// Mengimpor paket dan file yang diperlukan
import 'package:cookies_shop/controllers/sign-in-controller.dart'; // Mengimpor controller untuk logika sign-in.
import 'package:cookies_shop/screens/auth-ui/forget-password-screen.dart'; // Mengimpor layar lupa password.
import 'package:cookies_shop/screens/auth-ui/sign-up-screen.dart'; // Mengimpor layar sign-up.
import 'package:cookies_shop/screens/user-panel/user-main-screen.dart'; // Mengimpor layar utama pengguna.
import 'package:cookies_shop/utils/app-constant.dart'; // Mengimpor konstanta yang digunakan di seluruh aplikasi.
import 'package:firebase_auth/firebase_auth.dart'; // Mengimpor Firebase Auth untuk autentikasi.
import 'package:flutter/material.dart'; // Flutter framework UI widgets.
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'; // Paket untuk mendeteksi visibilitas keyboard.
import 'package:get/get.dart'; // Library manajemen state GetX.
import 'package:lottie/lottie.dart'; // Paket untuk menampilkan animasi Lottie.
import '../../controllers/get-user-data-controller.dart'; // Mengimpor controller untuk mendapatkan data pengguna.
import '../admin-panel/admin-main-screen.dart'; // Mengimpor layar utama admin.

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key}); // Konstruktor untuk widget layar log in.

  @override
  State<LogInScreen> createState() => _LogInScreenState(); // Membuat state untuk layar log in.
}

class _LogInScreenState extends State<LogInScreen> {
  // Menginisialisasi SignInController dan GetUserDataController menggunakan GetX untuk manajemen state
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());

  // Controller untuk input email dan password pengguna
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // KeyboardVisibilityBuilder untuk menangani perubahan UI saat keyboard muncul atau tidak
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      // Scaffold untuk struktur layar secara keseluruhan
      return Scaffold(
        appBar: AppBar(
          // Menyesuaikan app bar dengan warna tema dan ikon
          iconTheme: IconThemeData(color: AppConstant.appScendoryColor),
          title: Text(""), // Judul kosong di app bar
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // Efek bouncing saat scroll
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: Get.width * 0.4, // Mengatur lebar animasi
                    height: Get.width * 0.4, // Mengatur tinggi animasi
                    child: Lottie.asset('assets/splash-icon.json'), // Menampilkan animasi Lottie sebagai ikon splash
                  ),
                  SizedBox(
                    height: Get.height / 40, // Memberi jarak vertikal
                  ),
                  Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 24, // Mengatur ukuran teks judul
                      fontWeight: FontWeight.bold, // Mengatur teks judul dengan tebal
                      color: AppConstant.appScendoryColor, // Mengatur warna teks judul
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 30, // Memberi jarak vertikal
                  ),
                  Text(
                    "Enter your email and password",
                    style: TextStyle(
                      fontSize: 15, // Mengatur ukuran teks deskripsi
                      fontWeight: FontWeight.bold, // Mengatur teks deskripsi dengan tebal
                      color: AppConstant.appMainColor, // Mengatur warna teks deskripsi
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height / 20, // Memberi jarak vertikal
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0), // Mengatur margin horizontal
                width: Get.width, // Mengatur lebar container sesuai dengan lebar layar
                child: Padding(
                  padding: const EdgeInsets.all(10.0), // Mengatur padding di dalam container
                  child: TextFormField(
                    controller: userEmail, // Menghubungkan controller ke field teks
                    cursorColor: AppConstant.appScendoryColor, // Mengatur warna kursor teks
                    keyboardType: TextInputType.emailAddress, // Mengatur tipe keyboard sebagai email
                    decoration: InputDecoration(
                      labelText: "Email", // Label teks
                      hintText: "Enter your email", // Hint teks
                      contentPadding: EdgeInsets.only(top: 2.0, left: 8.0), // Padding konten di dalam field teks
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Mengatur radius border
                      ),
                      filled: true, // Mengatur field teks terisi dengan warna
                      fillColor: Colors.grey[200], // Mengatur warna field teks saat terisi
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstant.appScendoryColor), // Mengatur warna border saat fokus
                        borderRadius: BorderRadius.circular(10.0), // Mengatur radius border saat fokus
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!), // Mengatur warna border saat tidak fokus
                        borderRadius: BorderRadius.circular(10.0), // Mengatur radius border saat tidak fokus
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0), // Mengatur margin horizontal
                width: Get.width, // Mengatur lebar container sesuai dengan lebar layar
                child: Padding(
                  padding: const EdgeInsets.all(10.0), // Mengatur padding di dalam container
                  child: Obx(
                    // Widget TextFormField terbungkus di dalam Obx untuk observasi perubahan state
                    () => TextFormField(
                      controller: userPassword, // Menghubungkan controller ke field teks
                      obscureText: !signInController.isPasswordVisible.value, // Mengatur visibilitas teks password
                      cursorColor: AppConstant.appScendoryColor, // Mengatur warna kursor teks
                      keyboardType: TextInputType.visiblePassword, // Mengatur tipe keyboard sebagai password
                      decoration: InputDecoration(
                        labelText: "Password", // Label teks
                        hintText: "Enter Your password", // Hint teks
                        suffixIcon: GestureDetector(
                          onTap: () {
                            signInController.isPasswordVisible.toggle(); // Toggle visibilitas password
                          },
                          child: signInController.isPasswordVisible.value
                              ? Icon(Icons.visibility) // Ikon mata terbuka
                              : Icon(Icons.visibility_off), // Ikon mata tertutup
                        ),
                        contentPadding: EdgeInsets.only(top: 2.0, left: 8.0), // Padding konten di dalam field teks
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Mengatur radius border
                        ),
                        filled: true, // Mengatur field teks terisi dengan warna
                        fillColor: Colors.grey[200], // Mengatur warna field teks saat terisi
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppConstant.appScendoryColor), // Mengatur warna border saat fokus
                          borderRadius: BorderRadius.circular(10.0), // Mengatur radius border saat fokus
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!), // Mengatur warna border saat tidak fokus
                          borderRadius: BorderRadius.circular(10.0), // Mengatur radius border saat tidak fokus
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0), // Mengatur margin horizontal
                alignment: Alignment.centerRight, // Mengatur teks berada di kanan
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen()); // Navigasi ke layar lupa password
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                      color: AppConstant.appScendoryColor, // Mengatur warna teks
                      fontWeight: FontWeight.bold, // Mengatur teks dengan tebal
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 20, // Memberi jarak vertikal
              ),
              Material(
                child: Container(
                  width: Get.width / 2, // Mengatur lebar tombol
                  height: Get.height / 18, // Mengatur tinggi tombol
                  decoration: BoxDecoration(
                    color: AppConstant.appScendoryColor, // Mengatur warna background tombol
                    borderRadius: BorderRadius.circular(20.0), // Mengatur radius border tombol
                  ),
                  child: TextButton(
                    child: Text(
                      "LOG IN",
                      style: TextStyle(color: AppConstant.appTextColor), // Mengatur warna teks tombol
                    ),
                    onPressed: () async {
                      String email = userEmail.text.trim(); // Mengambil teks email dan menghilangkan spasi berlebih
                      String password = userPassword.text.trim(); // Mengambil teks password dan menghilangkan spasi berlebih

                      if (email.isEmpty || password.isEmpty) {
                       

 // Menampilkan snackbar error jika email atau password kosong
                        Get.snackbar(
                          "Error", // Judul snackbar
                          "Please enter all details", // Pesan snackbar
                          snackPosition: SnackPosition.BOTTOM, // Posisi snackbar di bawah
                          backgroundColor: AppConstant.appScendoryColor, // Warna background snackbar
                          colorText: AppConstant.appTextColor, // Warna teks snackbar
                        );
                      } else {
                        // Memanggil metode sign-in dari controller
                        UserCredential? userCredential = await signInController.signInMethod(email, password);

                        // Mendapatkan data pengguna
                        var userData = await getUserDataController.getUserData(userCredential!.user!.uid);

                        if (userCredential != null) {
                          // Jika email pengguna sudah diverifikasi
                          if (userCredential.user!.emailVerified) {
                            // Jika pengguna adalah admin
                            if (userData[0]['isAdmin'] == true) {
                              Get.snackbar(
                                "Success Admin Login", // Judul snackbar
                                "Login Successfully!", // Pesan snackbar
                                snackPosition: SnackPosition.BOTTOM, // Posisi snackbar di bawah
                                backgroundColor: AppConstant.appScendoryColor, // Warna background snackbar
                                colorText: AppConstant.appTextColor, // Warna teks snackbar
                              );
                              Get.offAll(() => AdminMainScreen()); // Navigasi ke layar utama admin
                            } else {
                              Get.offAll(() => MainScreen()); // Navigasi ke layar utama pengguna
                              Get.snackbar(
                                "Success User Login", // Judul snackbar
                                "Login Successfully!", // Pesan snackbar
                                snackPosition: SnackPosition.BOTTOM, // Posisi snackbar di bawah
                                backgroundColor: AppConstant.appScendoryColor, // Warna background snackbar
                                colorText: AppConstant.appTextColor, // Warna teks snackbar
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error", // Judul snackbar
                              "Please verify your email before login", // Pesan snackbar
                              snackPosition: SnackPosition.BOTTOM, // Posisi snackbar di bawah
                              backgroundColor: AppConstant.appScendoryColor, // Warna background snackbar
                              colorText: AppConstant.appTextColor, // Warna teks snackbar
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Error", // Judul snackbar
                            "Please try again", // Pesan snackbar
                            snackPosition: SnackPosition.BOTTOM, // Posisi snackbar di bawah
                            backgroundColor: AppConstant.appScendoryColor, // Warna background snackbar
                            colorText: AppConstant.appTextColor, // Warna teks snackbar
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 20, // Memberi jarak vertikal
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Mengatur posisi elemen secara horizontal di tengah
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppConstant.appScendoryColor), // Mengatur warna teks
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(() => SignUpScreen()), // Navigasi ke layar sign-up
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppConstant.appScendoryColor, // Mengatur warna teks
                        fontWeight: FontWeight.bold, // Mengatur teks dengan tebal
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}