// Mengabaikan peringatan kode terkait nama file, variabel tidak terpakai, dan menghindari penggunaan print
// ignore_for_file: file_names, unused_local_variable, unused_field, avoid_print

// Mengimpor paket yang diperlukan
import 'package:cloud_firestore/cloud_firestore.dart'; // Menggunakan Cloud Firestore sebagai basis data
import 'package:cookies_shop/models/user-model.dart'; // Mengimpor model pengguna
import 'package:cookies_shop/screens/user-panel/user-main-screen.dart'; // Mengimpor layar utama pengguna
import 'package:firebase_auth/firebase_auth.dart'; // Mengimpor paket autentikasi Firebase
import 'package:flutter_easyloading/flutter_easyloading.dart'; // Mengimpor paket untuk menampilkan loading indicator
import 'package:get/get.dart'; // Mengimpor paket GetX untuk manajemen state
import 'package:google_sign_in/google_sign_in.dart'; // Mengimpor paket Google Sign-In

// Kelas controller untuk menangani sign-in dengan Google
class GoogleSignInController extends GetxController {
  // Inisialisasi objek GoogleSignIn dan FirebaseAuth
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Metode untuk sign-in dengan Google
  Future<void> signInWithGoogle() async {
    try {
      // Memulai proses sign-in dengan Google
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Menampilkan loading indicator
        EasyLoading.show(status: "Please wait..");

        // Mendapatkan autentikasi dari akun Google
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Membuat kredensial untuk sign-in dengan Firebase
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign-in dengan kredensial di Firebase
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        // Mendapatkan pengguna yang sign-in
        final User? user = userCredential.user;

        if (user != null) {
          // Membuat instance UserModel dengan informasi pengguna
          UserModel userModel = UserModel(
            uId: user.uid,
            username: user.displayName.toString(),
            email: user.email.toString(),
            phone: user.phoneNumber.toString(),
            userImg: user.photoURL.toString(),
            country: '',
            userAddress: '',
            street: '',
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
            city: '',
          );

          // Menyimpan data pengguna ke Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userModel.toMap());

          // Menghilangkan loading indicator
          EasyLoading.dismiss();

          // Mengarahkan pengguna ke layar utama
          Get.offAll(() => const MainScreen());
        }
      }
    } catch (e) {
      // Menghilangkan loading indicator jika terjadi kesalahan
      EasyLoading.dismiss();
      // Mencetak kesalahan
      print("error $e");
    }
  }
}
