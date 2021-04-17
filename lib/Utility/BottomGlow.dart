

import 'package:flutter/cupertino.dart';

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