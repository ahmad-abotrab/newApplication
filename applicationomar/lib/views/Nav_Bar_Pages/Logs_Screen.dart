import 'package:applicationomar/Api/PdfApi.dart';
import 'package:applicationomar/Api/PdfBillApi.dart';
import 'package:applicationomar/localization/localizationFile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/Api/Controller/LogsController.dart';
import '/Api/fetchData.dart';
import '/widgets/BoardCheckLogs.dart';

class ContentCardPage {
  String title;
  double total;
  Color colorBoard;
  ContentCardPage({this.title, this.colorBoard, this.total});
}

// ignore: must_be_immutable
class LogsScreen extends StatelessWidget {
  DateTime date = DateTime.now();

  buildChildrenOfColumnContent(context) {
    List<String> titleOfContent = [
      DemoLocalizations.of(context).translate('LogsScreen', 'earning'),
      DemoLocalizations.of(context).translate('LogsScreen', 'Looses'),
      DemoLocalizations.of(context).translate('LogsScreen', 'Subject_MoreSale'),
      DemoLocalizations.of(context)
          .translate('LogsScreen', 'Customer_MostImportant'),
    ];
    List<Widget> children = [];
    for (String string in titleOfContent) {
      children.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(string,
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            Text(
              'value',
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            )
          ],
        ),
      );
      children.add(SizedBox(
        height: MediaQuery.of(context).size.width * 0.02,
      ));
    }
    TextButton textButton = TextButton(
      child: Text(
        DemoLocalizations.of(context).translate('LogsScreen', 'DetialsButton'),
        style: TextStyle(
          color: Theme.of(context).hintColor,
        ),
      ),
      onPressed: () {},
    );
    Row row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textButton,
        Expanded(
          child: Container(),
        ),
      ],
    );
    children.add(row);
    children.add(SizedBox(
      height: MediaQuery.of(context).size.width * 0.02,
    ));
    return children;
  }

  buildContentWidget(context) {
    return Container(
      child: Column(
        children: buildChildrenOfColumnContent(context),
      ),
    );
  }

  builderFunctionYear(context, titleStep) {
    return Expanded(
      child: Stepper(
        key: Key("mysuperkey-" + titleStep.length.toString()),
        onStepTapped: (value) {
          Get.find<LogsController>().updateValueStep(value);
        },
        physics: ScrollPhysics(),
        type: StepperType.vertical,
        steps: getSteps(titleStep, context),
        currentStep: LogsController.currentStep,
        onStepContinue: () {
          Get.find<LogsController>().typeOfStepper == 'year'
              ? Get.find<LogsController>().updateType('month')
              : Get.find<LogsController>().typeOfStepper == 'month'
                  ? Get.find<LogsController>().updateType('week')
                  : Get.find<LogsController>().typeOfStepper == 'week'
                      ? Get.find<LogsController>().updateType('day')
                      : Get.find<LogsController>().typeOfStepper == 'day'
                          ? Get.find<LogsController>().updatePageView(0)
                          : Get.find<LogsController>().updateType('year');
          ;
          Get.find<LogsController>().typeOfStepper != 'day'
              ? Get.find<LogsController>().updateValueStep(0)
              : Get.find<LogsController>()
                  .updateValueStep(LogsController.currentStep);
        },
        onStepCancel: () {
          print('hello');
        },
        // controlsBuilder:
        //     (BuildContext context, ControlsDetails controlsDetails) {
        //   return Row(
        //     children: <Widget>[
        //       Container(
        //         width: 80,
        //         height: 45,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(16),
        //           color: Theme.of(context).primaryColorDark, 
        //         ),
        //         child: TextButton(
        //           onPressed: controlsDetails.onStepContinue,
        //           child: Text(
        //             DemoLocalizations.of(context)
        //                 .translate('LogsScreen', 'StepperNext'),
        //             style: TextStyle(color: Theme.of(context).hintColor),
        //           ),
        //         ),
        //       ),
        //       TextButton(
        //         onPressed: controlsDetails.onStepCancel,
        //         child: Text(
        //           DemoLocalizations.of(context)
        //               .translate('LogsScreen', 'StepperBack'),
        //           style: TextStyle(color: Theme.of(context).hintColor),
        //         ),
        //       ),
        //     ],
        //   );
        // },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: GetBuilder<LogsController>(
          init: LogsController(),
          builder: (_) {
            List<String> titleStep = [];

            titleStep = Get.find<LogsController>().typeOfStepper == 'year'
                ? FetchData().getListYears()
                : Get.find<LogsController>().typeOfStepper == 'month'
                    ? FetchData.months(context)
                    : Get.find<LogsController>().typeOfStepper == 'week'
                        ? FetchData.week(context)
                        : FetchData.days(context);
            Get.find<LogsController>().updateTitleStep(titleStep);
            return PageView(
              controller: Get.find<LogsController>().pageController,
              children: [
                Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  GetBuilder<LogsController>(
                      init: LogsController(),
                      builder: (_) {
                        return BoardCheckLogs(
                          position: 0,
                          title: Get.find<LogsController>().titleStep == null ||
                                  Get.find<LogsController>().titleStep[
                                          LogsController.currentStep] ==
                                      null
                              ? Get.find<LogsController>().typeOfStepper
                              : Get.find<LogsController>()
                                  .titleStep[LogsController.currentStep],
                          total: 0,
                          colorBoard: Colors.blue,
                        );
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  GetBuilder<LogsController>(
                      init: LogsController(),
                      builder: (_) {
                        return builderFunctionYear(context, titleStep);
                      })
                ]),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    BoardCheckLogs(
                      position: 0,
                      title: Get.find<LogsController>().typeOfStepper != 'day'
                          ? DateFormat('EEEE').format(date)
                          : Get.find<LogsController>()
                              .titleStep[LogsController.currentStep],
                      total: LogsController.currentStep.toDouble(),
                      colorBoard: Colors.blue,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    GetBuilder(
                        init: LogsController(),
                        builder: (_) {
                          return SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).size.height * 0.45,
                              child: listViewBillForCustomer(context),
                            ),
                          );
                        })
                  ],
                ),
              ],
            );
          },
        ));
  }

