import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class CalenderCard extends StatefulWidget {
  @override
  _CalenderCardState createState() => _CalenderCardState();
}

class _CalenderCardState extends State<CalenderCard> {
  static final DateTime now = DateTime.now();
  static final DateFormat dayformatter = DateFormat.d('en_US');
  final String dayformatted = dayformatter.format(now);

  static final DateFormat weekdayformatter = DateFormat.E('en_US');
  final String weekdayformatted = weekdayformatter.format(now);

  static final DateFormat monthformatter = DateFormat.MMMM('en_US');
  final String monthformatted = monthformatter.format(now);

  static final DateFormat yearformatter = DateFormat.y('en_US');
  final String yearformatted = yearformatter.format(now);

  var h_date = HijriCalendar.fromDate(DateTime.now());
  var currentHijri = HijriCalendar.now().hMonth;

  String getHijri() {
    switch (currentHijri) {
      case 1:
        return "محرم";
        break;
      case 2:
        return "صفر";
        break;
      case 3:
        return "ربيع الأول";
        break;
      case 4:
        return "ربيع الثاني";
        break;
      case 5:
        return "جمادى الأولى";
        break;
      case 6:
        return "جمادى الثانية";
        break;
      case 7:
        return "رجب";
        break;
      case 8:
        return "شعبان";
        break;
      case 9:
        return "رمضان";
        break;
      case 10:
        return "شوال";
        break;
      case 11:
        return "ذو القعدة";
        break;
      case 12:
        return "ذو الحجة";
        break;

      default:
        return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    // final viewsize = MediaQuery.of(context).size.width;
    // final screewidth = MediaQuery.of(context).size.width;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[400])),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '$monthformatted',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    dayformatted,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   child:

          Expanded(
            child: Container(
              color: Colors.green[200],
              child: Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    getHijri(),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    h_date.toFormat('dd'),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
