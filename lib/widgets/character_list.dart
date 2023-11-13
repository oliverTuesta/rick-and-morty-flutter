import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/models/character_model.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({
    super.key,
    required this.characters,
    required this.scrollController,
    required this.isLoading,
  });

  final List<Character> characters;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      controller: scrollController,
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
