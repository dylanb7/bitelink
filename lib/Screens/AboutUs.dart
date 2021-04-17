import 'package:bite_link_app/Utility/BottomGlow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_release_package/quick_release_package.dart';

import '../Swatch.dart';
import '../TextStyles.dart';

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