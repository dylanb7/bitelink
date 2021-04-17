import 'dart:collection';

import 'package:bite_link_app/Swatch.dart';
import 'package:flutter/material.dart';
import 'package:quick_release_package/quick_release_package.dart';
import 'Screens/AboutUs.dart';
import 'Screens/ContactUs.dart';
import 'Screens/Services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bite Link",
      theme: ThemeData(
        primaryColor: Swatch.light_blue,
        accentColor: Swatch.green,
        backgroundColor: Swatch.egg_shell,
        primaryColorDark: Swatch.dark_blue,
        inputDecorationTheme: InputDecorationTheme(fillColor: Swatch.dark_blue),
        primarySwatch: Swatch.light_blue,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  ClickController clickController;

  IndexButton services, aboutUs, contactUs;

  Color biteColor;

  @override
  void initState() {
    clickController = ClickController();
    services = IndexButton("Services", clickController, Swatch.red, 20);
    aboutUs = IndexButton("About us", clickController, Swatch.green, 20);
    contactUs =
        IndexButton("Contact us", clickController, Swatch.light_blue, 20);
    biteColor = Swatch.light_blue;
    clickController.addListener(() {
      setState(() {
        biteColor = clickController.selected == null ||
                clickController.selected == contactUs
            ? Swatch.light_blue
            : clickController.selected == services
                ? Swatch.red
                : Swatch.green;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Swatch.egg_shell,
        child: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 60),
                child: AutoScrollParallax(
                  getLogo(context),
                  LinkedHashMap.of({
                    Services(context): services,
                    AboutUs(context): aboutUs,
                    ContactUs(context): contactUs
                  }),
                  clickController,
                  fadeColor: Swatch.light_blue,
                  parallaxEffect: 2.5,
                )),
            Positioned(
              top: 5,
              left: 5,
              right: 5,
              child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: clickController.selected == null
                            ? Container()
                            : Image.asset(
                                "assets/BiteLinkLogo.png",
                                fit: BoxFit.fitWidth,
                                color: biteColor,
                              ),
                      ),
                      Spacer(),
                      services,
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: aboutUs),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: contactUs),
                    ],
                  )),
            ),
          ],
        ));
  }

  SizedBox getLogo(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height - 60,
        width: MediaQuery.of(context).size.width,
        child: Container(
            color: Swatch.dark_blue,
            child: Align(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(children: [
                    Image.asset(
                      "assets/BiteLinkLogo.png",
                      fit: BoxFit.fitWidth,
                      color: Swatch.light_blue,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: Text(
                          "Online Ordering Solutions",
                          style: TextStyle(
                              color: Swatch.light_blue,
                              fontSize: 25,
                              decoration: TextDecoration.none),
                        )),
                    button("Contact us", () {
                      clickController.clicked(contactUs);
                    }, context,
                        backgroundColor: Swatch.red,
                        textColor: Swatch.egg_shell.shade600,
                        borderRad: 5)
                  ])),
              alignment: Alignment.centerLeft,
            )),
      );
}

class IndexButton extends IndexListWidget {
  final String text;

  final double startSize;

  final Color highlightColor;

  IndexButton(this.text, ClickController controller, this.highlightColor,
      this.startSize)
      : super(controller);

  @override
  State<StatefulWidget> createState() {
    return _IndexButtonState();
  }
}

class _IndexButtonState extends IndexListWidgetState<IndexButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          this.pressed();
        },
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 100),
          curve: Curves.easeIn,
          style: TextStyle(
              fontSize: highlighted ? widget.startSize * 1.2 : widget.startSize,
              color: highlighted ? widget.highlightColor : Swatch.dark_blue,
              fontWeight: highlighted ? FontWeight.bold : FontWeight.normal),
          child: Text(widget.text),
        ));
  }
}






