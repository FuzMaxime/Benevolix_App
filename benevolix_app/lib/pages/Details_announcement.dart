import 'package:flutter/material.dart';

class AnnoucementDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                // Avatar carré
                Container(
                  width: 50.0, // Largeur de l'avatar carré
                  height: 50.0, // Hauteur de l'avatar carré
                  decoration: BoxDecoration(
                    color: Colors.red, // Couleur de fond de l'avatar
                    borderRadius: BorderRadius.circular(
                        8.0), // Coins arrondis si nécessaire
                  ),
                  child: const Center(
                    child: Text(
                      "JD", // Texte pour l'avatar
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Unicef - Délégué Départemental H/F",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),

            // Info Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem(Icons.location_on, "Nantes"),
                _infoItem(Icons.calendar_today, "22/01/2026"),
                _infoItem(Icons.access_time, "3 Days"),
                //_infoItem(Icons.home_work, ""),
                _infoItem(Icons.business, ""),
              ],
            ),
            const Divider(),

            // Description
            Text(
              "Gerveur Pinvidik Voger Eno Sav C’hi. Gerveur Pinvidik Voger Eno Sav C’h . Drezo Berr Bihañ Yalc’h Ael Kerc’h...",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),

            // Tags
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 0.5),
                  child: SizedBox(
                      width: 92, // Limite la largeur du Chip
                      child: Chip(
                        label: Text(
                          "Humanitaire",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFFFA3D33)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        backgroundColor:
                            const Color.fromARGB(100, 255, 123, 116),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
