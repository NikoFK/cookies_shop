// Mengabaikan peringatan kode terkait nama file
// ignore_for_file: file_names

// Definisi kelas ProductModel
class ProductModel {
  // Properti-properti kelas
  final String productId; // ID unik untuk produk
  final String categoryId; // ID kategori produk
  final String productName; // Nama produk
  final String categoryName; // Nama kategori produk
  final String salePrice; // Harga jual produk
  final String fullPrice; // Harga penuh produk
  final List productImages; // Daftar gambar produk
  final String deliveryTime; // Waktu pengiriman produk
  final bool isSale; // Status apakah produk sedang dalam penjualan (sale)
  final String productDescription; // Deskripsi produk
  final dynamic createdAt; // Waktu pembuatan produk, tipe dynamic karena bisa berupa berbagai jenis data

  // Konstruktor kelas dengan parameter wajib untuk setiap properti
  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.productName,
    required this.categoryName,
    required this.salePrice,
    required this.fullPrice,
    required this.productImages,
    required this.deliveryTime,
    required this.isSale,
    required this.productDescription,
    required this.createdAt,
  });

  // Metode untuk mengonversi objek ProductModel menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId, // Menyimpan ID produk
      'categoryId': categoryId, // Menyimpan ID kategori
      'productName': productName, // Menyimpan nama produk
      'categoryName': categoryName, // Menyimpan nama kategori
      'salePrice': salePrice, // Menyimpan harga jual
      'fullPrice': fullPrice, // Menyimpan harga penuh
      'productImages': productImages, // Menyimpan daftar gambar produk
      'deliveryTime': deliveryTime, // Menyimpan waktu pengiriman
      'isSale': isSale, // Menyimpan status penjualan
      'productDescription': productDescription, // Menyimpan deskripsi produk
      'createdAt': createdAt, // Menyimpan waktu pembuatan
    };
  }

  // Konstruktor factory untuk membuat objek ProductModel dari Map
  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'], // Mengambil ID produk dari Map
      categoryId: json['categoryId'], // Mengambil ID kategori dari Map
      productName: json['productName'], // Mengambil nama produk dari Map
      categoryName: json['categoryName'], // Mengambil nama kategori dari Map
      salePrice: json['salePrice'], // Mengambil harga jual dari Map
      fullPrice: json['fullPrice'], // Mengambil harga penuh dari Map
      productImages: json['productImages'], // Mengambil daftar gambar produk dari Map
      deliveryTime: json['deliveryTime'], // Mengambil waktu pengiriman dari Map
      isSale: json['isSale'], // Mengambil status penjualan dari Map
      productDescription: json['productDescription'], // Mengambil deskripsi produk dari Map
      createdAt: json['createdAt'], // Mengambil waktu pembuatan dari Map
    );
  }
}
