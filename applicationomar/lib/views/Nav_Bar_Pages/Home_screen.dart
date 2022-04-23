import 'package:applicationomar/localization/localizationFile.dart';
import 'package:applicationomar/models/Human/Employee.dart';
import 'package:flutter/material.dart';
import '/widgets/Calendar_card.dart';

import '/localization/local_keys.g.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '/widgets/DailyBox_Card.dart';
import '/widgets/Reminder_Card.dart';

class Homescreen extends StatefulWidget {
  List<Employee> employees = [];
  @override
  _Homeviewstate createState() => _Homeviewstate();
}

class _Homeviewstate extends State<Homescreen> with TickerProviderStateMixin {
  ScrollController _scrollController;
  bool _showBackToTopButton = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 100) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 800), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              child: Icon(Icons.arrow_upward),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.045,
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: Text(
                DemoLocalizations.of(context).translate('Home', 'Welcome_text'),
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Column(
              children: [
                Container(
                  height: ScreenUtil().screenHeight / 5.2,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: CalenderCard(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: ScreenUtil().screenHeight / 5,
                  child: RemindersCard(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  width: double.infinity.w,
                  height: ScreenUtil().screenHeight / 5,
                  child: DailyBoxCard(),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
