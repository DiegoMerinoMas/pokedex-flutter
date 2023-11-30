import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/main.dart';

import 'pokemon_card.dart';

class PokemonListView extends StatelessWidget {
  final PagingController<int, Map<String, dynamic>> _pagingController =
      PagingController(firstPageKey: 1);

  PokemonListView() {
    _pagingController.addPageRequestListener((pageKey) {
      fetchPokemonPage(pageKey);
    });
  }

  Future<void> fetchPokemonPage(int pageKey) async {
    try {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pageKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> pokemonData = [data];

        final isLastPage = pokemonData.isEmpty;
        if (isLastPage) {
          _pagingController.appendLastPage(pokemonData);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(pokemonData, nextPageKey);
        }
      } else {
        throw Exception(
            'Error al cargar datos. Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Map<String, dynamic>>(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.of(context).size.width ~/ 150, // Ancho de cada tarjeta
      ),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
        itemBuilder: (context, item, index) {
          final String name = item['name'];
          final String imageUrl = item['sprites']['front_default'];

          return PokemonCard(
            name: name,
            imageUrl: imageUrl,
          );
        },
      ),
    );
  }
}
