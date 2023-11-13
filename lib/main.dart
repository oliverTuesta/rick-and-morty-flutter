import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/character_model.dart';
import 'package:rickandmorty/provider/api_provider.dart';
import 'package:rickandmorty/screens/all_characters_screen.dart';
import 'package:rickandmorty/screens/character_screen.dart';
import 'package:rickandmorty/screens/favorite_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/screens/home_screen.dart';

final _router = GoRouter(routes: [
  GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'character',
          builder: (context, state) {
            final character = state.extra as Character;
            return CharacterScreen(character: character);
          },
        ),
        // favorite screen
        GoRoute(
            path: 'favorite',
            builder: (context, state) => const FavoriteScreen()),
        GoRoute(
            path: 'all',
            builder: (context, state) => const AllCharactersScreen()),
      ]),
]);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => ApiProvider(),
        child: MaterialApp.router(
          title: 'Rick and Morty App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
          routerConfig: _router,
        ),
      ),
    );
  }
}
