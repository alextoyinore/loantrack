import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanTrackButton {
  static primary({
    required BuildContext context,
    required String label,
    required VoidCallback whenPressed,
  }) {
    return ElevatedButton(
      onPressed: whenPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            //side: const BorderSide(color: Colors.red),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevation: MaterialStateProperty.all<double?>(0),
        minimumSize: MaterialStateProperty.all<Size?>(
          Size(
            MediaQuery.of(context).size.width / 2,
            70,
          ),
        ),
        maximumSize: MaterialStateProperty.all<Size?>(
          Size(
            MediaQuery.of(context).size.width,
            100,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context)
                  .colorScheme
                  .onBackground
                  .withOpacity(0.2);
            }
            return null;
            // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.5);
            }
            return null; // Use the component's default.
          },
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Continue',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(.5),
          )
        ],
      ),
    );
  }

  static primaryOutline({
    required BuildContext context,
    required String label,
    required VoidCallback whenPressed,
  }) {
    return OutlinedButton(
      onPressed: whenPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            //side: const BorderSide(color: Colors.red),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevation: MaterialStateProperty.all<double?>(0),
        minimumSize: MaterialStateProperty.all<Size?>(
          Size(
            MediaQuery.of(context).size.width / 2,
            70,
          ),
        ),
        maximumSize: MaterialStateProperty.all<Size?>(
          Size(
            MediaQuery.of(context).size.width,
            100,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context)
                  .colorScheme
                  .onBackground
                  .withOpacity(0.2);
            }
            return null;
            // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context)
                  .colorScheme
                  .onBackground
                  .withOpacity(0.5);
            }
            return Theme.of(context).colorScheme.onBackground.withOpacity(0.2);
            // Use the component's default.
          },
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Cancel',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
          )
        ],
      ),
    );
  }

  static secondary({
    required BuildContext context,
    required String label,
    required VoidCallback whenPressed,
  }) {
    return ElevatedButton(
      onPressed: whenPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            //side: const BorderSide(color: Colors.red),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevation: MaterialStateProperty.all<double?>(0),
        minimumSize: MaterialStateProperty.all<Size?>(
          Size(
            MediaQuery.of(context).size.width / 2,
            70,
          ),
        ),
        maximumSize: MaterialStateProperty.all<Size?>(
          Size(
            MediaQuery.of(context).size.width,
            100,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.secondary.withOpacity(0.2);
            }
            return null;
            // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.onSecondary.withOpacity(0.5);
            }
            return null; // Use the component's default.
          },
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Continue',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(.5),
          )
        ],
      ),
    );
  }

  static secondaryOutline({
    required BuildContext context,
    required String label,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          //color: Colors.white,
          border: Border.all(color: LoanTrackColors2.PrimaryOne, width: .5)),
      child: Text(
        label,
        style: const TextStyle(
            color: LoanTrackColors2.PrimaryOne,
            fontSize: 14,
            fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }

  static error({
    required BuildContext context,
    required String label,
    required VoidCallback whenPressed,
  }) {
    return OutlinedButton(
      onPressed: whenPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            //side: const BorderSide(color: Colors.red),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevation: MaterialStateProperty.all<double?>(0),
        minimumSize: MaterialStateProperty.all<Size?>(
          Size(
            MediaQuery.of(context).size.width / 2,
            70,
          ),
        ),
        maximumSize: MaterialStateProperty.all<Size?>(
          Size(
            MediaQuery.of(context).size.width,
            100,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context)
                  .colorScheme
                  .onErrorContainer
                  .withOpacity(0.5);
            }
            return null;
            // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context)
                  .colorScheme
                  .onErrorContainer
                  .withOpacity(0.5);
            }
            return null; // Use the component's default.
          },
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color:
                Theme.of(context).colorScheme.onErrorContainer.withOpacity(.5),
          )
        ],
      ),
    );
  }
}
