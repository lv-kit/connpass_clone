import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:connpass_bloc/connpass_bloc.dart';

abstract class EventsEvent extends Equatable {
  EventsEvent([List props = const []]) : super(props);
}

class FetchEvents extends EventsEvent {
  @override
  String toString() => 'FetchEvents';
}

class FetchSearchResultEvents extends EventsEvent {
  final String keyword;

  FetchSearchResultEvents({this.keyword}) : super([keyword]);

  @override
  String toString() => 'FetchSearchResultEvents { keyword: $keyword }';
}

class FetchHello extends EventsEvent {}

abstract class EventsState extends Equatable {
  EventsState([List props = const []]) : super(props);
}

class EventsStateEmpty extends EventsState {
  @override
  String toString() => 'EventsStateEmpty';
}

class EventsStateLoading extends EventsState {
  @override
  String toString() => 'EventsStateLoading';
}

class EventsStateSuccess extends EventsState {
  final Events events;

  EventsStateSuccess({this.events}) : super([events]);

  @override
  String toString() => 'EventsSuccess { items: $events }';
}

class HelloStateSuccess extends EventsState {
  final String event;

  HelloStateSuccess({this.event}) : super([event]);

  @override
  String toString() => 'HelloStateSuccess { items: $event }';
}

class EventsStateError extends EventsState {
  @override
  String toString() => 'EventsError';
}

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final ConnpassRepository connpassRepository;

  EventsBloc({@required this.connpassRepository}) : assert(ConnpassRepository != null);

  @override
  EventsState get initialState => EventsStateEmpty();

  Stream<EventsState> mapEventToState(
      EventsState currentState,
      EventsEvent event,
  ) async* {
    if (event is FetchEvents) {
      yield EventsStateLoading();
      try {
        final events = await connpassRepository.getEvents();
        yield EventsStateSuccess(events: events);
      } catch (_) {
        print("=====");
        print(_);
        print("=====");
        yield EventsStateError();
      }
    } else if (event is FetchSearchResultEvents) {
      yield EventsStateLoading();
      try {
        final events = await connpassRepository.getSearchResultEvents(keyword: event.keyword);
        print("=====");
        print(events);
        print("=====");
        yield EventsStateSuccess(events: events);
      } catch (_) {
        print("=====");
        print(_);
        print("=====");
        yield EventsStateError();
        print("=====");
        print(_);
        print("=====");
      }
    } else if (event is FetchHello) {
      yield EventsStateLoading();
      try {
        print(event);
        final event_content = await connpassRepository.hello("hello");
        yield HelloStateSuccess(event: event_content);
        print(event_content);
      } catch (_) {
        print(_);
        yield EventsStateError();
      }
    }
  }
}