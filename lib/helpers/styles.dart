import 'package:flutter/material.dart';

TextStyle detailStyle(BuildContext context) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground,
  );
}

TextStyle titleStyle(BuildContext context) {
  return TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground,
  );
}

TextStyle smallTitleStyle(BuildContext context) {
  return TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
  );
}

TextStyle bigBodyStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground,
  );
}

TextStyle bigBodyHighlightStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.primary,
  );
}

TextStyle smallHeaderHighlightStyle(BuildContext context) {
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.primary,
  );
}

TextStyle smallerTitleStyle(BuildContext context) {
  return TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground,
  );
}

TextStyle smallerTitleDimmedStyle(BuildContext context) {
  return TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
  );
}

TextStyle sectionHeaderStyle(BuildContext context) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground,
  );
}

TextStyle bodyStyle(BuildContext context) {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground,
  );
}

TextStyle bodyDimmedStyle(BuildContext context) {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
  );
}

TextStyle featureTitleStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground,
  );
}

TextStyle descriptionStyle(BuildContext context) {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
  );
}

TextStyle smallDescriptionStyle(BuildContext context) {
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
  );
}

TextStyle smallerDescriptionStyle(BuildContext context) {
  return TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
  );
}

TextStyle buttonTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w300,
    color: Theme.of(context).colorScheme.onBackground,
  );
}
