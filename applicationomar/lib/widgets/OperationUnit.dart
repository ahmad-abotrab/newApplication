import 'package:flutter/material.dart';

class OperationUnit extends StatelessWidget {
  const OperationUnit({
    this.backgroundIconColor,
    this.colorDecorationParentContainer,
    this.onTapPressed,
    this.iconOperation,
    this.nameOperation,
    this.explainAboutOperation,
    Key key,
  }) : super(key: key);
  final Color colorDecorationParentContainer;
  final Color backgroundIconColor;
  final Function onTapPressed;
  final IconData iconOperation;
  final String nameOperation;
  final String explainAboutOperation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
      height: 115,
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorDecorationParentContainer,
          borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        splashColor: Colors.green,
        onTap: onTapPressed,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.008),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: backgroundIconColor,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        iconOperation,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              FittedBox(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.06),
                  child: Container(
                    child: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          runSpacing: 5,
                          spacing: 5,
                          direction: Axis.vertical,
                          children: [
                            Text(
                              nameOperation,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              explainAboutOperation,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900].withOpacity(0.4),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
