import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
    PassComponent(TypePassComponent.alphanumeric, 100),
    PassComponent(TypePassComponent.randomletters, 50),
    PassComponent(TypePassComponent.uppercaseletters, 60),
    PassComponent(TypePassComponent.lowercaseletters, 60),
    PassComponent(TypePassComponent.pin, 60),
    PassComponent(TypePassComponent.custom, 60),
  ];
  var addComponentButton = FlatButton(
    color: Color.fromARGB(100, 128, 139, 150),
    onPressed: () {
      debugPrint("Precionado");
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
                return addComponentButton;
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

  void _addComponent(){

  }
}

class PassComponent extends StatelessWidget {
  TypePassComponent typePassComponent;
  int size;
  String passwordCharacters = "";
  Color color;
  String typeString;

  @override
  Widget build(BuildContext context) {
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

  PassComponent(TypePassComponent typePassComponent, int size) {
    this.typePassComponent = typePassComponent;
    this.size = size;
    _typeInterpreter();
  }
  PassComponent.custom(String passwordCharacters, int size) {
    typePassComponent = TypePassComponent.custom;
    this.size = size;
  }

  void _typeInterpreter(){
    switch (typePassComponent) {
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

class TestComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Color.fromARGB(100, 128, 139, 150),
      onPressed: () {
        debugPrint("Precionado");
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
}

enum TypePassComponent {
  randomletters,
  alphanumeric,
  uppercaseletters,
  lowercaseletters,
  pin,
  custom,
}
