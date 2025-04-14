import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Essentials/Label.dart';
import 'colors.dart';

const SizedBox width5 = SizedBox(width: 5);
const SizedBox width10 = SizedBox(width: 10);
const SizedBox width15 = SizedBox(width: 15);
const SizedBox width20 = SizedBox(width: 20);
const SizedBox height5 = SizedBox(height: 5);
const SizedBox height10 = SizedBox(height: 10);
const SizedBox height15 = SizedBox(height: 15);
const SizedBox height20 = SizedBox(height: 20);
SizedBox kHeight(double height) => SizedBox(height: height);
SizedBox kWidth(double width) => SizedBox(width: width);

Widget get div => const Divider(color: Kolor.border, thickness: .5);

systemColors() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

BorderRadius kRadius(double radius) => BorderRadius.circular(radius);

Future<T?> navPush<T extends Object?>(BuildContext context, Widget screen) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

Future<T?> navPushReplacement<T extends Object?, TO extends Object?>(
  BuildContext context,
  Widget screen,
) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

Future<T?> navPopUntilPush<T extends Object?>(
  BuildContext context,
  Widget screen,
) {
  Navigator.popUntil(context, (route) => false);
  return navPush(context, screen);
}

KSnackbar(
  context, {
  dynamic message,
  bool error = false,
  SnackBarAction? action,
}) {
  log("[Snackbar] -> $message");
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      margin: EdgeInsets.all(10),
      backgroundColor: Kolor.card,
      shape: RoundedRectangleBorder(borderRadius: kRadius(10)),
      content: Row(
        spacing: 10,
        children: [
          Icon(
            error ? Icons.dangerous : Icons.check_circle,
            color: error ? StatusText.danger : StatusText.success,
          ),
          Expanded(
            child: Column(
              spacing: 1,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(
                  error ? "Oops!" : "Success!",
                  weight: 900,
                  color: error ? StatusText.danger : StatusText.success,
                ).regular,
                Label(
                  "$message",
                  fontSize: 12,
                  color: error ? StatusText.danger : Colors.black,
                ).regular,
              ],
            ),
          ),
        ],
      ),
      action: action,
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Widget get kSmallLoading => Center(
  child: SizedBox(
    height: 17,
    width: 17,
    child: CircularProgressIndicator(color: Kolor.primary, strokeWidth: 2),
  ),
);

Widget kNoData({
  String title = "Oops!",
  String subtitle = "Something Went Wrong.",
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Label(title).regular, Label(subtitle).subtitle],
  );
}
