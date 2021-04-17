import 'package:bite_link_app/Utility/BottomGlow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_release_package/quick_release_package.dart';

import '../Swatch.dart';

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
