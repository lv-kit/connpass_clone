import 'package:equatable/equatable.dart';
import './event.dart';

class Events extends Equatable {
  final int resultReturned;
  final List<Event> events;
  final int resultsStart;
  final int resultsAvailable;

  Events({
    this.resultReturned,
    this.events,
    this.resultsStart,
    this.resultsAvailable
  }) : super([
    resultReturned,
    events,
    resultsStart,
    resultsAvailable
  ]);

  static Events fromJson(Map<String, dynamic> json) {
    final events = (json['events'] as List)?.map((e) => e == null
        ? null : Event.fromJson(e as Map<String, dynamic>))?.toList();
    return Events(
      resultReturned: json['results_returned'] as int,
      events: events,
      resultsStart: json['results_start'] as int,
      resultsAvailable: json['results_available'] as int,
    );
  }
}