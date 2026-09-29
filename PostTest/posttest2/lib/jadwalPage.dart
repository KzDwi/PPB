import 'package:flutter/material.dart';
import 'widgets/jadwalCard.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

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
            // Padding untuk judul
            Padding(
              padding: const EdgeInsets.all(24),
              // Text judul halaman
              child: Text(
                'Jadwal Perawatan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
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
                      // JadwalCard untuk pemberian makan
                      JadwalCard(
                        waktu: '08:00 WIB',
                        aktivitas: 'Beri Makan Ikan',
                        icon: Icons.restaurant,
                      ),

                      const SizedBox(height: 16),

                      // JadwalCard untuk cek suhu
                      JadwalCard(
                        waktu: '12:00 WIB',
                        aktivitas: 'Cek Suhu & pH Air',
                        icon: Icons.thermostat,
                      ),

                      const SizedBox(height: 16),

                      // JadwalCard untuk pembersihan filter
                      JadwalCard(
                        waktu: '16:00 WIB',
                        aktivitas: 'Bersihkan Filter',
                        icon: Icons.filter_alt,
                      ),

                      const SizedBox(height: 16),

                      // JadwalCard untuk ganti air
                      JadwalCard(
                        waktu: '20:00 WIB',
                        aktivitas: 'Ganti Air 20%',
                        icon: Icons.water_drop,
                      ),
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