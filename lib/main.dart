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
      /*
      Scaffold: Implements the basic material design visual layout structure,
      see: https://api.flutter.dev/flutter/material/Scaffold-class.html
      * */
      home: const Scaffold(
        body: Center(
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
    final _suggestions = <WordPair>[];
    const _biggerFont = TextStyle(fontSize: 18.0);
    final _saved = <WordPair>{};

    /*
    *  Most of the app’s logic resides here—it maintains the state for the RandomWords widget
    * */
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),

        /*
        The ListView class provides a builder property, itemBuilder, that’s
        a factory builder and callback function specified as an anonymous function.
        Two parameters are passed to the function—the BuildContext, and
        the row iterator, i. The iterator begins at 0 and increments each time
        the function is called. It increments twice for every suggested
        word pairing: once for the ListTile, and once for the Divider.
        This model allows the suggested list to continue growing as the user scrolls.
        See: https://docs.flutter.dev/get-started/codelab#step-4-create-an-infinite-scrolling-listview
        * */
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }

          final alreadySaved = _saved.contains(_suggestions[index]);
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove' : 'Save',
            ),
          );
        },
      ),
    );
  }
}
