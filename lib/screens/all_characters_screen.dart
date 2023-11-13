import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/provider/api_provider.dart';
import 'package:rickandmorty/widgets/character_list.dart';

class AllCharactersScreen extends StatefulWidget {
  const AllCharactersScreen({super.key});

  @override
  State<AllCharactersScreen> createState() => _AllCharactersScreenState();
}

class _AllCharactersScreenState extends State<AllCharactersScreen> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacters(page);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        apiProvider.getCharacters(page).then((_) {
          setState(() {
            isLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Rick and Morty"),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: apiProvider.characters.isNotEmpty
              ? CharacterList(
                  characters: apiProvider.characters,
                  scrollController: scrollController,
                  isLoading: isLoading,
                )
              : const Center(child: CircularProgressIndicator()),
        ));
  }
}
