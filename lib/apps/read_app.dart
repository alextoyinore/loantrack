import 'package:flutter/material.dart';
import 'package:loantrack/widgets/common_widgets.dart';

import '../helpers/listwidgets.dart';
import '../helpers/styles.dart';

class Read extends StatefulWidget {
  const Read({Key? key}) : super(key: key);

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 200,
                ),
                BlogList(
                  height: screenHeight * .7,
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.background,
            height: MediaQuery.of(context).size.height / 3.58,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  separatorSpace40,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close)),
                    ],
                  ),
                  separatorSpace10,
                  Text(
                    'Read',
                    style: titleStyle(context),
                  ),
                  separatorSpace10,
                  Text(
                    'Here we give you loan advices in form of blog posts, audio/visual posts and more.',
                    style: descriptionStyle(context),
                  ),
                  separatorSpace20,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
