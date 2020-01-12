import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passgen',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.teal,
          accentColor: Colors.teal),
      home: MyHomePage(title: 'Passgen'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> passComponents = [
    PassComponent(typePassComponent: TypePassComponent.alphanumeric, size: 10),
    PassComponent(typePassComponent: TypePassComponent.randomletters, size: 50),
    PassComponent(typePassComponent: TypePassComponent.uppercaseletters, size: 15),
  ];

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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10),
            itemCount: passComponents.length + 1,
            itemBuilder: (BuildContext context, int i) {
              if (i == passComponents.length) {
                return AddComponentButton();
              }
              debugPrint(i.toString());
              return passComponents[i];
            },
            separatorBuilder: (BuildContext context, int index) =>
                VerticalDivider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text.rich(TextSpan(
          text: 'Generate',
          style: TextStyle(
              fontFamily: 'Courier New',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        )),
        icon: Icon(Icons.autorenew),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addComponent() {}
}

class PassComponent extends StatefulWidget {
  TypePassComponent typePassComponent;
  int size;

  PassComponent({this.typePassComponent, this.size}){
  }

  @override
  State<StatefulWidget> createState() {
    debugPrint('New component');
    return _PasscomponentState();
  }
}

class _PasscomponentState extends State<PassComponent> {
  String passwordCharacters = "";
  Color color;
  String typeString;

  @override
  Widget build(BuildContext context) {
    _typeInterpreter();
    return FlatButton(
      color: color,
      onPressed: () {},
      child: Center(
        child: Text(
          typeString,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
  /* PassComponent.custom(String passwordCharacters, int size) {
    typePassComponent = TypePassComponent.custom;
    this.size = size;
  } */

  void _typeInterpreter() {
    switch (widget.typePassComponent) {
      case TypePassComponent.alphanumeric:
        color = Colors.indigo;
        typeString = 'Alphanumeric';
        break;
      case TypePassComponent.randomletters:
        color = Colors.deepPurple;
        typeString = 'Random\nletters';
        break;
      case TypePassComponent.uppercaseletters:
        color = Colors.orangeAccent;
        typeString = 'Uppercase\nletters';
        break;
      case TypePassComponent.lowercaseletters:
        color = Colors.redAccent;
        typeString = 'Lowercase\nletters';
        break;
      case TypePassComponent.pin:
        color = Colors.purpleAccent;
        typeString = 'Pin';
        break;
      case TypePassComponent.custom:
        color = Colors.blueGrey;
        typeString = 'Custom';
        break;
    }
  }
}

class AddComponentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Color.fromARGB(100, 128, 139, 150),
      onPressed: () {
        debugPrint('fied');
        PassComponent(typePassComponent: TypePassComponent.pin, size: 20);
        //_neverSatisfied(context);
        AddComponentDialog();
      },
      child: Container(
        child: Flex(
          children: <Widget>[
            Icon(Icons.add),
            Text('Add'),
          ],
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        height: 80,
        width: 80,
        alignment: Alignment.center,
      ),
    );
  }

  Future<void> _neverSatisfied(BuildContext context) async {
    debugPrint('neverSatisfied');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class AddComponentDialog extends StatefulWidget {

  AddComponentDialog(){
    debugPrint('tisfied 1');
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    debugPrint('tisfied 2');
    return _AddComponentDialog();
  }
}

class _AddComponentDialog extends State<AddComponentDialog> {
  @override
  Widget build(BuildContext context) {
    debugPrint('satisfied');
    return FutureBuilder(
      future: _neverSatisfied(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return snapshot.data;
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> _neverSatisfied(BuildContext context) async {
    debugPrint('neverSatisfied');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /* Future<Widget> _addComponent(BuildContext context) async {
    List<String> typePassComponentStringValues = [
      'Alphanumeric',
      'Random letters',
      'Uppercase letters',
      'Lowercase letters',
      'Pin',
      'Custom'
    ];
    Map<String, TypePassComponent> typePassComponentValues = Map.fromIterables(
        typePassComponentStringValues.whereType(),
        TypePassComponent.values.whereType());
    String dropdownValue = typePassComponentStringValues[0];
    if (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Add password component'),
            children: <Widget>[
              DropdownButton(
                value: dropdownValue,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 15,
                elevation: 16,
                underline: Divider(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: typePassComponentStringValues
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          );
        })) {}
  } */
}

enum TypePassComponent {
  alphanumeric,
  randomletters,
  uppercaseletters,
  lowercaseletters,
  pin,
  custom,
}
