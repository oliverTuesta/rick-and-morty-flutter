import 'package:flutter/material.dart';
import 'package:rickandmorty/models/character_model.dart';
import 'package:rickandmorty/persistence/character_repository.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key, required this.character});

  final Character character;

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  CharacterRepository characterRepository = CharacterRepository();
  late Character character;

  bool isFavorite = false;

  @override
  initState() {
    character = widget.character;
    initialize();
    super.initState();
  }

  initialize() async {
    final exist = await characterRepository.existById(widget.character.id!);
    setState(() {
      isFavorite = exist;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void handleToggleFavorite() {
      setState(() {
        isFavorite = !isFavorite;
      });
      if (isFavorite) {
        characterRepository.insert(widget.character);
      } else {
        characterRepository.delete(widget.character);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.character.name!),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 32),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Hero(
                  tag: widget.character.id!,
                  child: Image(image: NetworkImage(widget.character.image!))),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: size.height * 0.14,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardDataRow('Status', widget.character.status!),
                  cardDataRow('Species', widget.character.species!),
                  cardDataRow('Origin', widget.character.origin!),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: size.height * 0.18,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardDataColumn('Gender', widget.character.gender!),
                  cardDataColumn(
                      'Current Location', widget.character.location!),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: IconButton(
                onPressed: handleToggleFavorite,
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                iconSize: 50,
                color: isFavorite ? Colors.redAccent : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget cardDataRow(String text1, String text2) {
  Color color;
  switch (text2) {
    case 'Alive':
      color = Colors.lightBlueAccent;
      break;
    case 'Dead':
      color = Colors.redAccent;
      break;
    default:
      color = Colors.grey;
  }
  return Expanded(
    child: Card(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text1),
          Text(
            text2,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    ),
  );
}

Widget cardDataColumn(String text1, String text2) {
  return Expanded(
    child: Card(
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text(text1),
          const Icon(Icons.arrow_right),
          const SizedBox(width: 8),
          Text(text2),
        ],
      ),
    ),
  );
}
