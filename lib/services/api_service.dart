import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/show_model.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _baseUrl = 'https://www.freetogame.com/api';
  Future<List<ShowModel>> fetchShows() async {
    final response = await _client.get(Uri.parse('$_baseUrl/games'));
    _ensureSuccess(response);
    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded.whereType<Map<String, dynamic>>().map(_parseShow).toList();
  }

  Future<ShowModel> fetchShow(int id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/game?id=$id'));
    _ensureSuccess(response);
    return _parseShow(jsonDecode(response.body) as Map<String, dynamic>);
  }

  ShowModel _parseShow(Map<String, dynamic> json) {
    final screenshotData = json['screenshots'] as List<dynamic>?;
    return ShowModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'Untitled game',
      thumbnail: json['thumbnail'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      platform: json['platform'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      summary: json['short_description'] as String? ?? '',
      description:
          json['description'] as String? ??
          json['short_description'] as String? ??
          '',
      screenshots:
          screenshotData
              ?.whereType<Map<String, dynamic>>()
              .map((item) => item['image'] as String?)
              .whereType<String>()
              .toList() ??
          const [],
    );
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('FreeToGame request failed (${response.statusCode})');
    }
  }
}
