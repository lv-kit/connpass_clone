import 'dart:async';

import 'package:connpass_bloc/connpass_bloc.dart';

class ConnpassRepository {
  final ConnpassClient connpassClient;

  ConnpassRepository(this.connpassClient);

  // イベント一覧取得
  Future<Events> getEvents() async {
    final result = await connpassClient.getEvents();
    return result;
  }

  // イベント検索結果一覧取得
  Future<Events> getSearchResultEvents({String keyword}) async {
    final result = await connpassClient.getSearchResultEvents(keyword);
    return result;
  }

  // イベント詳細取得
  Future<Events> getEvent({String eventId}) async {
    final result = await connpassClient.getEvent(eventId);
    print("===");
    print(result);
    print("===");
    return result;
  }
}