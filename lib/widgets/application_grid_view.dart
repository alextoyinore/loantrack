import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/structures/data.dart';

class LoanTrackAppsGridView extends StatefulWidget {
  const LoanTrackAppsGridView({Key? key}) : super(key: key);

  @override
  State<LoanTrackAppsGridView> createState() => _LoanTrackAppsGridViewState();
}

class _LoanTrackAppsGridViewState extends State<LoanTrackAppsGridView> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GridView.extent(
        shrinkWrap: true,
        controller: _controller,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        maxCrossAxisExtent: 100.0,
        children: List.generate(Data.applicationList.length, (index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.2, color: LoanTrackColors.PrimaryOne),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Data.applicationList[index].iconData,
                    size: 30,
                    color: LoanTrackColors.PrimaryOne,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    Data.applicationList[index].name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: LoanTrackColors.PrimaryOne),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
