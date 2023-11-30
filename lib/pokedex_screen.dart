import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';

import 'pokemon_list_view.dart';

class PokedexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
        leading: PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return {'Opción 1', 'Opción 2', 'Opción 3'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Acción cuando se presiona el ícono de búsqueda
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Acción cuando se presiona el ícono de favoritos
            },
          ),
          IconButton(
            icon: Icon(Icons.sports_baseball),
            onPressed: () {
              // Acción cuando se presiona el ícono de la pokeball
            },
          ),
        ],
      ),
      body: PokemonListView(),
    );
  }
}
