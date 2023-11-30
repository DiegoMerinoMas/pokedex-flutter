import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchPokemonData(int id) async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception(
        'Error al cargar datos. Código de estado: ${response.statusCode}');
  }
}
