import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

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
          primarySwatch: Colors.blue,
        ),
        home: RandomWords()
        // RandomWords()
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
  final largeFont = TextStyle(fontSize: 17);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) {
            print('Generating More Contents');
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
    return Row(
      children: [Text(randWord.asPascalCase, style: largeFont,)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: _buildSuggestions(),
      // Center(
      //   child: Text(wordPair.asPascalCase),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.chat),
      //   onPressed: () {
      //     setState(() {
      //       wordPair = WordPair.random();
      //     });
      //   },
      // ),
    );
  }
}
