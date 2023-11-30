import 'package:flutter/material.dart';

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
