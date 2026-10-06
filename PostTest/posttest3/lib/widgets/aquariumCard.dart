import 'package:flutter/material.dart';
import '../detailPage.dart';

// AquariumCard tetap StatelessWidget karena hanya menerima data dari parent
// dan menampilkannya tanpa mengubah state internal
class AquariumCard extends StatelessWidget {
  // Properti yang diterima dari parent (HomePage)
  final String nama;
  final String kondisi;
  final String suhu;
  final String ph;
  final String filter;

  const AquariumCard({
    super.key,
    required this.nama,
    required this.kondisi,
    required this.suhu,
    required this.ph,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    // Cek apakah kondisi optimal untuk menentukan warna
    final isOptimal = kondisi == 'Optimal';

    // Container sebagai card pembungkus
    return Container(
      // Padding untuk memberi ruang di dalam card
      padding: const EdgeInsets.all(16),
      // BoxDecoration untuk mengatur warna, border, radius, dan shadow
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12),
        // BoxShadow untuk memberi efek bayangan pada card
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Row untuk menyusun gambar dan info secara horizontal
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset untuk menampilkan gambar akuarium
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/aquarium.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          // SizedBox untuk memberi jarak horizontal
          const SizedBox(width: 16),

          // Expanded untuk mengisi sisa ruang
          Expanded(
            // Column untuk menyusun informasi secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text untuk nama akuarium (data dari parent)
                Text(
                  nama,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),

                // SizedBox untuk memberi jarak vertikal
                const SizedBox(height: 4),

                // Text untuk status kondisi dengan warna dinamis
                Text(
                  'Kondisi: $kondisi',
                  style: TextStyle(
                    fontSize: 14,
                    color: isOptimal ? Colors.green.shade600 : Colors.orange.shade700,
                  ),
                ),

                const SizedBox(height: 8),

                // Row untuk parameter air
                Row(
                  children: [
                    // Icon suhu
                    Icon(Icons.thermostat, size: 16, color: Colors.grey.shade600),
                    // Text suhu (data dari parent)
                    Text(' $suhu', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    const SizedBox(width: 12),
                    // Icon pH
                    Icon(Icons.science, size: 16, color: Colors.grey.shade600),
                    // Text pH (data dari parent)
                    Text(' $ph', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),

                const SizedBox(height: 12),

                // ElevatedButton untuk navigasi ke DetailPage
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push untuk berpindah ke halaman DetailPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          nama: nama,
                          kondisi: kondisi,
                          suhu: suhu,
                          ph: ph,
                          filter: filter,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  // Row untuk icon dan text di dalam tombol
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon di dalam tombol
                      Icon(Icons.visibility, size: 16),
                      SizedBox(width: 8),
                      // Text di dalam tombol
                      Text('Lihat Detail', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}