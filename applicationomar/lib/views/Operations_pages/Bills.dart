import 'dart:async';

import 'package:applicationomar/localization/localizationFile.dart';
import 'package:applicationomar/models/Operations/Bill.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '/Api/Controller/BillsContoller.dart';

//     TextEditingController _titleController = TextEditingController();
// TextEditingController _valueController = TextEditingController();
// TextEditingController _addbillController = TextEditingController();

class Bills extends StatelessWidget {
  Bills({Key key}) : super(key: key);
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
            // Color(0xFF7D7E7E)
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              Text(
                DemoLocalizations.of(context)
                    .translate('Operations', 'Bills', key3: 'add_a_bill'),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
      content: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              GetBuilder<BillsController>(
                  init: BillsController(),
                  builder: (_) {
                    return Container(
                      width: double.infinity,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(28),
                            elevation: 10,
                            iconSize: 35,
                            // itemHeight: 1,
                            dropdownColor: Colors.grey[100],
                            value: BillsController.chosenvValue,
                            hint: Text(
                              DemoLocalizations.of(context).translate(
                                  'Operations', 'Bills',
                                  key3: 'Choose_Bill'),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            iconEnabledColor: Colors.blueGrey,
                            iconDisabledColor: Colors.blue,
                            items: BillsController.billsitems(context)
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String value) {
                              if (value ==
                                  BillsController.billsitems(context).last) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        titlePadding:
                                            EdgeInsets.only(bottom: 8.0),
                                        title: Container(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04),
                                              Text(
                                                DemoLocalizations.of(context)
                                                    .translate(
                                                        'Operations', 'Bills',
                                                        key3: 'Bills_text'),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          padding: EdgeInsets.only(
                                              top: 16.0, bottom: 16.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF7D7E7E),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.0),
                                                topRight:
                                                    Radius.circular(25.0)),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(25)),
                                        content: SingleChildScrollView(
                                          child: TextField(
                                            // controller: _addbillController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  DemoLocalizations.of(context)
                                                      .translate(
                                                          'Operations', 'Bills',
                                                          key3: 'Bills_text'),
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25.0))),
                                                color: Colors.grey,
                                                textColor: Colors.white,
                                                child: Text(
                                                  DemoLocalizations.of(context)
                                                      .translate(
                                                          'Operations', 'Bills',
                                                          key3: 'cancelButton'),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  25.0))),
                                                  color: Colors.grey,
                                                  textColor: Colors.white,
                                                  child: Text(
                                                    DemoLocalizations.of(
                                                            context)
                                                        .translate('Operations',
                                                            'Bills',
                                                            key3: 'AddButton'),
                                                  ),
                                                  onPressed: () {
                                                    // billsitems.insert(1, _addbillController.text);
                                                    // _chosenvalue = _addbillController.text;
                                                    // _addbillController.clear();
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              } else {
                                Get.find<BillsController>()
                                    .updateChosenValueByDropDown(value);
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        validator: (value) => value.isEmpty
                            ? DemoLocalizations.of(context).translate(
                                'Operations', 'Bills',
                                key3: 'validator')
                            : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // controller: _valueController,
                        maxLength: 10,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Theme.of(context).hintColor,
                                )),
                            counterText: "",
                            labelText: DemoLocalizations.of(context).translate(
                                'Operations', 'Bills', key3: 'Filled'),
                            labelStyle: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).hintColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
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
                            if (BillsController.chosenvValue != '' &&
                                BillsController.chosenvValue != null) {
                              showToast(context: context);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                            DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'Bills',
                                                    key3: 'dialogValidator',key4:"title")),
                                        content: Text(
                                            DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'Bills',
                                                    key3: 'dialogValidator',
                                                    key4: "content")),
                                                    actions: [MaterialButton(onPressed: (){},child: Text(
                                                DemoLocalizations.of(context)
                                                    .translate(
                                                        'Operations', 'Bills',
                                                        key3: 'dialogValidator',
                                                        key4: "backbtn")),)],
                                      ));
                            }

                            //Bill bill = new Bill(value: )

                          }
                        },
                        child: Text(
                          DemoLocalizations.of(context).translate(
                              'Operations', 'Bills',
                              key3: 'AddButton'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
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


/**
 *   
 */

