import 'dart:async';

enum Role { Admin, Customer }

class Product {
  String productName;
  double price;
  bool inStock;

  Product(
      {required this.productName, required this.price, required this.inStock});

  @override
  String toString() =>
      'Product(name: $productName, price: $price, inStock: $inStock)';
}

class User {
  String name;
  int age;
  late List<Product> products; // Inisialisasi produk menggunakan 'late'
  Role? role; // Nullable type untuk role

  User({required this.name, required this.age, this.role});
}

class AdminUser extends User {
  AdminUser({required super.name, required super.age})
      : super(role: Role.Admin);

  // Menambah produk ke daftar produk pengguna
  void addProduct(Map<String, Product> productCatalog, Product product) {
    if (product.inStock) {
      productCatalog[product.productName] = product;
      print('${product.productName} berhasil ditambahkan ke katalog.');
    } else {
      throw Exception('${product.productName} tidak tersedia dalam stok.');
    }
  }

  // Menghapus produk dari daftar produk pengguna
  void removeProduct(Map<String, Product> productCatalog, String productName) {
    if (productCatalog.containsKey(productName)) {
      productCatalog.remove(productName);
      print('$productName berhasil dihapus dari katalog.');
    } else {
      print('$productName tidak ditemukan di katalog.');
    }
  }
}

class CustomerUser extends User {
  CustomerUser({required super.name, required super.age})
      : super(role: Role.Customer);

  // Melihat daftar produk
  void viewProducts(Map<String, Product> productCatalog) {
    print('--- Daftar Produk ---');
    for (var product in productCatalog.values) {
      print(product);
    }
  }
}

// Fungsi async untuk meniru pengambilan data produk dari server
Future<Product> fetchProductDetails(String productName) async {
  print('Mengambil detail produk $productName...');
  await Future.delayed(const Duration(seconds: 2)); // Simulasi waktu tunggu
  return Product(productName: productName, price: 50.0, inStock: true);
}

void main() async {
  // Membuat katalog produk menggunakan Map
  Map<String, Product> productCatalog = {};

  // Membuat instance AdminUser dan CustomerUser
  AdminUser admin = AdminUser(name: 'Alice', age: 30);
  CustomerUser customer = CustomerUser(name: 'Bob', age: 25);

  // Menambah produk baru (exception handling)
  try {
    Product newProduct =
        Product(productName: 'Laptop', price: 1200.0, inStock: true);
    admin.addProduct(productCatalog, newProduct);

    Product outOfStockProduct =
        Product(productName: 'Smartphone', price: 800.0, inStock: false);
    admin.addProduct(
        productCatalog, outOfStockProduct); // Ini akan memicu exception
  } catch (e) {
    print('Error: $e');
  }

  // Menghapus produk dari katalog
  admin.removeProduct(productCatalog, 'Laptop');

  // Menampilkan produk untuk customer
  customer.viewProducts(productCatalog);

  // Mengambil detail produk secara async
  Product fetchedProduct = await fetchProductDetails('Tablet');
  print('Detail produk yang diambil: $fetchedProduct');

  // Menggunakan Set untuk memastikan tidak ada produk duplikat
  Set<Product> uniqueProducts = {fetchedProduct, fetchedProduct};
  print('Jumlah produk unik dalam Set: ${uniqueProducts.length}');
}
