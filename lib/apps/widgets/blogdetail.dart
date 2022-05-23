import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDetail extends StatefulWidget {
  BlogDetail({Key? key, required this.blog}) : super(key: key);

  DocumentSnapshot blog;

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  late WebViewController controller;

  Future<void> loadBlogContent() async {
    final url = Uri.dataFromString(
      '''
      <style>
        body {margin: 0px; padding: 0px; }
        #featuredImage {margin: 0px; height: 60%; width: 115%; background: center/cover url("${widget.blog.get('featuredImage')}")}
        #content {padding: 7.5%; width: 100%;}
        #content p { font-size: 3em; color: grey; line-height: 1.5;}
        h1{font-size:5em;}
        #authorBox {align-content: start; display: grid; grid-template-columns: 1fr 3fr; column-gap: 3%; height: 12%;}
        #authorDetails {font-size: 2.5em; color: #aaa; line-height: 1.5;}
        #authorImage {width: 100%; height: 100%; border-radius: 100%; background: center/cover no-repeat url("${widget.blog.get('author_image')}");}
      </style>
      <body>
        
        <div id="featuredImage"></div> 

        <div id="content">
          
          <h1>
            ${widget.blog.get('title')}
          </h1>
          
          <br><br>
        
          <div id="authorBox">
           
            <div id="authorImage"></div>
           
            <div id="authorDetails">
              <span>${widget.blog.get('author')}</span> <br>
              <span>${widget.blog.get('socials')}</span> <br>
              <span>${widget.blog.get('whenPublished')}</span>
            </div>
            
          </div>
           
          ${widget.blog.get('content')}
          
        </div>
        
      </body>
      ''',
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    await controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        onWebViewCreated: (controller) {
          this.controller = controller;
          loadBlogContent();
        },
      ),
    );

    /*Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.blog.get('featuredImage')),
              )),
            ),
            separatorSpace10,
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                        widget.blog.get('tags').split(',').length, (index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color:
                                LoanTrackColors.PrimaryTwoVeryLight.withOpacity(
                                    .1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(widget.blog.get('tags').split(',')[index]),
                      );
                    }),
                  ),
                  separatorSpace10,
                  Text(
                    widget.blog.get('title'),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  separatorSpace10,
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.blog.get('author_image')),
                        radius: 30,
                      ),
                      horizontalSeparatorSpace10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.blog.get('author'),
                            style: const TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text(
                            widget.blog.get('socials'),
                            style: const TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text(
                            widget.blog.get('whenPublished'),
                            style: const TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                  separatorSpace20,
                  SizedBox.expand(
                    //height: MediaQuery.of(context).size.height,
                    child: WebView(
                      allowsInlineMediaPlayback: true,
                      initialMediaPlaybackPolicy:
                          AutoMediaPlaybackPolicy.always_allow,
                      onWebViewCreated: (controller) {
                        this.controller = controller;
                        loadBlogContent();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );*/
  }
}
