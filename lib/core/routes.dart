import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/features/main_ui/presentation/pages/weather_page.dart';
import 'package:weather_app/features/settings/presentation/pages/settings_page.dart';

final GoRouter route = GoRouter(
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/settings_page',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const SafeArea(child: WeatherPage()),
    )
  ],
);
