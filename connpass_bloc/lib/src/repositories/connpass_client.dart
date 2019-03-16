import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:connpass_bloc/connpass_bloc.dart';

class ConnpassClient {
  final String baseUrl;
  final http.Client httpClient;

  ConnpassClient({
    http.Client httpClient,
    this.baseUrl = "https://connpass.com/api/v1"
  }) : this.httpClient = httpClient ?? http.Client();

  // イベント一覧取得
  Future<Events> getEvents() async {
    print("getEvents() client");
    final response = await httpClient.get(Uri.parse("$baseUrl/event/"));
    final result = json.decode(response.body);

    if ( response.statusCode == 200 ) {
//      print(result);
      print("success");
      return Events.fromJson(result);
    } else {
      print('error');
      throw ResultError.fromJson(result);
    }
  }

  // イベント検索結果一覧取得
  Future<Events> getSearchResultEvents(String keyword) async {
    final response = await httpClient.get(Uri.parse("$baseUrl/event/?keyword=$keyword"));
    final result = json.decode(response.body);

    if ( response.statusCode == 200 ) {
      print("success");
      return Events.fromJson(result);
    } else {
      print('error');
      throw ResultError.fromJson(result);
    }
  }

  // イベント詳細取得
  Future<Event> getEvent(String eventId) async {
    final response = await httpClient.get(Uri.parse("$baseUrl/event/?event_id=$eventId"));
    final result = json.decode(response.body);

    if ( response.statusCode == 200 ) {
      print("success");
      print(result);
      return Event.fromJson(result.events[0]);
    } else {
      print('error');
      throw ResultError.fromJson(result);
    }
  }

  Future<String> hello(String word) async {
    return word;
  }
}