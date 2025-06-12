import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .fade(duration: 1000.ms, begin: 0.2, end: 0.8);
  }
}
