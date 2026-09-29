import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur dasar halaman
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      // SafeArea agar konten tidak tertutup area fisik perangkat
      body: SafeArea(
        // Stack untuk menumpuk widget
        child: Stack(
          children: [
            // SingleChildScrollView agar konten bisa di-scroll
            SingleChildScrollView(
              child: Column(
                children: [
                  // Image.asset sebagai header akuarium
                  Image.asset(
                    'assets/aquarium.png',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),

                  // Padding untuk memberi jarak pada konten
                  Padding(
                    padding: const EdgeInsets.all(24),
                    // Column untuk menyusun informasi secara vertikal
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text untuk nama akuarium
                        Text(
                          'Aquarium Utama',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Text untuk status
                        Text(
                          'Status: Optimal',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green.shade600,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Container untuk info parameter air
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            // BoxShadow untuk memberi bayangan
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          // Column untuk parameter
                          child: Column(
                            children: [
                              // Row untuk suhu
                              Row(
                                children: [
                                  Icon(Icons.thermostat, color: Colors.blue.shade600),
                                  const SizedBox(width: 12),
                                  // Text suhu
                                  Text('Suhu Air: 27°C', style: TextStyle(fontSize: 16)),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Row untuk pH
                              Row(
                                children: [
                                  Icon(Icons.science, color: Colors.blue.shade600),
                                  const SizedBox(width: 12),
                                  // Text pH
                                  Text('pH Air: 7.2', style: TextStyle(fontSize: 16)),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Row untuk filter
                              Row(
                                children: [
                                  Icon(Icons.filter_alt, color: Colors.blue.shade600),
                                  const SizedBox(width: 12),
                                  // Text filter
                                  Text('Filter: Aktif', style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ElevatedButton untuk aksi beri makan
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // Row untuk icon dan text
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restaurant, size: 20),
                              SizedBox(width: 8),
                              Text('Beri Makan', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ElevatedButton untuk kembali
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.pop untuk kembali ke halaman sebelumnya
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Kembali', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Positioned untuk menempatkan tombol back di atas gambar
            Positioned(
              top: 16,
              left: 16,
              // Container untuk tombol back
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  // BoxShadow untuk bayangan tombol
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                // IconButton untuk kembali
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navigator.pop untuk kembali
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}