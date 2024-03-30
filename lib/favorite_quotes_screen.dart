import 'package:flutter/material.dart';

import 'quote.dart';

class FavoriteQuotesScreen extends StatelessWidget {
  final List<Quote> favoriteQuotes;

  // ignore: use_key_in_widget_constructors
  const FavoriteQuotesScreen({required this.favoriteQuotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
      ),
      body: ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: ListTile(
              title: Text(favoriteQuotes[index].text),
              subtitle: Text(favoriteQuotes[index].author),
            ),
          );
        },
      ),
    );
  }
}
