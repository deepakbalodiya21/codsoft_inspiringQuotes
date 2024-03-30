import 'package:share/share.dart';

class ShareHelper {
  static void shareQuote(String text, String author) {
    Share.share('$text - $author');
  }
}


