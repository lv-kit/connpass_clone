import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:bloc/bloc.dart';

import 'package:connpass_bloc/connpass_bloc.dart';

import 'package:connpass_curator/app/app.dart';

// デバッグ用
// 以下のような表示形式で現在のstateとeventを示してくれる
// flutter: Transition { currentState: Instance of 'AppInfoEmpty', event: Instance of 'FetchAppVersion', nextState: appVersion }
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  // 画面の向きを縦向きに限定
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]
  );

  final ConnpassRepository connpassRepository = ConnpassRepository(
      ConnpassClient()
  );
  BlocSupervisor().delegate = SimpleBlocDelegate();
  enableFlutterDriverExtension();
  runApp(Connpass(connpassRepository: connpassRepository,));
}

class Connpass extends StatelessWidget {
  final ConnpassRepository connpassRepository;

  const Connpass({
    Key key,
    @required this.connpassRepository
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connpass Curator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: App(connpassRepository: connpassRepository,),
        title: new Text('Connpass',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
        image: Image.network('https://connpass.com/static/img/api/connpass_logo_1.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        '/app': (BuildContext context) => App(connpassRepository: connpassRepository,),
      }
    );
  }
}
