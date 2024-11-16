import 'dart:math';

/// 1. Kelas ProdukDigital
class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori);

  void terapkanDiskon(double persenDiskon) {
    if (kategori.toLowerCase() == "network automation") {
      harga -= harga * (persenDiskon / 100);
    }
  }
}

/// 2. Kelas Abstrak Karyawan dan Subkelas KaryawanTetap & KaryawanKontrak
abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(super.nama, {required super.umur, required super.peran});

  @override
  void bekerja() {
    print("Karyawan Tetap $nama bekerja sesuai jam kerja reguler.");
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(super.nama, {required super.umur, required super.peran});

  @override
  void bekerja() {
    print("Karyawan Kontrak $nama bekerja berdasarkan perjanjian kontrak.");
  }
}

/// 3. Mixin Kinerja untuk Produktivitas
mixin Kinerja {
  int produktivitas = 100;

  void tingkatkanProduktivitas() {
    produktivitas += 5;
  }
}

class Manager extends KaryawanTetap with Kinerja {
  Manager(super.nama, {required super.umur}) : super(peran: "Manager");

  @override
  void tingkatkanProduktivitas() {
    produktivitas =
        max(produktivitas + 5, 85); // Produktivitas minimum Manager adalah 85
  }
}

/// 4. Enum FaseProyek untuk Konsistensi Proyek
enum FaseProyek { PERENCANAAN, PENGEMBANGAN, EVALUASI }

class Proyek {
  FaseProyek faseSaatIni = FaseProyek.PERENCANAAN;

  bool transisiKeFase(FaseProyek targetFase) {
    if (faseSaatIni == FaseProyek.PERENCANAAN &&
        targetFase == FaseProyek.PENGEMBANGAN) {
      faseSaatIni = targetFase;
      return true;
    } else if (faseSaatIni == FaseProyek.PENGEMBANGAN &&
        targetFase == FaseProyek.EVALUASI) {
      faseSaatIni = targetFase;
      return true;
    }
    return false;
  }
}

/// 5. Kelas Perusahaan dengan Pembatasan Jumlah Karyawan Aktif
class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  int batasKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < batasKaryawanAktif) {
      karyawanAktif.add(karyawan);
      print("Karyawan ${karyawan.nama} berhasil ditambahkan ke daftar aktif.");
    } else {
      print(
          "Tidak dapat menambah karyawan baru. Batas karyawan aktif tercapai.");
    }
  }

  void karyawanResign(Karyawan karyawan) {
    if (karyawanAktif.remove(karyawan)) {
      karyawanNonAktif.add(karyawan);
      print("Karyawan ${karyawan.nama} sekarang menjadi non-aktif.");
    }
  }
}

/// 6. Contoh Penggunaan Program
void main() {
  // Produk Digital
  var produk1 =
      ProdukDigital("Software Automation", 1500000, "Network Automation");
  print("Harga sebelum diskon: ${produk1.harga}");
  produk1.terapkanDiskon(10);
  print("Harga setelah diskon: ${produk1.harga}");

  // Karyawan Tetap dan Kontrak
  var karyawanTetap = KaryawanTetap("Alice", umur: 30, peran: "Engineer");
  var karyawanKontrak = KaryawanKontrak("Bob", umur: 25, peran: "Designer");
  karyawanTetap.bekerja();
  karyawanKontrak.bekerja();

  // Manager dengan produktivitas
  var manajer = Manager("John", umur: 40);
  print("Produktivitas awal Manager ${manajer.nama}: ${manajer.produktivitas}");
  manajer.tingkatkanProduktivitas();
  print("Produktivitas setelah peningkatan: ${manajer.produktivitas}");

  // Proyek dengan FaseProyek
  var proyek = Proyek();
  print("Fase proyek saat ini: ${proyek.faseSaatIni}");
  if (proyek.transisiKeFase(FaseProyek.PENGEMBANGAN)) {
    print("Proyek berhasil beralih ke fase ${proyek.faseSaatIni}");
  } else {
    print("Transisi fase proyek tidak valid.");
  }

  // Perusahaan dengan batas karyawan aktif
  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawanTetap);
  perusahaan.tambahKaryawan(karyawanKontrak);
  perusahaan.tambahKaryawan(manajer);

  // Resign salah satu karyawan
  perusahaan.karyawanResign(karyawanKontrak);
}
