import 'package:flutter/material.dart';
import 'package:words_app/core/widgets/rounded_container.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return Column(
      children: List.generate(10, (_) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.centerRight,
          child: RoundedContainer(width: 100, height: 12),

          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Surah Name + Verse Number Row
          //     SizedBox(width: double.infinity),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         RoundedContainer(width: 50, height: 10),
          //         const SizedBox(width: 8),
          //         RoundedContainer(width: 10, height: 10),
          //       ],
          //     ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),

          //     const SizedBox(height: 12),

          //     RoundedContainer(width: double.infinity, height: 100),
          //   ],
          // ),
        );
      }),
    );
  }
}
