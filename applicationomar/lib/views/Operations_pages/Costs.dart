import 'dart:async';
import 'dart:ui';

import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import '/localization/local_keys.g.dart';

class CostsScreen extends StatefulWidget {
  @override
  _Costsviewstate createState() => _Costsviewstate();
}

class _Costsviewstate extends State<CostsScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  DateTime _selecteddate;
  bool checkedvalue = true;
  final formKey = GlobalKey<FormState>();

  void datepicking() {
    DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(1999, 3, 5),
            maxTime: DateTime.now(), onChanged: (date) {
      date = _selecteddate;
    }, onConfirm: (date) {
      date = _selecteddate;
    }, currentTime: DateTime.now(), locale: LocaleType.en)
        .then((pickedate) {
      if (pickedate == null) {
        return;
      }
      setState(() {
        _selecteddate = pickedate;
      });
    });
  }

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
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
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
            Text(
              DemoLocalizations.of(context)
                  .translate('Operations', 'Costs', key3: 'Add_costs'),
              style: TextStyle(color: Colors.white),
            ),
            Expanded(child: Container()),
            IconButton(
                onPressed: () {
                  setState(() {
                    _selecteddate = null;
                    checkedvalue = true;
                  });
                },
                icon: Icon(
                  Icons.restart_alt,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.0001),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: TextFormField(
                            controller: _titleController,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                labelText: DemoLocalizations.of(context)
                                    .translate('Operations', 'Costs',
                                        key3: 'Title'),
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (input) => input.trim().isEmpty
                                ? DemoLocalizations.of(context).translate(
                                    'Operations', 'Costs',
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
                            style: TextStyle(fontSize: 18),
                            controller: _descController,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                labelText: DemoLocalizations.of(context)
                                    .translate('Operations', 'Costs',
                                        key3: 'costs_desc'),
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (input) => input.isEmpty
                                ? DemoLocalizations.of(context).translate(
                                    'Operations', 'Costs',
                                    key3: 'validator2')
                                : null,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: _valueController,
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
                                counterText: "",
                                labelText: DemoLocalizations.of(context)
                                    .translate('Operations', 'Costs',
                                        key3: 'value'),
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (input) => input.isEmpty
                                ? DemoLocalizations.of(context).translate(
                                    'Operations', 'Costs',
                                    key3: 'validator3')
                                : null,
                          ),
                        ),
                        _selecteddate == null
                            ? CheckboxListTile(
                                title: Text(
                                  DemoLocalizations.of(context).translate(
                                      'Operations', 'Costs',
                                      key3: 'date'),
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                ),
                                activeColor:
                                    Theme.of(context).hintColor == Colors.white
                                        ? Colors.blue
                                        : Colors.grey,
                                value: checkedvalue,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedvalue = newValue;
                                  });
                                  datepicking();
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              )
                            : TextButton(
                                onPressed: datepicking,
                                child: Text(
                                  _selecteddate == null
                                      ? DemoLocalizations.of(context).translate(
                                          'Operations', 'Costs',
                                          key3: 'selectDate')
                                      : '${DateFormat.yMEd().format(_selecteddate)}',
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06),
                                )),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.55),
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).hintColor == Colors.white
                        ? Colors.blue
                        : Colors.grey,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        showToast(context: context);
                        //Bill bill = new Bill(value: )

                      }
                    },
                    child: Text(
                      DemoLocalizations.of(context)
                          .translate('Operations', 'Costs', key3: 'AddButton'),
                    ),
                  ),
                )
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
