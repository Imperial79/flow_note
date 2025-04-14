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
    initialLocation: "/login",
    redirect: (context, state) {
      log("${state.fullPath}");
      if (authState.isLoading) return "/splash";

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
      if (user != null && state.fullPath == '/login') {
        return '/';
      }

      return null;
    },
    routes: [
      // GoRoute(
      //   path: '/server-error',
      //   builder: (context, state) => const Server_Error_UI(),
      // ),
      GoRoute(path: "/splash", builder: (context, state) => Splash_UI()),

      GoRoute(path: "/", builder: (context, state) => Root_UI()),
      GoRoute(path: "/login", builder: (context, state) => Login_UI()),
      // GoRoute(path: "/register", builder: (context, state) => Register_UI()),
      // GoRoute(
      //   path: "/forgot-password",
      //   builder: (context, state) => Forgot_Password_UI(),
      // ),
    ],
  );
});
