// ignore: must_be_immutable
import 'package:flutter/material.dart';

//this class is in logs page is title
class BoardCheckLogs extends StatelessWidget {
  BoardCheckLogs({
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
  List<Color> color = [
    Colors.blue[200],
    Colors.pink[200],
    Colors.green[200],
    Colors.grey[300],
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.156,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.26,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: color[position]),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                title.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Text(
                total.toString() + '  SP',
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
      ],
    );
  }
}
