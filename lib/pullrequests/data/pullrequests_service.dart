import 'pullrequests_dto.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<List<Pullrequest>> fetchPulls(final String pulls) async {
  final response = await http.get(pulls);

  if (response.statusCode == 200) {
    return compute(parsePullrequest, response.body);
  } else {
    throw Exception('Failed to load pullrequests');
  }
}

List<Pullrequest> parsePullrequest(String response) {
  final List items = json.decode(response);
  return items.map((item) => Pullrequest.fromJSON(item)).toList();
}
