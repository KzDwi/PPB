import 'package:flutter/material.dart';

// JadwalCard tetap StatelessWidget karena hanya menerima data dan callback
// dari parent, tidak memiliki state internal sendiri
class JadwalCard extends StatelessWidget {
  // Properti yang diterima dari parent
  final String waktu;
  final String aktivitas;
  final IconData icon;
  final bool selesai;
  // Callback untuk memberitahu parent saat card di-tap
  final VoidCallback onToggle;

  const JadwalCard({
    super.key,
    required this.waktu,
    required this.aktivitas,
    required this.icon,
    required this.selesai,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Container sebagai card, dibungkus InkWell agar bisa di-tap
    return InkWell(
      // onTap memanggil callback onToggle dari parent
      onTap: onToggle,
      borderRadius: BorderRadius.circular(12),
      // Container sebagai card
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // Warna berubah sesuai status selesai
          color: selesai ? Colors.green.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selesai ? Colors.green.shade200 : Colors.blue.shade100,
          ),
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
                // Warna icon berubah sesuai status
                color: selesai ? Colors.green.shade100 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              // Icon aktivitas
              child: Icon(
                icon,
                color: selesai ? Colors.green.shade600 : Colors.blue.shade600,
                size: 24,
              ),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // Coret jika sudah selesai
                      decoration: selesai ? TextDecoration.lineThrough : TextDecoration.none,
                      color: selesai ? Colors.grey.shade500 : Colors.black,
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

            // Checkbox untuk menunjukkan status selesai
            Checkbox(
              value: selesai,
              onChanged: (value) {
                // Memanggil callback onToggle dari parent
                onToggle();
              },
              activeColor: Colors.green.shade600,
            ),
          ],
        ),
      ),
    );
  }
}