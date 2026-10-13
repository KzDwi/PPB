import 'package:flutter/material.dart';
// Import package provider untuk membaca state dari AquariumProvider
import 'package:provider/provider.dart';
import 'providers/aquarium_provider.dart';

// DetailPage tetap StatefulWidget (bisa juga Stateless), tapi kali ini
// state-nya (jumlahPemberianMakan, sudahDiberiMakan) dikelola oleh Provider.
// Kita hanya perlu membaca data berdasarkan id akuarium.
class DetailPage extends StatefulWidget {
  // Properti: id akuarium untuk mencari data di Provider
  final String id;

  const DetailPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // ==================== CONSUMER ====================
    // Consumer<AquariumProvider> mendengarkan perubahan pada AquariumProvider.
    // Setiap kali notifyListeners() dipanggil (misal setelah beriMakan()),
    // widget ini akan di-rebuild dengan data terbaru.
    return Consumer<AquariumProvider>(
      builder: (context, aquariumProvider, child) {
        // Cari akuarium berdasarkan id
        final aquarium = aquariumProvider.daftarAkuarium.firstWhere(
          (a) => a['id'] == widget.id,
          // Fallback jika tidak ditemukan
          orElse: () => {
            'id': '0',
            'nama': 'Tidak Ditemukan',
            'kondisi': '-',
            'suhu': '-',
            'ph': '-',
            'filter': '-',
            'jumlahPemberianMakan': 0,
            'sudahDiberiMakan': false,
          },
        );

        // Ambil state dari provider
        final nama = aquarium['nama'] as String;
        final kondisi = aquarium['kondisi'] as String;
        final suhu = aquarium['suhu'] as String;
        final ph = aquarium['ph'] as String;
        final filter = aquarium['filter'] as String;
        final jumlahPemberianMakan = aquarium['jumlahPemberianMakan'] as int;
        final sudahDiberiMakan = aquarium['sudahDiberiMakan'] as bool;

        // Cek apakah kondisi optimal
        final isOptimal = kondisi == 'Optimal';

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
                            // Text untuk nama akuarium (data dari provider)
                            Text(
                              nama,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Text untuk status kondisi
                            Text(
                              'Status: $kondisi',
                              style: TextStyle(
                                fontSize: 16,
                                color: isOptimal
                                    ? Colors.green.shade600
                                    : Colors.orange.shade700,
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
                                      Icon(Icons.thermostat,
                                          color: Colors.blue.shade600),
                                      const SizedBox(width: 12),
                                      // Text suhu (data dari provider)
                                      Text('Suhu Air: $suhu',
                                          style:
                                              const TextStyle(fontSize: 16)),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Row untuk pH
                                  Row(
                                    children: [
                                      Icon(Icons.science,
                                          color: Colors.blue.shade600),
                                      const SizedBox(width: 12),
                                      // Text pH (data dari provider)
                                      Text('pH Air: $ph',
                                          style:
                                              const TextStyle(fontSize: 16)),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // Row untuk filter
                                  Row(
                                    children: [
                                      Icon(Icons.filter_alt,
                                          color: Colors.blue.shade600),
                                      const SizedBox(width: 12),
                                      // Text filter (data dari provider)
                                      Text('Filter: $filter',
                                          style:
                                              const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Container untuk menampilkan state pemberian makan
                            // State ini berasal dari Provider (bukan lokal)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: sudahDiberiMakan
                                    ? Colors.green.shade50
                                    : Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: sudahDiberiMakan
                                      ? Colors.green.shade200
                                      : Colors.orange.shade200,
                                ),
                              ),
                              // Row untuk icon dan info pemberian makan
                              child: Row(
                                children: [
                                  // Icon status pemberian makan
                                  Icon(
                                    sudahDiberiMakan
                                        ? Icons.check_circle
                                        : Icons.info_outline,
                                    color: sudahDiberiMakan
                                        ? Colors.green.shade600
                                        : Colors.orange.shade700,
                                    size: 32,
                                  ),
                                  const SizedBox(width: 16),
                                  // Expanded untuk info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text status pemberian makan
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
                                        // Text jumlah pemberian makan
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
                            // onPressed memanggil provider.beriMakan(id)
                            ElevatedButton(
                              onPressed: () {
                                // ==================== CONTEXT.READ ====================
                                // context.read<AquariumProvider>() mengambil
                                // provider SATU KALI tanpa membuat widget
                                // mendengarkan perubahan. Cocok untuk memanggil
                                // method (action) seperti beriMakan().
                                context
                                    .read<AquariumProvider>()
                                    .beriMakan(widget.id);

                                // Tampilkan SnackBar sebagai feedback
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Ikan di $nama sudah diberi makan!'),
                                    backgroundColor: Colors.green.shade600,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade600,
                                foregroundColor: Colors.white,
                                minimumSize:
                                    const Size(double.infinity, 48),
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
                                  Text('Beri Makan',
                                      style: TextStyle(fontSize: 16)),
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
                                minimumSize:
                                    const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Kembali',
                                  style: TextStyle(fontSize: 16)),
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
      },
    );
  }
}