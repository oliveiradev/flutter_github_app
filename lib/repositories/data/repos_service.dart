import 'package:github_app/repositories/data/repos_dto.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<List<Repo>> fetchRepos() async {
  final response = await http.get("https://api.github.com/repositories");

  if (response.statusCode == 200) {
    return compute(parseRepos, response.body);
  } else {
    throw Exception('Failed to load repositories');
  }
}

List<Repo> parseRepos(String response) {
  final List items = json.decode(response);
  return items.map((item) => Repo.fromJSON(item)).toList();
}
