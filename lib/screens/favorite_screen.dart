import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/models/character_model.dart';
import 'package:rickandmorty/persistence/character_repository.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  CharacterRepository characterRepository = CharacterRepository();
  List<Character> characters = [];

  @override
  initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    final favoriteCharacters = await characterRepository.getAll();

    if (mounted) {
      setState(() {
        characters = favoriteCharacters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: const Text('Favorite characters'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: characters.isEmpty
            ? noFavorites()
            : CharacterList(characters: characters),
      ),
    );
  }
}

Widget noFavorites() {
  return const Expanded(
    child: Center(
      child: Text('You have no favorite characters'),
    ),
  );
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key, required this.characters});

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return GestureDetector(
          onTap: () {
            final router = GoRouter.of(context);
            router.push('/character', extra: character);
          },
          child: Card(
            child: Column(
              children: [
                FadeInImage(
                    placeholder:
                        const AssetImage('assets/images/rick_sanchez.gif'),
                    image: NetworkImage(character.image!)),
                Center(
                  child: Text(
                    character.name!,
                    style: const TextStyle(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
