import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyBoxCard extends StatefulWidget {
  @override
  _DailyBoxCardState createState() => _DailyBoxCardState();
}

class _DailyBoxCardState extends State<DailyBoxCard> {
  @override
  Widget build(BuildContext context) {
    bool value = true;

    // final viewsize = MediaQuery.of(context).size.height;
    // final screewidth = MediaQuery.of(context).size.width;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Stack(
        children: [
          InkWell(
            splashColor: Colors.green[200],
            onTap: () {},
            child: Container(
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: value ? Colors.green[200] : Colors.red[400],
                height: double.infinity.h,
                width: 95,
                child: Icon(
                  value
                      ? Icons.arrow_drop_up_outlined
                      : Icons.arrow_drop_down_outlined,
                  size: 40,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              // Switch(
              //     value: value,
              //     onChanged: (newvalue) {
              //       setState(() {
              //         value = newvalue;
              //       });
              //     }),
            ],
          ),
          // Positioned(
          //     top: 0,
          //     bottom: 0,
          //     right: viewsize / 4,
          //     left: 0,
          //     child: VerticalDivider(
          //       thickness: 2,
          //     )),
          // Positioned(
          //     top: 20,
          //     right: screewidth / 2 - 20,
          //     child: Text(
          //       'Your Status : ',
          //       style: TextStyle(fontSize: 20),
          //     ))
        ],
      ),
    );
  }
}
