import 'dart:async';

import 'package:connpass_bloc/connpass_bloc.dart';

class ConnpassRepository {
  final ConnpassClient connpassClient;

  ConnpassRepository(this.connpassClient);

  // イベント一覧取得
  Future<Events> getEvents() async {
    print("repository");
    final result = await connpassClient.getEvents();
//    print(result);
    return result;
  }

  // イベント検索結果一覧取得
  Future<Events> getSearchResultEvents({String keyword}) async {
    final result = await connpassClient.getSearchResultEvents(keyword);
    return result;
  }

  // イベント詳細取得
  Future<Event> getEvent({String eventId}) async {
    print("repository event");
    final result = await connpassClient.getEvent(eventId);
    print(result);
    return result;
  }

  Future<String> hello(String word) async {
    final result = await connpassClient.hello(word);
    return result;
  }
}