import 'dart:collection';

import 'package:bite_link_app/Swatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_release_package/quick_release_package.dart';

import 'TextStyles.dart';

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

class Services extends StatelessWidget with IndexScrollWidget {
  final BuildContext context;

  Services(this.context);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border(top: BorderSide(color: Swatch.red, width: 10))),
      height: height,
      child: BottomGlow(
          Center(
            child: Text(
              "Services",
              style: TextStyle(
                  color: Swatch.dark_blue, decoration: TextDecoration.none),
            ),
          ),
          Swatch.red,
          height * 0.1),
    );
  }

  @override
  double get height => MediaQuery.of(context).size.height - 60;
}

class AboutUs extends StatelessWidget with IndexScrollWidget {
  final BuildContext context;

  AboutUs(this.context);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border(top: BorderSide(color: Swatch.green, width: 10))),
      height: height,
      child: BottomGlow(
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "The BiteLink Team",
                        style: TextStyles.header,
                      )),
                  getAboutUsRow(context),
                  Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: styledCard(Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Our Mission",
                            style: TextStyles.subHeader,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "BiteLink envisions an ordering market place where every business takes part. Our team strives to give local businesses affordable deals to keep up with the competition",
                                style: TextStyles.description,
                                maxLines: null,
                                textAlign: TextAlign.center,
                              )),
                        ],
                      )))
                ],
              )),
          Swatch.green,
          height * 0.1),
    );
  }

  Widget getAboutUsRow(BuildContext context) => SizedBox(
      width: double.infinity,
      height: height / 2.5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getMemberCard(
              "Patrick Oshea",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              context),
          getMemberCard(
              "Dylan Baker",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              context),
          getMemberCard(
              "Eric Ho",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              context)
        ],
      ));

  Widget getMemberCard(String name, String description, BuildContext context) =>
      SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: styledCard(
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          name,
                          style: TextStyles.subHeader,
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Text(
                      description,
                      style: TextStyles.description,
                      maxLines: null,
                      textAlign: TextAlign.center,
                    )))
                  ],
                )),
          ));

  Widget styledCard(Widget child) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          //side: BorderSide(color: Swatch.green, width: 2)
        ),
        color: Swatch.egg_shell,
        shadowColor: Swatch.green,
        elevation: 10,
        child: child,
      );

  @override
  double get height => MediaQuery.of(context).size.height - 60;
}

class ContactUs extends StatefulWidget with IndexScrollWidget {
  final BuildContext context;

  ContactUs(this.context);

  @override
  State<StatefulWidget> createState() {
    return _ContactUsState();
  }

  @override
  double get height => MediaQuery.of(context).size.height - 60;
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController _businessName, _email, _phoneNumber;

  @override
  void initState() {
    _businessName = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border:
                Border(top: BorderSide(color: Swatch.light_blue, width: 10))),
        child: BottomGlow(
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Contact us",
                      style: TextStyles.header,
                    ),
                    SizedBox(
                        width: width * 0.6,
                        child: UITextField(
                            _businessName, context, 5, "Business Name")),
                    SizedBox(
                        width: width * 0.6,
                        child: UITextField(_email, context, 5, "Email")),
                    SizedBox(
                        width: width * 0.4,
                        child: UITextField(
                          _phoneNumber,
                          context,
                          5,
                          "Phone Number",
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        )),
                    /*Row(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      UITextField(_phoneNumber, context, 5, "Phone Number",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],),
                    ],),*/
                    SizedBox(
                      child: button("Get In Touch", () {}, context,
                          buttonElevation: 12),
                      width: width / 2,
                      height: 65,
                    ),
                  ],
                )),
            Swatch.light_blue,
            widget.height * 0.1));
  }
}

class BottomGlow extends StatelessWidget {
  final Widget child;

  final Color glowColor;

  final double height;

  BottomGlow(this.child, this.glowColor, this.height);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Expanded(child: this.child),
            Align(
                alignment: Alignment.bottomCenter,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const <double>[0, 1],
                      colors: [glowColor.withOpacity(0), glowColor],
                    ),
                  ),
                  child: SizedBox(width: double.infinity, height: this.height),
                )),
          ],
        ));
  }
}
