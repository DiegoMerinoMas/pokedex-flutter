import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex Básica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // Desactiva el banner de depuración
      home: PokedexScreen(),
    );
  }
}

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
      final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pageKey'));

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
        crossAxisCount: MediaQuery.of(context).size.width ~/ 150, // Ancho de cada tarjeta
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

class PokemonCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  PokemonCard({
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.red],
                stops: [0.5, 0.5],
              ),
            ),
            padding: EdgeInsets.all(4.0),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(name, textAlign: TextAlign.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ],
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchPokemonData(int id) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error al cargar datos. Código de estado: ${response.statusCode}');
  }
}


class PokemonDetailScreen extends StatelessWidget {
  final String name;

  PokemonDetailScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detalles de $name'),
            // Agrega más detalles aquí según lo que quieras mostrar
          ],
        ),
      ),
    );
  }
}