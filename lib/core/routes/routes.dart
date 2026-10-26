import 'package:go_router/go_router.dart';
import 'package:masrofy/features/auth/view/pages/auth_page.dart';
import 'package:masrofy/features/goals/view/goals_page.dart';
import 'package:masrofy/features/home/view/pages/home_page.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.auth,
  debugLogDiagnostics: true,
  /*
  debugLogDiagnostics: true
  [GoRouter] Full paths for routes:
  => /
  => /login
  => /home
[GoRouter] setting initial location /
[GoRouter] going to /login
   */
  routes: [
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.goals,
      builder: (context, state) => const GoalsPage(),
    ),
  ],
);
