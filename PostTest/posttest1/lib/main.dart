import 'package:flutter/material.dart';
import 'widgets/aquariumCard.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp sebagai wrapper utama aplikasi
    return MaterialApp(
      // Theme untuk mengatur tampilan visual aplikasi
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // Menonaktifkan banner debug
      debugShowCheckedModeBanner: false,
      // Home menentukan halaman yang ditampilkan pertama kali
      home: const HomePage(),
    );
  }
}

// Variabel untuk menyimpan index navigasi yang aktif
int _currentIndex = 0;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur dasar halaman
    return Scaffold(
      // backgroundColor untuk mengatur warna latar belakang
      backgroundColor: Colors.blue.shade50,
      // SafeArea agar konten tidak tertutup area fisik perangkat
      body: SafeArea(
        // Column untuk menyusun widget secara vertikal
        child: Column(
          children: [
            // Padding untuk memberi jarak pada search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              // TextField untuk input pencarian
              child: TextField(
                // InputDecoration untuk mendekorasi TextField
                decoration: InputDecoration(
                  // hintText sebagai placeholder
                  hintText: 'Cari Akuarium...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  // suffixIcon untuk ikon di ujung kanan
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    // Icon pencarian
                    child: Icon(
                      Icons.search,
                      size: 24,
                      color: Colors.blue.shade400,
                    ),
                  ),
                  // Border untuk TextField
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                  // enabledBorder untuk kondisi saat tidak aktif
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue.shade200),
                  ),
                  // contentPadding untuk mengatur padding di dalam TextField
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  // fillColor dan filled untuk mengisi warna background TextField
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),

            // Expanded untuk mengisi sisa ruang yang tersedia
            Expanded(
              // SingleChildScrollView agar konten bisa di-scroll
              child: SingleChildScrollView(
                // Padding untuk memberi jarak pada konten
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  // Column untuk menyusun daftar card secara vertikal
                  child: Column(
                    children: [
                      // Memanggil widget AquariumCard
                      AquariumCard(),
                      // SizedBox untuk memberi jarak antar card
                      const SizedBox(height: 20),
                      AquariumCard(),
                      const SizedBox(height: 20),
                      AquariumCard(),
                      const SizedBox(height: 20),
                      AquariumCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar sebagai navigasi bawah
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: _currentIndex,
        // destinations untuk menentukan item navigasi
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.calendar_today), label: 'Jadwal'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}