// this widget to open pdf file helped by classes (pdfBillApi and pdfApi)
  Future<dynamic> tapToOpenPdfBill(bill, context) async {
    final file = await PdfBilleApi.generate(
        bill, MediaQuery.of(context).size.width * 0.9);
    PdfApi.openFile(file);
  }

  ListView listViewBillForCustomer(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm');
    return ListView.builder(
        itemCount: Get.find<LogsController>().sellsInThisDay.length,
        itemBuilder: (_, int index) {
          return ListTile(
            onTap: () {
              tapToOpenPdfBill(
                  Get.find<LogsController>().sellsInThisDay[index], context);
            },
            leading: Text(
              Get.find<LogsController>().sellsInThisDay[index].id,
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            title: Text(
              Get.find<LogsController>().sellsInThisDay[index].date == null
                  ? '0'
                  : dateFormat.format(
                      Get.find<LogsController>().sellsInThisDay[index].date),
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            trailing: Text(
              Get.find<LogsController>().sellsInThisDay[index].value.toString(),
              style: TextStyle(
                color: Theme.of(context).hintColor == Colors.white
                    ? Colors.white
                    : Colors.green[300],
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        });
  }

  getSteps(titleStep, context) {
    List<Step> steps = [];
    for (String string in titleStep) {
      steps.add(
        Step(
          isActive: string == titleStep[LogsController.currentStep],
          state: StepState.indexed,
          title: Text(
            string,
            style: TextStyle(
              color: Theme.of(context).hintColor,
            ),
          ),
          content: buildContentWidget(context),
        ),
      );
    }
    return steps;
  }
}
