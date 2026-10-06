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

// HomePage diubah menjadi StatefulWidget agar dapat menyimpan state
// seperti searchQuery (kata kunci pencarian) dan daftar akuarium yang difilter
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State: kata kunci pencarian yang dapat berubah saat pengguna mengetik
  String searchQuery = '';

  // State: index navigasi yang aktif
  int _currentIndex = 0;

  // Data dummy daftar akuarium (hard-coded)
  // Dalam aplikasi nyata, data ini bisa berasal dari database/API
  final List<Map<String, String>> daftarAkuarium = [
    {
      'nama': 'Aquarium Utama',
      'kondisi': 'Optimal',
      'suhu': '27°C',
      'ph': '7.2',
      'filter': 'Aktif',
    },
    {
      'nama': 'Aquarium Guppy',
      'kondisi': 'Optimal',
      'suhu': '26°C',
      'ph': '7.0',
      'filter': 'Aktif',
    },
    {
      'nama': 'Aquarium Cupang',
      'kondisi': 'Perlu Perawatan',
      'suhu': '28°C',
      'ph': '6.8',
      'filter': 'Nonaktif',
    },
    {
      'nama': 'Aquarium Discus',
      'kondisi': 'Optimal',
      'suhu': '29°C',
      'ph': '6.5',
      'filter': 'Aktif',
    },
  ];

  // Getter untuk mendapatkan daftar akuarium yang sudah difilter
  // berdasarkan searchQuery (state) — mirip konsep visibleProducts di Modul 4
  List<Map<String, String>> get filteredAkuarium {
    if (searchQuery.isEmpty) {
      return daftarAkuarium;
    }
    return daftarAkuarium
        .where((akuarium) =>
            akuarium['nama']!.toLowerCase().contains(searchQuery))
        .toList();
  }

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
              // TextField untuk pencarian dengan onChanged yang memanggil setState
              child: TextField(
                // onChanged dipanggil setiap kali pengguna mengetik
                // setState() digunakan untuk memperbarui state searchQuery
                onChanged: (value) {
                  setState(() {
                    // State searchQuery diperbarui dengan input pengguna
                    searchQuery = value.toLowerCase();
                  });
                },
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
                      // Conditional: jika hasil filter kosong, tampilkan pesan
                      if (filteredAkuarium.isEmpty)
                        // Padding untuk pesan kosong
                        Padding(
                          padding: const EdgeInsets.all(40),
                          // Column untuk icon dan text
                          child: Column(
                            children: [
                              // Icon pencarian tidak ditemukan
                              Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              // Text pesan tidak ditemukan
                              Text(
                                'Akuarium tidak ditemukan',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        // Loop untuk menampilkan setiap akuarium dalam card
                        ...filteredAkuarium.map((akuarium) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            // AquariumCard menerima data dari parent
                            child: AquariumCard(
                              nama: akuarium['nama']!,
                              kondisi: akuarium['kondisi']!,
                              suhu: akuarium['suhu']!,
                              ph: akuarium['ph']!,
                              filter: akuarium['filter']!,
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
        selectedIndex: _currentIndex,
        // onDestinationSelected untuk navigasi
        onDestinationSelected: (index) {
          // setState untuk memperbarui state _currentIndex
          setState(() {
            _currentIndex = index;
          });
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