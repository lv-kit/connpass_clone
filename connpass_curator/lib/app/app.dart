import 'package:flutter/material.dart';
import 'package:connpass_curator/app/screen/event_list_screen.dart';

import 'package:connpass_bloc/connpass_bloc.dart';

class App extends StatelessWidget {
  final ConnpassRepository connpassRepository;

  const App({
    Key key,
    @required this.connpassRepository
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connpass"),
      ),
      body: SafeArea(
          child: EventListScreen(connpassRepository: this.connpassRepository)
      ),
    );
  }
}
