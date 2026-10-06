import 'package:flutter/material.dart';
import 'widgets/jadwalCard.dart';

// JadwalPage diubah menjadi StatefulWidget karena memiliki state:
// daftar jadwal dengan status selesai/belum selesai
class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  // State: daftar jadwal perawatan dengan status selesai
  // Setiap item memiliki: waktu, aktivitas, icon, dan status selesai
  List<Map<String, dynamic>> daftarJadwal = [
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

  // Method untuk toggle status selesai pada jadwal
  // Menggunakan setState untuk memperbarui state
  void toggleSelesai(int index) {
    setState(() {
      // Membalik nilai selesai (true ↔ false)
      daftarJadwal[index]['selesai'] = !daftarJadwal[index]['selesai'];
    });
  }

  // Getter untuk menghitung berapa jadwal yang sudah selesai
  int get jumlahSelesai {
    return daftarJadwal.where((jadwal) => jadwal['selesai'] == true).length;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur dasar halaman
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      // SafeArea agar konten tidak tertutup
      body: SafeArea(
        // Column untuk menyusun konten
        child: Column(
          children: [
            // Padding untuk judul dan progress
            Padding(
              padding: const EdgeInsets.all(24),
              // Column untuk judul dan progress
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text judul halaman
                  Text(
                    'Jadwal Perawatan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text progress (state: jumlahSelesai)
                  Text(
                    '$jumlahSelesai dari ${daftarJadwal.length} tugas selesai',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Expanded untuk mengisi sisa ruang
            Expanded(
              // SingleChildScrollView agar bisa di-scroll
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  // Column untuk daftar jadwal
                  child: Column(
                    children: [
                      // Loop untuk menampilkan setiap jadwal
                      ...daftarJadwal.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> jadwal = entry.value;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          // JadwalCard menerima data dan callback dari parent
                          child: JadwalCard(
                            waktu: jadwal['waktu'],
                            aktivitas: jadwal['aktivitas'],
                            icon: jadwal['icon'],
                            selesai: jadwal['selesai'],
                            // Callback untuk toggle status selesai
                            onToggle: () => toggleSelesai(index),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // NavigationBar untuk navigasi
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: 1,
        // onDestinationSelected untuk navigasi
        onDestinationSelected: (index) {
          if (index == 0) {
            // Navigator.pop untuk kembali ke HomePage
            Navigator.pop(context);
          }
        },
        // destinations untuk item navigasi
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.calendar_today), label: 'Jadwal'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}