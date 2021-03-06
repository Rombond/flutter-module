import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Jeu du plus ou moins'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Random _random = Random();
  int _find = Random().nextInt(101);
  final _myTF = TextEditingController();
  String _txt = "Devine le nombre entre 0 et 100";

  void _generaterandom() {
    setState(() {
      _find = _random.nextInt(101);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(80.0),
              child: Text('Le nombre ?? devin?? est : $_find'),
            ),
            Text('$_txt'),
            TextField(
              controller: _myTF,
              decoration: InputDecoration(
                hintText: 'Entrez votre nombre',
                contentPadding: EdgeInsets.all(15.0),
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    int _value = int.parse(_myTF.text);
                    if (_value == _find) {
                      _txt = "C'est gagn?? !";
                    } else if (_value > _find) {
                      _txt = "C'est moins !";
                    } else {
                      _txt = "C'est plus !";
                    }
                  });
                },
                child: Text("R??pondre")),
            TextButton(
                onPressed: () {
                  _generaterandom();
                },
                child: Text("Restart")),
          ],
        ),
      ),
    );
  }
}
