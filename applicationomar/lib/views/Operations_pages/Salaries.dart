import 'dart:async';

import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import '/Api/search/searchEmployee.dart';
import '/models/Human/Employee.dart';

class Salaries extends StatefulWidget {
  Salaries({Key key}) : super(key: key);
  Employee employee = new Employee();

  @override
  _SalariesState createState() => _SalariesState();
}

class _SalariesState extends State<Salaries> {
  TextEditingController nameEmployee = TextEditingController();

  TextEditingController salary = TextEditingController();

  TextEditingController _valueController = TextEditingController();

  DateTime _selecteddate;

  bool checkedvalue = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              DemoLocalizations.of(context)
                  .translate('Operations', 'Salaries', key3: 'add_salaries'),
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
                          child: TypeAheadField(
                            hideSuggestionsOnKeyboardHide: false,
                            textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: widget.employee.name == null
                                        ? DemoLocalizations.of(context)
                                            .translate('Operations', 'Salaries',
                                                key3: 'employee_name')
                                        : widget.employee.name)),
                            suggestionsCallback: SearchEmployee().generate,
                            itemBuilder: (context, suggestion) {
                              final user = suggestion;
                              return ListTile(
                                title: Text(user.name),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                widget.employee = suggestion;
                              });
                            },
                            // ignore: missing_return
                            noItemsFoundBuilder: (context) {
                              return Center(
                                child: FittedBox(
                                  child: Text(
                                    DemoLocalizations.of(context).translate(
                                        'Operations', 'Salaries',
                                        key3: 'notFound'),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(fontSize: 18),
                            controller: salary,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                labelText: DemoLocalizations.of(context)
                                    .translate('Operations', 'Salaries',
                                        key3: 'amount'),
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (input) => input.isEmpty
                                ? DemoLocalizations.of(context).translate(
                                    'Operations', 'Salaries',
                                    key3: 'validator')
                                : null,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        _selecteddate == null
                            ? CheckboxListTile(
                                title: Text(
                                  DemoLocalizations.of(context).translate(
                                      'Operations', 'Salaries',
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
                                          'Operations', 'Salaries',
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
                        if (nameEmployee.text != '' && nameEmployee != null) {
                          showToast(context: context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: Text(DemoLocalizations.of(context)
                                        .translate('Operations', 'Salaries',
                                            key3: 'dialogValidator',
                                            key4: "title")),
                                    content: Text(DemoLocalizations.of(context)
                                        .translate('Operations', 'Salaries',
                                            key3: 'dialogValidator',
                                            key4: "content")),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                            DemoLocalizations.of(context)
                                                .translate(
                                                    'Operations', 'Salaries',
                                                    key3: 'dialogValidator',
                                                    key4: "btnBack")),
                                      )
                                    ],
                                  ));
                        }
                        //Bill bill = new Bill(value: )

                      } else {}

                      print(widget.employee.name);
                    },
                    child: Text(
                      DemoLocalizations.of(context).translate(
                          'Operations', 'Salaries',
                          key3: 'AddButton'),
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
