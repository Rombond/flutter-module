import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Pendu extends StatefulWidget {
  @override
  _Pendu createState() => _Pendu();
}

class _Pendu extends State<Pendu> {
  final _myTF = TextEditingController();
  String _txt = "Devine le mot";
  String _word;
  List<String> answer = [];
  Random _random = Random();
  List data;
  int erreur = 0;
  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/dictionnaire.json');
    var _data = await json.decode(jsonText);
    setState(() {
      data = _data["dico"];
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
    Future.delayed(Duration(seconds: 2), () {
      setword();
    });
  }

  void setword() {
    setState(() {
      answer.clear();
      _myTF.clear();
      erreur = 0;
      int index = _random.nextInt(data.length);
      _word = data[index]['mot'];
      _txt = "";
      for (var i = 0; i < _word.length; i++) {
        _txt += "_ ";
      }
    });
  }

  void actualiser() {
    setState(() {
      if (erreur >= 8) {
        _txt = "Perdu, le mot était $_word";
      } else {
        bool finish = true;
        _txt = "";
        for (var i = 0; i < _word.length; i++) {
          if (answer.contains(_word[i])) {
            _txt += _word[i] + " ";
          } else {
            _txt += "_ ";
            finish = false;
          }
        }
        if (finish) {
          _txt = "Bien joué, le mot était $_word";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text('$_word'),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text('$_txt'),
              Spacer(),
              Text('$erreur erreurs / 8'),
              Spacer(),
            ],
          ),
          Spacer(),
          TextField(
            controller: _myTF,
            decoration: InputDecoration(
              hintText: 'Entrez une lettre ou un mot',
              contentPadding: EdgeInsets.all(15.0),
              isDense: true,
            ),
            keyboardType: TextInputType.name,
            autofocus: true,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  String player = _myTF.text;
                  if (answer.contains(player)) {
                    erreur++;
                  } else {
                    if (player == _word) {
                      answer.clear();
                      answer.addAll(player.split(''));
                    } else if (player.length == 1) {
                      if (_word.contains(player)) {
                        answer.add(player);
                      } else {
                        erreur++;
                      }
                    } else {
                      erreur++;
                      return;
                    }
                  }
                  actualiser();
                  _myTF.clear();
                });
              },
              child: Text("Proposer")),
          Spacer(),
          TextButton(
              onPressed: () {
                setword();
              },
              child: Text("Restart"))
        ]));
  }
}
