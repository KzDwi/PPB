import 'package:flutter/material.dart';

// AquariumProvider extends ChangeNotifier
// ChangeNotifier adalah class Flutter yang menyediakan mekanisme
// notifikasi perubahan state. Ketika state berubah, panggil notifyListeners()
// agar widget yang mendengarkan (via Consumer / context.watch) di-rebuild.
class AquariumProvider extends ChangeNotifier {
  // ==================== STATE: DAFTAR AKUARIUM ====================
  // Data dummy daftar akuarium (hard-coded)
  // State ini digunakan oleh HomePage (list) dan DetailPage (detail)
  final List<Map<String, dynamic>> daftarAkuarium = [
    {
      'id': '1',
      'nama': 'Aquarium Utama',
      'kondisi': 'Optimal',
      'suhu': '27°C',
      'ph': '7.2',
      'filter': 'Aktif',
      // State: jumlah berapa kali ikan sudah diberi makan hari ini
      'jumlahPemberianMakan': 0,
      // State: apakah hari ini sudah diberi makan
      'sudahDiberiMakan': false,
    },
    {
      'id': '2',
      'nama': 'Aquarium Guppy',
      'kondisi': 'Optimal',
      'suhu': '26°C',
      'ph': '7.0',
      'filter': 'Aktif',
      'jumlahPemberianMakan': 0,
      'sudahDiberiMakan': false,
    },
    {
      'id': '3',
      'nama': 'Aquarium Cupang',
      'kondisi': 'Perlu Perawatan',
      'suhu': '28°C',
      'ph': '6.8',
      'filter': 'Nonaktif',
      'jumlahPemberianMakan': 0,
      'sudahDiberiMakan': false,
    },
    {
      'id': '4',
      'nama': 'Aquarium Discus',
      'kondisi': 'Optimal',
      'suhu': '29°C',
      'ph': '6.5',
      'filter': 'Aktif',
      'jumlahPemberianMakan': 0,
      'sudahDiberiMakan': false,
    },
  ];

  // ==================== STATE: JADWAL PERAWATAN ====================
  // State: daftar jadwal perawatan dengan status selesai
  // Digunakan oleh JadwalPage
  final List<Map<String, dynamic>> daftarJadwal = [
    {
      'waktu': '08:00 WIB',
      'aktivitas': 'Beri Makan Ikan',
      'icon': Icons.restaurant,
      'selesai': false,
    },
    {
      'waktu': '12:00 WIB',
      'aktivitas': 'Cek Suhu & pH Air',
      'icon': Icons.thermostat,
      'selesai': false,
    },
    {
      'waktu': '16:00 WIB',
      'aktivitas': 'Bersihkan Filter',
      'icon': Icons.filter_alt,
      'selesai': false,
    },
    {
      'waktu': '20:00 WIB',
      'aktivitas': 'Ganti Air 20%',
      'icon': Icons.water_drop,
      'selesai': false,
    },
  ];

  // ==================== GETTER ====================

  // Getter: jumlah jadwal yang sudah selesai
  int get jumlahJadwalSelesai {
    return daftarJadwal.where((jadwal) => jadwal['selesai'] == true).length;
  }

  // Getter: jumlah akuarium yang kondisinya optimal
  int get jumlahAkuariumOptimal {
    return daftarAkuarium
        .where((akuarium) => akuarium['kondisi'] == 'Optimal')
        .length;
  }

  // Getter: total seluruh pemberian makan dari semua akuarium
int get totalPemberianMakan {
  return daftarAkuarium.fold(
    0,
    (total, akuarium) =>
        total + (akuarium['jumlahPemberianMakan'] as int),
  );
}

  // ==================== METHOD: PEMBERIAN MAKAN ====================
  // Method untuk menambah jumlah pemberian makan pada akuarium tertentu
  // Mencari akuarium berdasarkan id, lalu update state-nya
  void beriMakan(String id) {
    // Cari index akuarium berdasarkan id
    final index = daftarAkuarium.indexWhere((akuarium) => akuarium['id'] == id);

    // Jika tidak ditemukan, hentikan
    if (index == -1) return;

    // Update state
    daftarAkuarium[index]['jumlahPemberianMakan'] =
        (daftarAkuarium[index]['jumlahPemberianMakan'] as int) + 1;
    daftarAkuarium[index]['sudahDiberiMakan'] = true;

    // Panggil notifyListeners() agar widget yang mendengarkan
    // (via Consumer / context.watch) di-rebuild dengan data terbaru
    notifyListeners();
  }

  // ==================== METHOD: TOGGLE JADWAL ====================
  // Method untuk toggle status selesai pada jadwal
  void toggleJadwalSelesai(int index) {
    // Validasi index
    if (index < 0 || index >= daftarJadwal.length) return;

    // Update state: balik nilai selesai (true <-> false)
    daftarJadwal[index]['selesai'] = !daftarJadwal[index]['selesai'];

    // Panggil notifyListeners() untuk memberi tahu widget yang mendengarkan
    notifyListeners();
  }

  // ==================== METHOD: CARI AKUARIUM ====================
  // Method untuk mencari akuarium berdasarkan kata kunci
  // Dipakai di HomePage sebagai pengganti getter filteredAkuarium
  List<Map<String, dynamic>> cariAkuarium(String searchQuery) {
    if (searchQuery.isEmpty) {
      return daftarAkuarium;
    }
    return daftarAkuarium
        .where((akuarium) =>
            akuarium['nama'].toString().toLowerCase().contains(searchQuery))
        .toList();
  }
}