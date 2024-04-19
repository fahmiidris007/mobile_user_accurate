import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_user_accurate/presentation/pages/add_user_page.dart';
import 'package:mobile_user_accurate/presentation/pages/home_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'add',
          name: 'add',
          builder: (context, state) => const AddUserPage(),
        ),
      ],
    ),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text('Route not found: ${state.uri}'),
        ),
      ),
    );
  },
  initialLocation: '/',
  debugLogDiagnostics: true,
);
