import 'package:flutter/material.dart';
import 'jadwalPage.dart';
import 'widgets/aquariumCard.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp sebagai wrapper utama
    return MaterialApp(
      // Theme untuk tampilan visual
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // Menonaktifkan banner debug
      debugShowCheckedModeBanner: false,
      // Home menentukan halaman awal
      home: const HomePage(),
    );
  }
}

// Variabel untuk index navigasi
int _currentIndex = 0;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur dasar
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      // SafeArea agar konten tidak tertutup
      body: SafeArea(
        // Column untuk menyusun konten
        child: Column(
          children: [
            // Padding untuk search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              // TextField untuk pencarian
              child: TextField(
                decoration: InputDecoration(
                  // hintText sebagai placeholder
                  hintText: 'Cari Akuarium...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  // suffixIcon untuk icon pencarian
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.search, size: 24, color: Colors.blue.shade400),
                  ),
                  // Border untuk TextField
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                  // enabledBorder untuk kondisi tidak aktif
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                  // contentPadding untuk padding dalam
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  // fillColor dan filled untuk background
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),

            // Expanded untuk mengisi sisa ruang
            Expanded(
              // SingleChildScrollView agar bisa di-scroll
              child: SingleChildScrollView(
                // Padding untuk konten
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  // Column untuk daftar aquarium
                  child: Column(
                    children: [
                      // AquariumCard untuk setiap akuarium
                      const AquariumCard(),
                      const SizedBox(height: 20),
                      const AquariumCard(),
                      const SizedBox(height: 20),
                      const AquariumCard(),
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
        selectedIndex: _currentIndex,
        // onDestinationSelected untuk navigasi
        onDestinationSelected: (index) {
          if (index == 1) {
            // Navigator.push ke JadwalPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const JadwalPage()),
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