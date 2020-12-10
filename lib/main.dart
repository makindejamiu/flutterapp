import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo Flutter App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.white,
        ),
        home: RandomWords(),
        // routes: ,
      );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  var wordPair = WordPair.random();
  final _suggestions = <WordPair>[];
  var _favoriteWordPairs = Set<WordPair>();
  final largeFont = TextStyle(fontSize: 17);

  ScrollController _listScrollController = ScrollController();

  Widget _buildSuggestions() {
    return ListView.builder(
        controller: _listScrollController,
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) {
            return Divider();
          } /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair randWord) {
    final alreadySaved = _favoriteWordPairs.contains(randWord);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(randWord.asPascalCase, style: largeFont),
            IconButton(
              color: alreadySaved == true ? Colors.red : Colors.black,
              icon: Icon(alreadySaved == true
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              onPressed: () {
                setState(() {
                  alreadySaved == false
                      ? _favoriteWordPairs.add(randWord)
                      : _favoriteWordPairs.remove(randWord);
                });
              },
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Random Word Pair'),
        // centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              iconSize: 40.0,
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                favoriteWordPairs();
              },
            ),
          )
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          // TODO: scroll the page to the top
          _listScrollController.animateTo(0.0,
              duration: Duration(seconds: 10), curve: Curves.ease);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(items: 
        [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home))
        ],),
    );
  }

  void favoriteWordPairs() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _favoriteWordPairs.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: largeFont,
                ),
              );
            },
          );

          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }
}
