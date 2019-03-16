import 'package:flutter/material.dart';
import 'package:connpass_curator/app/screen/event_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connpass_bloc/connpass_bloc.dart';

class EventListScreen extends StatefulWidget {
  final ConnpassRepository connpassRepository;

  const EventListScreen({
    Key key,
    @required this.connpassRepository
  }) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  EventsBloc _eventsBloc;

  @override
  void initState() {
    super.initState();
    _eventsBloc = EventsBloc(
        connpassRepository: widget.connpassRepository
    );
    _eventsBloc.dispatch(FetchEvents());
  }

  @override
  void dispose() {
    _eventsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _bloc(context, _eventsBloc),
    );
  }

  Widget _bloc(BuildContext context, EventsBloc _eventsBloc) {
    return BlocBuilder(
      bloc: _eventsBloc,
      builder: (BuildContext context, EventsState state) {
        if (state is EventsStateEmpty) {
          return Text("no data");
        } else if (state is EventsStateLoading) {
          return CircularProgressIndicator();
        } else if (state is EventsStateError) {
          print(EventsStateError());
          return Text("$EventsStateError()");
        } else if (state is EventsStateSuccess) {
          return state.events.events.isEmpty
              ? Text("No Results")
              : _listTile(context, state.events.events);
        }
      },
    );
  }

  Widget _listTile(BuildContext context, events) {
    return ListView.builder(
      itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Image.network("https://connpass.com/static/img/api/connpass_logo_1.png"),
                  backgroundColor: Colors.white,
                ),
                title: Text(events[index].title),
                subtitle: Text(events[index].catchText),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  print(widget.connpassRepository);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => EventDetailScreen(
                        event: events[index],
                        title: events[index].title,
                      )
                  ));
                },
              ),
              Divider()
            ],
          );
        }
    );
  }
}

