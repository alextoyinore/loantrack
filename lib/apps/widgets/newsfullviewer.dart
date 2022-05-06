import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsFullViewer extends StatefulWidget {
  NewsFullViewer({Key? key, required this.news}) : super(key: key);

  DocumentSnapshot news;

  @override
  State<NewsFullViewer> createState() => _NewsFullViewerState();
}

class _NewsFullViewerState extends State<NewsFullViewer> {
  @override
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: LoanTrackColors.PrimaryTwoLight,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(widget.news.get('source')),
      ),
      body: WebView(
        key: _key,
        initialUrl: widget.news.get('link').toString(),
        javascriptMode: JavascriptMode.disabled,
      ),
    );
  }
}
