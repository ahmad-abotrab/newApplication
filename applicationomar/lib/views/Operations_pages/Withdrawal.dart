import 'dart:async';

import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/localization/local_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Withdrawal extends StatelessWidget {
  Withdrawal({Key key}) : super(key: key);
  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        contentPadding: EdgeInsets.only(
          top: 8.0,
        ),
        titlePadding: EdgeInsets.only(bottom: 8.0),
        title: Container(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                DemoLocalizations.of(context).translate(
                    'Operations', 'Withdrawal',
                    key3: 'withdrawal_text'),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        content: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          child: SingleChildScrollView(
            child: Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            labelText: DemoLocalizations.of(context).translate(
                                'Operations', 'Withdrawal',
                                key3: 'withdraw_amount'),
                            counterText: "",
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (input) => input.isEmpty
                            ? DemoLocalizations.of(context).translate(
                                'Operations', 'Withdrawal',
                                key3: 'validator1')
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        validator: (value) => value.isEmpty
                            ? DemoLocalizations.of(context).translate(
                                'Operations', 'Withdrawal',
                                key3: 'validator2')
                            : null,
                        controller: reasonController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            labelText: DemoLocalizations.of(context).translate(
                                'Operations', 'Withdrawal',
                                key3: 'withdraw_reason'),
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.55),
                      child: FloatingActionButton(
                        backgroundColor:
                            Theme.of(context).hintColor == Colors.white
                                ? Colors.blue
                                : Colors.grey,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            showToast(context: context);
                            //Bill bill = new Bill(value: )

                          }
                        },
                        child: Text(
                          DemoLocalizations.of(context).translate(
                              'Operations', 'Withdrawal',
                              key3: 'AddButton'),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  static void showToast({
    @required BuildContext context,
  }) async {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Row(
          children: [
            Icon(
              Icons.done_all,
              color: Colors.green,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            Text(DemoLocalizations.of(context)
                .translate('Operations', 'Income', key3: 'toast'))
          ],
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
    await Timer(Duration(seconds: 1), () {
      overlayEntry.remove();
      Navigator.pop(context);
    });
  }
}
