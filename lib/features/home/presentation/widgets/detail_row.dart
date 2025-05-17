import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  const DetailRow(this.label, this.value, {super.key});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              fontFamily: 'NotoSansArabic',
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                // fontFamily: 'NotoSansArabic',
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
