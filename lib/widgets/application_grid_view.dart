import 'package:flutter/material.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanTrackAppsGridView extends StatefulWidget {
  const LoanTrackAppsGridView({Key? key}) : super(key: key);

  @override
  State<LoanTrackAppsGridView> createState() => _LoanTrackAppsGridViewState();
}

class _LoanTrackAppsGridViewState extends State<LoanTrackAppsGridView> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
        shrinkWrap: true,
        controller: _controller,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        maxCrossAxisExtent: 100.0,
        children: List.generate(LocalData.applicationList.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, LocalData.applicationList[index].route as dynamic);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.2, color: LoanTrackColors.PrimaryOneDark),
                  borderRadius: BorderRadius.circular(10),
                  color: LoanTrackColors.PrimaryOne.withOpacity(.1)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      LocalData.applicationList[index].iconData,
                      size: 30,
                      color: LoanTrackColors.PrimaryOneDark,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      LocalData.applicationList[index].name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: LoanTrackColors.PrimaryOneDark),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
