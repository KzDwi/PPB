import 'package:flutter/material.dart';

class AquariumCard extends StatelessWidget {
  const AquariumCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget Container untuk membungkus card
    return Container(
      // Padding untuk memberi ruang di dalam card
      padding: const EdgeInsets.all(16),
      // BoxDecoration untuk mengatur warna, border, dan radius
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      // Row untuk menyusun gambar dan info secara horizontal
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container sebagai placeholder gambar akuarium
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            // Icon di dalam container sebagai visual akuarium
            child: Icon(
              Icons.water_drop,
              size: 40,
              color: Colors.blue.shade300,
            ),
          ),

          // SizedBox untuk memberi jarak horizontal
          const SizedBox(width: 16),

          // Expanded untuk mengisi sisa ruang di samping gambar
          Expanded(
            // Column untuk menyusun informasi secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text untuk menampilkan nama akuarium
                Text(
                  'Aquarium Utama',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),

                // SizedBox untuk memberi jarak vertikal
                const SizedBox(height: 4),

                // Text untuk menampilkan status kondisi
                Text(
                  'Kondisi: Optimal',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green.shade600,
                  ),
                ),

                // SizedBox untuk memberi jarak vertikal
                const SizedBox(height: 8),

                // Row untuk menampilkan parameter air (Suhu, pH, Filter)
                Row(
                  children: [
                    // Icon untuk suhu
                    Icon(Icons.thermostat, size: 16, color: Colors.grey.shade600),
                    // Text untuk suhu
                    Text(
                      ' 27°C',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 12),
                    // Icon untuk pH
                    Icon(Icons.science, size: 16, color: Colors.grey.shade600),
                    // Text untuk pH
                    Text(
                      ' 7.2',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 12),
                    // Icon untuk filter
                    Icon(Icons.filter_alt, size: 16, color: Colors.grey.shade600),
                    // Text untuk filter
                    Text(
                      ' Aktif',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),

                // SizedBox untuk memberi jarak vertikal
                const SizedBox(height: 12),

                // ElevatedButton untuk aksi pada card
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  // Row untuk menyusun icon dan text di dalam tombol
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon di dalam tombol
                      Icon(Icons.restaurant, size: 16),
                      SizedBox(width: 8),
                      // Text di dalam tombol
                      Text(
                        'Beri Makan',
                        style: TextStyle(fontSize: 12),
                      ),
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