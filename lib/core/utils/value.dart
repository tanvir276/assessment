import 'package:flutter/material.dart';

import 'custom_colors.dart';

class Values {
  static const borderRadiusOfFour = BorderRadius.all(Radius.circular(5));

  static final enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: ColorIb.green[200]!, width: 1.0),
    borderRadius: Values.borderRadiusOfFour,
  );

  static final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.deepOrange));

  static final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.deepOrange));

  static final focusedErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.deepOrange));

  static const SignUpTextStyle = TextStyle(
    fontFamily: "Roboto",
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: Colors.deepOrangeAccent,
  );
  static const SignInTextStyle = TextStyle(
    fontFamily: "Roboto",
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  final appBarSubTitleStyle = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white,
  );
  static final ButtonTextStyle = TextButton.styleFrom(
      backgroundColor: Colors.orangeAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));

  static final ButtonStyle ButtonStyles = TextButton.styleFrom(
      backgroundColor: Colors.orangeAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      side: BorderSide(color: Colors.white));

  static const gradientOrange = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Colors.orangeAccent,
      Colors.red,
    ],
  );
  static final appbarHeader = AppBar(
    title: new Image(
      image: new ExactAssetImage("assets/images/beemaBox.jpg"),
      height: 40.0,
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFFfdc830),
              const Color(0xFFf37335),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    ),
  );
  static final appbar = AppBar(
    backgroundColor: Colors.orange,
    centerTitle: true,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ), //Icon(Icons.menu),
    title: new Image(
      image: new ExactAssetImage("assets/images/beemaBox.jpg"),
      height: 40.0,
    ),
  );
}
