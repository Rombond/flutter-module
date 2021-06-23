import 'package:flutter/material.dart';

class Like extends StatefulWidget {
  @override
  _Like createState() => _Like();
}

class _Like extends State<Like> {
  int _nbPush = 0;
  int _like = 0;
  double _rapport = null;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Vous avez cliquez $_nbPush de fois sur les buttons"),
          Text(''),
          LinearProgressIndicator(
            value: _rapport,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.red,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _like++;
                    _nbPush++;
                    _rapport = _like / _nbPush;
                  });
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Icon(Icons.thumb_up),
              ),
              Text('   '),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _nbPush++;
                    _rapport = _like / _nbPush;
                  });
                },
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Icon(Icons.thumb_down),
              ),
            ],
          ),
          Text("$_like Likes        ${_like - _nbPush} Dislikes"),
        ],
      ),
    );
  }
}
