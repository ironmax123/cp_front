import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/analysis/page.dart';
import '../pages/page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      path: '/analysis',
      name: 'analyis',
      pageBuilder: (context, state) {
        final data = state.extra as String;
        return MaterialPage(
          key: state.pageKey,
          child: AnalysisPage(response: data),
        );
      },
    ),
  ],
);
