import 'dart:convert';
import 'package:http/http.dart' as http;

class Quote {
  final String text;
  final String author;

  Quote(this.text, this.author);

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(json['content'] ?? "", json['author'] ?? "Unknown");
  }

  static Future<Quote> getRandomQuote() async {
    final response = await http.get(Uri.parse('https://api.quotable.io/random'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return Quote.fromJson(jsonData);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
