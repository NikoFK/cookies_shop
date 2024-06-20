// Mengabaikan peringatan kode terkait nama file
// ignore_for_file: file_names

// Definisi kelas UserModel
class UserModel {
  // Properti-properti kelas
  final String uId; // ID unik untuk pengguna
  final String username; // Nama pengguna
  final String email; // Email pengguna
  final String phone; // Nomor telepon pengguna
  final String userImg; // URL gambar profil pengguna
  final String country; // Negara pengguna
  final String userAddress; // Alamat lengkap pengguna
  final String street; // Nama jalan pengguna
  final bool isAdmin; // Status apakah pengguna adalah admin
  final bool isActive; // Status apakah akun pengguna aktif
  final dynamic createdOn; // Waktu pembuatan akun pengguna, tipe dynamic karena bisa berupa berbagai jenis data
  final String city; // Kota tempat tinggal pengguna

  // Konstruktor kelas dengan parameter wajib untuk setiap properti
  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.userImg,
    required this.country,
    required this.userAddress,
    required this.street,
    required this.isAdmin,
    required this.isActive,
    required this.createdOn,
    required this.city,
  });

  // Metode untuk mengonversi objek UserModel menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'uId': uId, // Menyimpan ID pengguna
      'username': username, // Menyimpan nama pengguna
      'email': email, // Menyimpan email pengguna
      'phone': phone, // Menyimpan nomor telepon pengguna
      'userImg': userImg, // Menyimpan URL gambar profil pengguna
      'country': country, // Menyimpan negara pengguna
      'userAddress': userAddress, // Menyimpan alamat lengkap pengguna
      'street': street, // Menyimpan nama jalan pengguna
      'isAdmin': isAdmin, // Menyimpan status admin
      'isActive': isActive, // Menyimpan status aktif
      'createdOn': createdOn, // Menyimpan waktu pembuatan akun
      'city': city, // Menyimpan kota tempat tinggal pengguna
    };
  }

  // Konstruktor factory untuk membuat objek UserModel dari Map
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'], // Mengambil ID pengguna dari Map
      username: json['username'], // Mengambil nama pengguna dari Map
      email: json['email'], // Mengambil email pengguna dari Map
      phone: json['phone'], // Mengambil nomor telepon pengguna dari Map
      userImg: json['userImg'], // Mengambil URL gambar profil pengguna dari Map
      country: json['country'], // Mengambil negara pengguna dari Map
      userAddress: json['userAddress'], // Mengambil alamat lengkap pengguna dari Map
      street: json['street'], // Mengambil nama jalan pengguna dari Map
      isAdmin: json['isAdmin'], // Mengambil status admin dari Map
      isActive: json['isActive'], // Mengambil status aktif dari Map
      createdOn: json['createdOn'].toString(), // Mengambil waktu pembuatan akun dari Map dan mengonversinya ke string
      city: json['city'], // Mengambil kota tempat tinggal pengguna dari Map
    );
  }
}
