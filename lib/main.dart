import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_demo_app/common/theme.dart';


void main() {
  runApp(const MyApp());
}

/*
* Stateless widgets are immutable, meaning that their properties
* can’t change (all values are final).
* */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  // Also, see explanation what is BuildContext https://www.youtube.com/watch?v=rIaaH87z1-g
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myAppTheme,
      home:const RandomWords(),
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
  State<RandomWords> createState() => _RandomWordsState();
}

/*
Once you’ve entered RandomWords as the name of the stateful widget,
the IDE automatically updates the accompanying State class, naming it _RandomWordsState.

By default, the name of the State class is prefixed with an underbar.
Prefixing an identifier with an underscore enforces privacy in
the Dart language and is a recommended best practice for State object*/
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};

  /*
    *  Most of the app’s logic resides here—it maintains the state for the RandomWords widget
    * */
  @override
  Widget build(BuildContext context) {

    /*
      Scaffold: Implements the basic material design visual layout structure,
      see: https://api.flutter.dev/flutter/material/Scaffold-class.html
      * */
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [IconButton(
          icon: const Icon(Icons.list),
          onPressed: _pushSaved,
          tooltip: 'Saved Suggestions',
        )],
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
              color: alreadySaved ? Colors.red.shade300 : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            /*
            In this step, you'll make the heart icons tappable. When the user
            taps an entry in the list, toggling its favorited state, that word
            pairing is added or removed from a set of saved favorites.

            To do that, you'll implement onTap function (which is called when
            the user taps this list tile.). If a word entry has already been added
            to favorites, tapping it again removes it from favorites. When a tile
            has been tapped, the function calls setState() to notify the framework that state has changed.

            TIP: In Flutter's reactive style framework, calling setState() triggers
             a call to the build() method for the State object, resulting in an update to the UI.
            * */
            onTap: (){
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {

            final tiles = _saved.map((pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
            );

            final divided = tiles.isEmpty ? <Widget>[]
                : ListTile.divideTiles(context: context, tiles: tiles,).toList();

            return Scaffold(
              appBar: AppBar(
                title: const Text('Saved Suggestions'),
              ),
              body: ListView(children: divided),
            );
            },
      ),
    );
  }
}
