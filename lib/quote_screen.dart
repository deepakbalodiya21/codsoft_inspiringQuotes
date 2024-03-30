import 'package:flutter/material.dart';

import 'favorite_quotes_screen.dart'; // Import the screen where favorite quotes will be displayed
import 'quote.dart';
import 'share_helper.dart';

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<Quote> _futureQuote;
  List<Quote> _favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    _futureQuote = Quote.getRandomQuote();
  }

  void _loadQuoteOfTheDay() {
    setState(() {
      _futureQuote = Quote.getRandomQuote();
    });
  }

  void _shareQuote(Quote quote) {
    ShareHelper.shareQuote(quote.text, quote.author);
  }

  void _addToFavorites(Quote quote) {
    setState(() {
      _favoriteQuotes.add(quote);
    });
    // You can add further functionality here like storing quotes in local database
  }

  void _viewFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              FavoriteQuotesScreen(favoriteQuotes: _favoriteQuotes)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inspiring Quotes'),
        backgroundColor: Colors.purpleAccent[100],
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _futureQuote.then((quote) {
                _shareQuote(quote);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: _viewFavorites,
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Quote>(
          future: _futureQuote,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Failed to load quote');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      snapshot.data!.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _loadQuoteOfTheDay,
                    child: Text('Next Quote'),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _futureQuote.then((quote) {
            _addToFavorites(quote);
          });
        },
        tooltip: 'Add to Favorites',
        child: Icon(Icons.favorite),
      ),
    );
  }
}
