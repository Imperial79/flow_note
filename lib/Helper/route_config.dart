import 'dart:developer';

import 'package:flow_note/Pages/Auth/Login_UI.dart';
import 'package:flow_note/Pages/Auth/Splash_UI.dart';
import 'package:flow_note/Pages/Root_UI.dart';
import 'package:flow_note/Repo/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routeProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authFuture);
  final user = ref.watch(userProvider);

  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      log("${state.fullPath}");

      // Redirect to splash screen while auth state is loading
      if (authState.isLoading) return "/splash";

      // Redirect to login if user is not authenticated and accessing a protected route
      if (user == null &&
          ![
            '/login',
            '/register',
            '/forgot-password',
            '/welcome',
            '/splash',
          ].contains(state.fullPath)) {
        return '/login';
      }

      // Redirect to home if user is authenticated and tries to access login
      if (user != null && state.fullPath == '/login') {
        return '/';
      }

      // Allow navigation to the requested route
      return null;
    },
    routes: [
      GoRoute(path: "/splash", builder: (context, state) => Splash_UI()),
      GoRoute(path: "/", builder: (context, state) => Root_UI()),
      GoRoute(path: "/login", builder: (context, state) => Login_UI()),
      // Add other routes as needed
    ],
  );
});
