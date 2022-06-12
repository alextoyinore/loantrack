import 'package:flutter/material.dart';
import 'package:loantrack/helpers/listwidgets.dart';

import '../helpers/styles.dart';
import '../widgets/common_widgets.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

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
                  height: 230,
                ),
                NewsList(
                  height: screenHeight * .7,
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.background,
            height: MediaQuery.of(context).size.height / 3.2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
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
                          child: const Icon(Icons.close)),
                    ],
                  ),
                  separatorSpace10,
                  Text(
                    'News',
                    style: titleStyle(context),
                  ),
                  separatorSpace10,
                  Text(
                    'This News app brings you up-to-date loan-related news in Nigeria.'
                    'News are curated from the best sources in the country.',
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
