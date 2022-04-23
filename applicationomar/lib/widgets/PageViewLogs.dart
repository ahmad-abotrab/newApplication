
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'BoardCheckLogs.dart';
import 'detialsBills.dart';

class PageViewLogs extends StatefulWidget {
  PageViewLogs({
    Key key,
    this.position,
    this.colorBoard,
    this.title,
    this.total,
  }) : super(key: key);
  final Color colorBoard;
  final String title;
  final double total;
  final int position;

  @override
  _PageViewLogsState createState() => _PageViewLogsState();
}

class _PageViewLogsState extends State<PageViewLogs> {
  DateTime selecteddate;
  bool checkedvalue = true;
  List test = List.generate(5, (index) => 1);
  @override
  Widget build(BuildContext context) {
    datepicking() {
      DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1999, 3, 5),
              maxTime: DateTime.now(), onChanged: (date) {
        date = selecteddate;
      }, onConfirm: (date) {
        date = selecteddate;
      }, currentTime: DateTime.now(), locale: LocaleType.en)
          .then((pickedate) {
        if (pickedate == null) {
          return;
        }
        setState(() {
          selecteddate = pickedate;
        });
      });
    }

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          BoardCheckLogs(
            position: widget.position,
            title: widget.title,
            total: widget.total,
            colorBoard: widget.colorBoard,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          selecteddate == null
              ? Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.18),
                  child: CheckboxListTile(
                    title: Text(
                      "Present Time",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    activeColor: Colors.grey,
                    value: checkedvalue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedvalue = newValue;
                      });
                      datepicking();
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                )
              : TextButton(
                  onPressed: datepicking,
                  child: Text(
                    selecteddate == null
                        ? 'Select Date'
                        : '${DateFormat.yMEd().format(selecteddate)}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.06),
                  )),
          DetialsBills(test: test)
        ],
      ),
    );
  }
}
