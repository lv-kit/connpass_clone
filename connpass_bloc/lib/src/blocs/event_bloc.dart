import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:connpass_bloc/connpass_bloc.dart';

abstract class EventEvent extends Equatable {
  EventEvent([List props = const []]) : super(props);
}

class FetchEvent extends EventEvent {
  final String eventId;

  FetchEvent({this.eventId}) : super([eventId]);

  @override
  String toString() => 'FetchEvent $eventId';
}

abstract class EventState extends Equatable {
  EventState([List props = const []]) : super(props);
}

class EventStateEmpty extends EventState {
  @override
  String toString() => 'EventStateEmpty';
}

class EventStateLoading extends EventState {
  @override
  String toString() => 'EventStateLoading';
}

class EventStateSuccess extends EventState {
  final Event event;

  EventStateSuccess({this.event}) : super([event]);

  @override
  String toString() => 'EventsSuccess { items: $event }';
}

class EventStateError extends EventState {
  @override
  String toString() => 'EventStateError';
}

class EventBloc extends Bloc<EventEvent, EventState> {
  final ConnpassRepository connpassRepository;

  EventBloc({@required this.connpassRepository}) : assert(ConnpassRepository != null);

  @override
  EventState get initialState => EventStateEmpty();

  @override
  Stream<EventState> mapEventToState(
      EventState currentState,
      EventEvent event,
  ) async* {
    if (event is FetchEvent) {
      yield EventStateLoading();
      try {
        print(event.eventId);
        final event_content = await connpassRepository.getEvent(eventId: event.eventId);
        print(event_content);
        yield EventStateSuccess(event: event_content);
        print(event_content);
      } catch (_) {
        print(_);
        yield EventStateError();
      }
    }
  }
}