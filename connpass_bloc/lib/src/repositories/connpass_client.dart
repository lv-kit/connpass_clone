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
    final response = await httpClient.get(Uri.parse("$baseUrl/event/"));
    final result = json.decode(response.body);

    if ( response.statusCode == 200 ) {
      return Events.fromJson(result);
    } else {
      throw ResultError.fromJson(result);
    }
  }

  // イベント検索結果一覧取得
  Future<Events> getSearchResultEvents(String keyword) async {
    final response = await httpClient.get(Uri.parse("$baseUrl/event/?keyword=$keyword"));
    final result = json.decode(response.body);

    if ( response.statusCode == 200 ) {
      return Events.fromJson(result);
    } else {
      throw ResultError.fromJson(result);
    }
  }

  // イベント詳細取得
  Future<Events> getEvent(String eventId) async {
    final response = await httpClient.get(Uri.parse("$baseUrl/event?event_id=$eventId"));
    final result = json.decode(response.body);
    print("===client===");
    print(result);
    print("===");

    if ( response.statusCode == 200 ) {
      return Events.fromJson(result.events);
    } else {
      throw ResultError.fromJson(result);
    }
  }
}