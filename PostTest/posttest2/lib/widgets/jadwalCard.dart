import 'package:flutter/material.dart';

class JadwalCard extends StatelessWidget {
  final String waktu;
  final String aktivitas;
  final IconData icon;

  const JadwalCard({
    super.key,
    required this.waktu,
    required this.aktivitas,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Container sebagai card
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // BoxShadow untuk bayangan
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Row untuk menyusun icon dan info
      child: Row(
        children: [
          // Container untuk icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            // Icon aktivitas
            child: Icon(icon, color: Colors.blue.shade600, size: 24),
          ),

          const SizedBox(width: 16),

          // Expanded untuk info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text aktivitas
                Text(
                  aktivitas,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Text waktu
                Text(
                  waktu,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
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