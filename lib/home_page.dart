import 'package:first_app/fragments/Boussole.dart';
import 'package:first_app/fragments/Like.dart';
import 'package:first_app/fragments/PlusOuMoins.dart';
import 'package:first_app/fragments/Fraction.dart';
import 'package:first_app/fragments/Pendu.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Plus ou Moins", Icons.games),
    new DrawerItem("Fraction", Icons.calculate),
    new DrawerItem("Pendu", Icons.gamepad),
    new DrawerItem("Likes", Icons.thumb_up),
    new DrawerItem("Boussole", Icons.explore),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 4;

  Widget _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new PlusOuMoins();
      case 1:
        return new Fraction();
      case 2:
        return new Pendu();
      case 3:
        return new Like();
      case 4:
        return new Boussole();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Romain Bondevine"), accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
