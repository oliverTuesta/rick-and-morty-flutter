import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rick and Morty"),
        ),
        body: Center(
            child: Column(
          // show to buttons, the first one goes to the favorite screen and the second one goes to the all characters screen
          children: [
            const Text('Home Screen'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final router = GoRouter.of(context);
                router.push('/favorite');
              },
              child: const Text('Favorite Characters'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final router = GoRouter.of(context);
                router.push('/all');
              },
              child: const Text('All Characters'),
            ),
          ],
        )));
  }
}
