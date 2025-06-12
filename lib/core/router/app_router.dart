import 'package:flutter/material.dart';
import 'package:words_app/core/router/app_routes_names.dart';
import 'package:words_app/core/router/middleware.dart';
import 'package:words_app/core/screens_example/splash_screen/splash_screen.dart';
import 'package:words_app/core/widgets/ui_components_screen.dart';
import 'package:words_app/features/home/presentation/home_view.dart';
import 'package:words_app/features/home/presentation/verses_view.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(
          builder: (context) => const SplashScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.uiComponentScreen:
        return CustomPageRoute(
          builder: (context) => const UiComponentScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.homeView:
        return CustomPageRoute(
          builder: (context) => const HomeView(),
          settings: routeSettings,
        );
      case AppRoutesNames.versesView:
        return CustomPageRoute(
          builder:
              (context) =>
                  VersesView(rootId: (args as Map<String, dynamic>)['rootId']),
          settings: routeSettings,
        );

      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({
    required super.builder,
    required RouteSettings super.settings,
  });
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
