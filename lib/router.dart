import 'package:flutter/material.dart';
import 'package:reddit_clone/features/auth/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'features/community/screens/community_screen.dart';
import 'features/community/screens/create_community_screen.dart';
import 'features/community/screens/edit_community_screen.dart';
import 'features/community/screens/mod_tools_screen.dart';
import 'features/home/screens/home_screen.dart';

final loggedOutRouter = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRouter = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(
          name: route.pathParameters['name']!,
        ),
      ),
  '/mod-tools/:name': (route) => MaterialPage(
        child: ModToolsScreen(
          name: route.pathParameters['name']!,
        ),
      ),
  '/edit-community/:name': (route) => MaterialPage(
        child: EditCommunityScreen(
          name: route.pathParameters['name']!,
        ),
      ),
});
