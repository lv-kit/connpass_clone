import 'package:flutter/material.dart';
import 'package:connpass_bloc/connpass_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;
  final String title;

  EventDetailScreen({
    Key key,
    @required this.event,
    this.title,
  })
      : assert(event != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Image.network("https://connpass.com/static/img/api/connpass_logo_1.png"),
                      Text(event.title)
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                  child: Html(
                    data: event.description,
                    useRichText: true,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
