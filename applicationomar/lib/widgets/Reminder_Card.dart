import 'package:applicationomar/Api/fetchData.dart';
import 'package:applicationomar/localization/localizationFile.dart';
import 'package:applicationomar/views/Todo/TodoHomePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemindersCard extends StatefulWidget {
  @override
  _RemindersCardState createState() => _RemindersCardState();
}

class _RemindersCardState extends State<RemindersCard> {
  List <getTasksForDay>() {
    return FetchData.todo.where((element) {
      return element.dateTodo.day == DateTime.now().day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: InkWell(
        splashColor: Colors.yellow,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodoPage()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Card(
              // margin: EdgeInsets.all(10),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DemoLocalizations.of(context)
                      .translate('Home', 'reminder_text'),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.brown[700],
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white,
                  ),
                  // child: Image.asset(
                  //   Assets.remindeicon,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                FetchData.todo.length != 0
                    ? Text(FetchData.todo[0].titleTodo)
                    : Expanded(child: Container())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
