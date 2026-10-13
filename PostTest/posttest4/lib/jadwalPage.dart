import 'package:flutter/material.dart';
// Import package provider untuk membaca state dari AquariumProvider
import 'package:provider/provider.dart';
import 'profilePage.dart';
import 'providers/aquarium_provider.dart';
import 'widgets/jadwalCard.dart';

// JadwalPage bisa tetap StatefulWidget atau StatelessWidget.
// Karena state daftar jadwal sudah dipindah ke Provider,
// kita bisa ubah menjadi StatelessWidget.
class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur dasar halaman
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      // SafeArea agar konten tidak tertutup
      body: SafeArea(
        // ==================== CONSUMER ====================
        // Consumer<AquariumProvider> mendengarkan perubahan pada
        // AquariumProvider. Ketika toggleJadwalSelesai() memanggil
        // notifyListeners(), widget ini di-rebuild.
        child: Consumer<AquariumProvider>(
          builder: (context, aquariumProvider, child) {
            // Ambil daftar jadwal dari provider
            final daftarJadwal = aquariumProvider.daftarJadwal;

            // Column untuk menyusun konten
            return Column(
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
                      // Text progress (data dari provider)
                      Text(
                        '${aquariumProvider.jumlahJadwalSelesai} dari ${daftarJadwal.length} tugas selesai',
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
                                // Memanggil method di provider
                                onToggle: () {
                                  context
                                      .read<AquariumProvider>()
                                      .toggleJadwalSelesai(index);
                                },
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      // NavigationBar untuk navigasi
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: 1,
        // onDestinationSelected untuk navigasi antar halaman
        onDestinationSelected: (index) {
          if (index == 0) {
            // Navigator.pop untuk kembali ke HomePage
            Navigator.pop(context);
          } else if (index == 2) {
            // Navigator.push ke ProfilePage
            // Import profilePage.dart di atas file ini
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
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