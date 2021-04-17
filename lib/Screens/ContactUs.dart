import 'package:bite_link_app/Utility/BottomGlow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_release_package/quick_release_package.dart';

import '../Swatch.dart';
import '../TextStyles.dart';

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
  TextEditingController _businessName,
      _title,
      _firstName,
      _lastName,
      _email,
      _phoneNumber;

  bool _shouldEmail = true, _shouldCall = false, _shouldMessage = false;

  @override
  void initState() {
    _businessName = TextEditingController();
    _title = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
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
                child: SizedBox(
                    width: width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                              "Contact us",
                              style: TextStyles.header,
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: UITextField(
                              _businessName,
                              context,
                              5,
                              "Business Name",
                              prefix: Icon(Icons.business_center),
                            )),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: UITextField(
                                _title,
                                context,
                                5,
                                "Title",
                              ),
                            ),
                            Expanded(
                                child: UITextField(
                                    _firstName, context, 5, "First Name")),
                            Expanded(
                                child: UITextField(
                                  _lastName,
                                  context,
                                  5,
                                  "Last Name",
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: UITextField(
                                _email,
                                context,
                                5,
                                "Email",
                                autoFill: [AutofillHints.email],
                                prefix: Icon(Icons.email),
                              ),
                            ),
                            Expanded(
                                child: UITextField(
                                  _phoneNumber,
                                  context,
                                  5,
                                  "Phone Number",
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  autoFill: [AutofillHints.telephoneNumber],
                                  prefix: Icon(Icons.phone),
                                ))
                          ],
                        ),
                        SizedBox(
                            height: 50,
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Preferred methods of contact:",
                                      style: TextStyles.description,
                                    ),
                                    customChip("Email", _shouldEmail, (email) {
                                      setState(() {
                                        _shouldEmail = email;
                                      });
                                    }),
                                    customChip("Call", _shouldCall, (call) {
                                      setState(() {
                                        _shouldCall = call;
                                      });
                                    }),
                                    customChip("Text", _shouldMessage, (text) {
                                      setState(() {
                                        _shouldMessage = text;
                                      });
                                    }),
                                  ],
                                ))),
                        SizedBox(
                          height: 50,
                          child: button("Get In Touch", () {}, context,
                              buttonElevation: 12,
                              backgroundColor: Swatch.red,
                              textColor: Swatch.egg_shell.withOpacity(0.8),
                              borderRad: 5),
                        ),
                      ],
                    ))),
            Swatch.light_blue,
            widget.height * 0.1));
  }

  Widget customChip(
      String text, bool isSelected, Function(bool res) onSelect) =>
      IntrinsicWidth(child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: ChoiceChip(
            label: Text(
              text,
              style: isSelected
                  ? TextStyles.description
                  : TextStyle(
                  color: Swatch.dark_blue.withOpacity(0.8),
                  fontSize: 20,
                  decoration: TextDecoration.none),
            ),
            onSelected: onSelect,
            selected: isSelected,
            shadowColor: Swatch.light_blue,
            elevation: 2,
          )));
}