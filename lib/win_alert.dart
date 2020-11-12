import 'package:flutter/material.dart';
import 'package:gridcircuitpuzzle/app_styling.dart';
import 'package:gridcircuitpuzzle/app_content.dart';

class WinAlert extends StatelessWidget {
  final Function onHome;
  final Function onNewGame;

  WinAlert({
    @required this.onHome,
    @required this.onNewGame,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppText.DIALOG_TITLE,
        textAlign: TextAlign.center,
      ),
      content: Text(
        AppText.DIALOG_BODY_TXT,
        textAlign: TextAlign.center,
      ),
      backgroundColor: AppColors.DIALOG_BG_CLR,
      shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadii.dialogBorderRadius),
      actions: <Widget>[
        /// Go to home page:
        FlatButton(
          child: Text(AppText.DIALOG_HM_BTN_TXT),
          onPressed: () {
            onHome();
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),

        /// Start new game:
        FlatButton(
          child: Text(AppText.DIALOG_NWGM_BTN_TXT),
          onPressed: () {
            onNewGame();
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, '/game');
          },
        ),
      ],
    );
  }
}
