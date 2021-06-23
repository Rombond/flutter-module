import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Fraction extends StatefulWidget {
  @override
  _Fraction createState() => _Fraction();
}

class _Fraction extends State<Fraction> {
  final _num = TextEditingController();
  final _denum = TextEditingController();
  String _answer = "";
  int segmentedControlGroupValue = 0;
  Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Fraction 1"),
    1: Text("Fraction 2")
  };
  Map<int, MathFraction> fractions = <int, MathFraction>{
    0: MathFraction.basique(2),
    1: MathFraction.basique(3)
  };
  String dropdownValue = '>';

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          CupertinoSlidingSegmentedControl(
              groupValue: segmentedControlGroupValue,
              children: myTabs,
              onValueChanged: (i) {
                setState(() {
                  segmentedControlGroupValue = i;
                });
              }),
          SizedBox(
            width: 60,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _num,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  Divider(
                    thickness: 5,
                    color: Colors.black,
                  ),
                  TextField(
                    controller: _denum,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      fractions[segmentedControlGroupValue] = MathFraction(
                          int.parse(_num.text), int.parse(_denum.text));
                    });
                  },
                  child: Text("Replace")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      fractions[segmentedControlGroupValue] =
                          fractions[segmentedControlGroupValue].reduce();
                    });
                  },
                  child: Text("Reduce")),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text(fractions[0].toString()),
              Spacer(),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['>', '>=', '==', '<=', "<"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Spacer(),
              Text(fractions[1].toString()),
              Spacer(),
            ],
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  bool ans;
                  switch (dropdownValue) {
                    case '>':
                      ans = fractions[0] > fractions[1];
                      break;
                    case '>=':
                      ans = fractions[0] >= fractions[1];
                      break;
                    case '==':
                      ans = fractions[0] == fractions[1];
                      break;
                    case '<=':
                      ans = fractions[0] <= fractions[1];
                      break;
                    case '<':
                      ans = fractions[0] < fractions[1];
                      break;
                    default:
                      _answer = "error switch dropdown";
                  }
                  _answer = ans ? "C'est vrai" : "C'est faux";
                });
              },
              child: Text("Check")),
          Text('$_answer'),
          Spacer(),
        ],
      ),
    );
  }
}

class MathFraction {
  int _numerateur, _denominateur;

  MathFraction(this._numerateur, this._denominateur);
  MathFraction.basique(int denom) {
    this._numerateur = 1;
    this._denominateur = denom;
  }

  double get value => _numerateur / _denominateur;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    MathFraction m = other;
    return (m._numerateur == this._numerateur &&
        m._denominateur == this._denominateur);
  }

  @override
  bool operator <(dynamic other) {
    MathFraction m = other;
    return (this.value < m.value);
  }

  @override
  bool operator <=(dynamic other) {
    MathFraction m = other;
    return (this.value <= m.value);
  }

  @override
  bool operator >(dynamic other) {
    MathFraction m = other;
    return (this.value > m.value);
  }

  @override
  bool operator >=(dynamic other) {
    MathFraction m = other;
    return (this.value >= m.value);
  }

  @override
  MathFraction operator +(dynamic other) {
    MathFraction f2 = other;
    MathFraction f1 = this;
    f1._numerateur *= f2._denominateur;
    f2._numerateur *= f1._denominateur;
    return MathFraction(
        f1._numerateur + f2._numerateur, f1._denominateur * f2._denominateur);
  }

  @override
  MathFraction operator -(dynamic other) {
    MathFraction f2 = other;
    MathFraction f1 = this;
    f1._numerateur *= f2._denominateur;
    f2._numerateur *= f1._denominateur;
    return MathFraction(
        f1._numerateur - f2._numerateur, f1._denominateur * f2._denominateur);
  }

  @override
  MathFraction operator *(dynamic other) {
    MathFraction f2 = other;
    MathFraction f1 = this;
    return MathFraction(
        f1._numerateur * f2._numerateur, f1._denominateur * f2._denominateur);
  }

  @override
  MathFraction operator /(dynamic other) {
    MathFraction f2 = other;
    MathFraction f1 = this;
    return MathFraction(
        f1._numerateur * f2._denominateur, f1._denominateur * f2._numerateur);
  }

  @override
  String toString() {
    return (this._numerateur.toString() +
        " / " +
        this._denominateur.toString());
  }

  MathFraction reduce() {
    int r, a = this._numerateur, b = this._denominateur;
    if (a < b) {
      a = b;
      b = this._numerateur;
    }
    r = a % b;
    while (r != 0) {
      a = b;
      b = r;
      r = a % b;
    }
    return MathFraction(
        (this._numerateur / b).toInt(), (this._denominateur / b).toInt());
  }
}
