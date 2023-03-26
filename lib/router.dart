import 'package:flutter/material.dart';
import 'package:reddit_clone/features/auth/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'features/home/screens/home_screen.dart';

final loggedOutRouter = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRouter = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
});
