import 'package:flutter/material.dart';
// Import package provider untuk State Management
import 'package:provider/provider.dart';
import 'jadwalPage.dart';
import 'profilePage.dart';   // <-- tambahkan import ProfilePage
import 'providers/aquarium_provider.dart';
import 'widgets/aquariumCard.dart';

void main() {
  // MultiProvider untuk mendaftarkan provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AquariumProvider()),
      ],
      child: const MainApp(),
    ),
  );
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

// HomePage StatefulWidget dengan state lokal searchQuery dan _currentIndex
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State LOKAL: kata kunci pencarian
  String searchQuery = '';

  // State LOKAL: index navigasi yang aktif
  int _currentIndex = 0;

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
                // onChanged memanggil setState untuk update searchQuery
                onChanged: (value) {
                  setState(() {
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  // fillColor dan filled untuk background
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),

            // Consumer untuk mendengarkan perubahan dari AquariumProvider
            Expanded(
              child: Consumer<AquariumProvider>(
                builder: (context, aquariumProvider, child) {
                  // Filter daftar akuarium berdasarkan searchQuery
                  final filteredAkuarium =
                      aquariumProvider.cariAkuarium(searchQuery);

                  // SingleChildScrollView agar bisa di-scroll
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      // Column untuk daftar aquarium
                      child: Column(
                        children: [
                          // Container untuk ringkasan dari Provider
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade100,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            // Row untuk ringkasan
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Kolom: total akuarium
                                Column(
                                  children: [
                                    Icon(Icons.water,
                                        color: Colors.blue.shade600, size: 24),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${aquariumProvider.daftarAkuarium.length}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Akuarium',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                // Kolom: akuarium optimal
                                Column(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.green.shade600, size: 24),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${aquariumProvider.jumlahAkuariumOptimal}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Optimal',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                // Kolom: jadwal selesai
                                Column(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: Colors.orange.shade600, size: 24),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${aquariumProvider.jumlahJadwalSelesai}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Tugas Selesai',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Conditional: jika hasil filter kosong, tampilkan pesan
                          if (filteredAkuarium.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(40),
                              child: Column(
                                children: [
                                  // Icon pencarian tidak ditemukan
                                  Icon(Icons.search_off,
                                      size: 64, color: Colors.grey.shade400),
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
                                // AquariumCard menerima data dari provider
                                child: AquariumCard(
                                  id: akuarium['id'],
                                  nama: akuarium['nama'],
                                  kondisi: akuarium['kondisi'],
                                  suhu: akuarium['suhu'],
                                  ph: akuarium['ph'],
                                  filter: akuarium['filter'],
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // NavigationBar untuk navigasi
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: _currentIndex,
        // onDestinationSelected untuk navigasi antar halaman
        onDestinationSelected: (index) {
          // setState untuk memperbarui state lokal _currentIndex
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            // Navigator.push ke JadwalPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const JadwalPage()),
            );
          } else if (index == 2) {
            // Navigator.push ke ProfilePage
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