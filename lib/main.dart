import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_demo_app/common/theme.dart';


void main() {
  print('Hello, World!');
  runApp(const MyApp());
}

/*
* Stateless widgets are immutable, meaning that their properties
* can’t change (all values are final).
* */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myAppTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

/*
* Stateful widgets maintain state that might change during the lifetime of the widget.
* Implementing a stateful widget requires at least two classes:
*   1) a StatefulWidget class that creates an instance of
*   2) a State class.
* The StatefulWidget class is, itself, immutable and can be thrown away and
* regenerated, but the State class persists over the lifetime of the widget.*/
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

/*
Once you’ve entered RandomWords as the name of the stateful widget,
the IDE automatically updates the accompanying State class, naming it _RandomWordsState.

By default, the name of the State class is prefixed with an underbar.
Prefixing an identifier with an underscore enforces privacy in
the Dart language and is a recommended best practice for State object*/
class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    /*
    *  Most of the app’s logic resides here—it maintains the state for the RandomWords widget
    * */
    final wordPair = WordPair.random();
    print(wordPair.asPascalCase);
    return Text(wordPair.asPascalCase);
  }
}
