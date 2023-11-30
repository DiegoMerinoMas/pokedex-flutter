import 'package:flutter/material.dart';

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
