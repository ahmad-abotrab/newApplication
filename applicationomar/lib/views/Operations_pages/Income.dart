import 'dart:async';

import 'package:applicationomar/localization/localizationFile.dart';
import 'package:applicationomar/models/Operations/InComing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class InComming extends StatelessWidget {
  TextEditingController amountController = new TextEditingController();
  TextEditingController reasonController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  InComming({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      titlePadding: EdgeInsets.only(bottom: 8.0),
      title: Container(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
          ),
          child: Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white)),
                Text(
                  DemoLocalizations.of(context)
                      .translate('Operations', 'Income', key3: 'Income_text'),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )),
      contentPadding: EdgeInsets.only(
        top: 7.0,
      ),
      contentTextStyle: TextStyle(
          color: Theme.of(context).hintColor,
          backgroundColor: Theme.of(context).backgroundColor),
      content: Container(
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.number,
                          controller: amountController,
                          maxLength: 10,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              labelText: DemoLocalizations.of(context)
                                  .translate('Operations', 'Income',
                                      key3: 'amount_text'),
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (input) => input.isEmpty
                              ? DemoLocalizations.of(context).translate(
                                  'Operations', 'Income',
                                  key3: 'validatorAmount')
                              : null,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: reasonController,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: BorderSide(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              labelText: DemoLocalizations.of(context)
                                  .translate('Operations', 'Income',
                                      key3: 'income_reason'),
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (input) => input.isEmpty
                              ? DemoLocalizations.of(context).translate(
                                  'Operations', 'Income',
                                  key3: 'validatorReason')
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * 0.013,
                            left: MediaQuery.of(context).size.width * 0.59),
                        child: FloatingActionButton(
                          backgroundColor: Color(0xFF787878),
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              InCommingModel inComming = new InCommingModel(
                                date: DateTime.now(),
                                value: double.parse(amountController.text),
                                notes: reasonController.text,
                              );
                              await showToast(context: context);
                            }
                          },
                          child: Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
                  key: formKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
