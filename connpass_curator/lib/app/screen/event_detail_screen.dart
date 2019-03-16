import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connpass_bloc/connpass_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({Key key, @required this.event})
      : assert(event != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: SafeArea(
          child: _card(context, event)
      ),
    );
  }

  Widget _card(BuildContext context, Event event) {
    return ListView(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Text(
              event.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Html(
                    data: event.description,
                    useRichText: true,
                  )
                ],
              ),
            )
        )
      ],
    );
  }
}
