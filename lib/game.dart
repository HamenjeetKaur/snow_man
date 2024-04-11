import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

void main() {
  runApp(WelcomePage());
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snowman Word Guessing Game',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Snowman Word Guessing Game'),
        ),
        body: SnowmanGame(),
      ),
    );
  }
}

class SnowmanGame extends StatefulWidget {
  @override
  _SnowmanGameState createState() => _SnowmanGameState();
}

class _SnowmanGameState extends State<SnowmanGame> {
  String word = 'SNOW';// The word to guess
  String guessedWord = ''; // The word guessed so far
  List<String> correctLetters = []; // Correctly guessed letters
  int wrongGuesses = 0; // Number of wrong guesses
  List<String> keyboard = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  bool gameOver = false;

  // List of snowman body part images
  List<String> snowmanImages = [
    'assets/snowman1.jpg',
    'assets/snowman2.jpg',
    'assets/snowman3.jpg',
    'assets/snowman4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Snowman images
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < snowmanImages.length; i++)
              if (i < wrongGuesses)
                Image.asset(
                  snowmanImages[i],
                  width: 100, // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                ),
          ],
        ),
        // Guessed word

        Text(guessedWord),
        // Keyboard
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.0,
          runSpacing: 10.0,
          children: keyboard.map((letter) {
            return ElevatedButton(
              onPressed: gameOver ? null : () {
                setState(() {
                  if (!guessedWord.contains(letter)) {
                    if (word.contains(letter)) {
                      correctLetters.add(letter);
                      guessedWord = word.split('').map((char) => correctLetters.contains(char) ? char : '_').join();
                      if (guessedWord == word) {
                        // Win logic
                        gameOver = true;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Congratulations!'),
                              content: Text('You guessed the word: $word'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Play Again'),
                                  onPressed: () {
                                    setState(() {
                                      guessedWord = '';
                                      correctLetters = [];
                                      wrongGuesses = 0;
                                      gameOver = false;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      wrongGuesses++;
                      if (wrongGuesses == 4) {
                        // Game over logic
                        gameOver = true;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Game Over'),
                              content: Text('You lost! The word was: $word'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Restart'),
                                  onPressed: () {
                                    setState(() {
                                      guessedWord = '';
                                      correctLetters = [];
                                      wrongGuesses = 0;
                                      gameOver = false;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  }
                });
              },
              child: Text(letter),
            );
          }).toList(),
        ),
      ],
    );
  }
}

Future<Database> openDB() async {
  return databaseFactoryWeb.openDatabase('user_database.db');
}

Future<void> saveUser(String username, String password) async {
  final Database db = await openDB();
  final store = intMapStoreFactory.store('users');
  await store.add(db, {'username': username, 'password': password});
}

Future<bool> authenticateUser(String username, String password) async {
  final Database db = await openDB();
  final store = intMapStoreFactory.store('users');
  final finder = Finder(filter: Filter.and([
    Filter.equals('username', username),
    Filter.equals('password', password),
  ]));
  final recordSnapshots = await store.find(db, finder: finder);
  return recordSnapshots.isNotEmpty;
}
