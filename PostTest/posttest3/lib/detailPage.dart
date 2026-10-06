import 'package:flutter/material.dart';

// DetailPage diubah menjadi StatefulWidget karena memiliki state:
// 1. jumlahPemberianMakan (counter berapa kali ikan diberi makan)
// 2. sudahDiberiMakan (status apakah hari ini sudah diberi makan)
class DetailPage extends StatefulWidget {
  // Properti yang diterima dari AquariumCard
  final String nama;
  final String kondisi;
  final String suhu;
  final String ph;
  final String filter;

  const DetailPage({
    super.key,
    required this.nama,
    required this.kondisi,
    required this.suhu,
    required this.ph,
    required this.filter,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // State: jumlah berapa kali ikan sudah diberi makan hari ini
  int jumlahPemberianMakan = 0;

  // State: apakah hari ini sudah diberi makan
  bool sudahDiberiMakan = false;

  // Method untuk menangani aksi beri makan
  // Menggunakan setState untuk memperbarui state dan UI
  void beriMakan() {
    setState(() {
      // State jumlahPemberianMakan bertambah
      jumlahPemberianMakan++;
      // State sudahDiberiMakan menjadi true
      sudahDiberiMakan = true;
    });

    // Tampilkan SnackBar sebagai feedback ke pengguna
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ikan di ${widget.nama} sudah diberi makan!'),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cek apakah kondisi optimal
    final isOptimal = widget.kondisi == 'Optimal';

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
                        // Text untuk nama akuarium (data dari parent)
                        Text(
                          widget.nama,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Text untuk status kondisi dengan warna dinamis
                        Text(
                          'Status: ${widget.kondisi}',
                          style: TextStyle(
                            fontSize: 16,
                            color: isOptimal ? Colors.green.shade600 : Colors.orange.shade700,
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
                                  // Text suhu (data dari parent)
                                  Text('Suhu Air: ${widget.suhu}', style: const TextStyle(fontSize: 16)),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Row untuk pH
                              Row(
                                children: [
                                  Icon(Icons.science, color: Colors.blue.shade600),
                                  const SizedBox(width: 12),
                                  // Text pH (data dari parent)
                                  Text('pH Air: ${widget.ph}', style: const TextStyle(fontSize: 16)),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Row untuk filter
                              Row(
                                children: [
                                  Icon(Icons.filter_alt, color: Colors.blue.shade600),
                                  const SizedBox(width: 12),
                                  // Text filter (data dari parent)
                                  Text('Filter: ${widget.filter}', style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Container untuk menampilkan state jumlah pemberian makan
                        // Menggunakan state dari StatefulWidget
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: sudahDiberiMakan ? Colors.green.shade50 : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: sudahDiberiMakan ? Colors.green.shade200 : Colors.orange.shade200,
                            ),
                          ),
                          // Row untuk icon dan info pemberian makan
                          child: Row(
                            children: [
                              // Icon status pemberian makan
                              Icon(
                                sudahDiberiMakan ? Icons.check_circle : Icons.info_outline,
                                color: sudahDiberiMakan ? Colors.green.shade600 : Colors.orange.shade700,
                                size: 32,
                              ),
                              const SizedBox(width: 16),
                              // Expanded untuk info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text status pemberian makan (state)
                                    Text(
                                      sudahDiberiMakan
                                          ? 'Sudah diberi makan hari ini'
                                          : 'Belum diberi makan hari ini',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: sudahDiberiMakan
                                            ? Colors.green.shade800
                                            : Colors.orange.shade900,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Text jumlah pemberian makan (state)
                                    Text(
                                      'Total: $jumlahPemberianMakan kali',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ElevatedButton untuk aksi beri makan
                        // onPressed akan memanggil setState melalui method beriMakan()
                        ElevatedButton(
                          onPressed: beriMakan,
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