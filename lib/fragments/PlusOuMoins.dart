import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math';

class PlusOuMoins extends StatefulWidget {
  @override
  _PlusOuMoins createState() => _PlusOuMoins();
}

class _PlusOuMoins extends State<PlusOuMoins> {
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
    return new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Text('Le nombre à deviné est : $_find'),
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
                    _txt = "C'est gagné !";
                  } else if (_value > _find) {
                    _txt = "C'est moins !";
                  } else {
                    _txt = "C'est plus !";
                  }
                });
              },
              child: Text("Répondre")),
          TextButton(
              onPressed: () {
                _generaterandom();
              },
              child: Text("Restart")),
        ],
      ),
    );
  }
}
