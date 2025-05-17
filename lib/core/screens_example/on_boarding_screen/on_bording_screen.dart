import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:words_app/core/extensions/context-extensions.dart';
import 'package:words_app/core/widgets/default_screen_padding.dart';
import 'package:words_app/core/widgets/sizer.dart';
import 'package:words_app/utils/assets/assets.dart';
import 'package:words_app/utils/styles/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  void _onNextPagePressed() {
    if (_currentPage < _onBoardingData.length - 1) {
      _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    } else {
      // TODO: NAVIGATE TO THE LOGIN SCREEN
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultScreenPadding(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 500.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onBoardingData.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingContent(
                      image: _onBoardingData[index]['image'] ?? '',
                      title: _onBoardingData[index]['title'] ?? '',
                      description: _onBoardingData[index]['description'] ?? '',
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_onBoardingData.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12.w : 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? context.primaryColor : Colors.grey,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ElevatedButton(
                  onPressed: _onNextPagePressed,
                  child: txt(_currentPage == _onBoardingData.length - 1 ? 'Continue' : 'Next'),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map<String, String>> _onBoardingData = [
    {
      "image": AssetsData.onBoarding_1,
      "title": "Welcome to LocumFinder",
      "description": "Discover the best locum opportunities tailored to your needs.",
    },
    {
      "image": AssetsData.onBoarding_2,
      "title": "Easy Job Search",
      "description": "Quickly find locum positions with our advanced search filters.",
    },
    {
      "image": AssetsData.onBoarding_3,
      "title": "A Real-Time Updates",
      "description": "Stay updated with instant job alerts and important updates.",
    },
    {
      "image": AssetsData.onBoarding_4,
      "title": "Seamless Applications",
      "description": "Apply to locum jobs with just a few taps, no hassle.",
    },
    {
      "image": AssetsData.onBoarding_5,
      "title": "Manage Your Schedule",
      "description": "Effortlessly keep track of your shifts and appointments.",
    },
    {
      "image": AssetsData.onBoarding_6,
      "title": "Join Our Community",
      "description": "Connect with top healthcare facilities and fellow professionals.",
    },
  ];
}

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(300.h),
            child: Container(
              height: 300.h,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              // padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Image.asset(image, fit: BoxFit.fitHeight),
            ),
          ),
          Sizer(height: 30.h),
          txt(title, e: St.bold25, textAlign: TextAlign.center),
          Sizer(height: 15.h),
          txt(description, e: St.reg16, c: Colors.grey, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
