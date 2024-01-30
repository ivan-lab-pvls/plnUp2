import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class JungleScreen extends StatelessWidget {
  const JungleScreen({
    super.key,
    required this.jumeiraBonusGet,
  });
  final String jumeiraBonusGet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(jumeiraBonusGet),
          ),
        ),
      ),
    );
  }
}
