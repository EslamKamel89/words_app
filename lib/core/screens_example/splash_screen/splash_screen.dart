import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:words_app/core/extensions/context-extensions.dart';
import 'package:words_app/core/router/app_routes_names.dart';
import 'package:words_app/utils/assets/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.homeView, (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: context.secondaryHeaderColor,
        body: Stack(
          children: [
            // Animated background glow
            Positioned.fill(
              child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0.3, -0.4),
                        radius: 1.2,
                        colors: [Color(0x332196F3), Colors.transparent],
                      ),
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .fadeIn(duration: 2.seconds)
                  .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.05, 1.05)),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo animation
                  Image.asset(AssetsData.logo, width: 140)
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(begin: const Offset(0.6, 0.6), curve: Curves.easeOutBack)
                      .rotate(begin: -0.05, end: 0)
                      .shimmer(duration: 2.seconds, angle: math.pi / 4),

                  const SizedBox(height: 32),

                  // Title
                  const Text(
                        'المرجع',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: Colors.black,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 800.ms)
                      .slideY(begin: 0.4, curve: Curves.easeOut)
                      .blurXY(begin: 12, end: 0),

                  const SizedBox(height: 12),

                  // Subtitle
                  const Text(
                        'بوابتك إلى المعاني والكلمات',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 1.seconds, duration: 800.ms)
                      .slideY(begin: 0.6)
                      .scale(begin: const Offset(0.95, 0.95)),

                  const SizedBox(height: 40),

                  // Loading dots
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3, (i) {
                      return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          )
                          .animate(delay: (300 * i).ms, onPlay: (c) => c.repeat())
                          .fadeIn()
                          .scale(begin: const Offset(0.3, 0.3))
                          .then()
                          .scale(begin: const Offset(1, 1), end: const Offset(0.3, 0.3))
                          .then()
                          .fadeOut();
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
