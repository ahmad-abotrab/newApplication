import 'package:applicationomar/Api/Controller/DialogAddTodoController.dart';
import 'package:applicationomar/Api/fetchData.dart';
import 'package:applicationomar/localization/localizationFile.dart';
import 'package:applicationomar/models/Todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TodoPage extends StatefulWidget {
  TodoPage({Key key}) : super(key: key);
  List<Todo> todo = [];
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(DemoLocalizations.of(context).translate('Todo', 'TodoAppBar')),
        actions: [
          IconButton(
              icon: FaIcon(FontAwesomeIcons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              }),
          // IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.filter))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: Text(
              DemoLocalizations.of(context).translate('Todo', 'TodoTitle'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          FetchData.todo.length == 0 || FetchData.todo == null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                      child: Text(DemoLocalizations.of(context)
                          .translate('Todo', 'notask'))),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: FetchData.todo.length,
                    itemBuilder: (_, int index) {
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            Todo todoElement = new Todo();
                            setState(() {
                              todoElement = FetchData.todo[index];
                              FetchData.todo.removeAt(index);
                            });

                            final snackBar = new SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              backgroundColor: Colors.grey[600],
                              elevation: 12,
                              duration: Duration(seconds: 2),
                              content: RichText(
                                text: TextSpan(
                                  text: DemoLocalizations.of(context).translate(
                                      'Todo', 'ListTitle',
                                      key3: "textSnackbar"),
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: todoElement.titleTodo,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              action: SnackBarAction(
                                label: DemoLocalizations.of(context).translate(
                                    'Todo', 'ListTitle',
                                    key3: "undo"),
                                onPressed: () {
                                  setState(() {
                                    FetchData.todo.insert(index, todoElement);
                                  });
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          background: Container(
                            color: Colors.red,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: ListTile(
                            dense: true,
                            leading: Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.018),
                                child: Text(FetchData.todo[index].type)),
                            title: Text(
                                FetchData.todo[index].titleTodo == null ||
                                        FetchData.todo[index].titleTodo == ''
                                    ? DemoLocalizations.of(context).translate(
                                        'Todo', 'ListTitle',
                                        key3: "NoTitle")
                                    : FetchData.todo[index].titleTodo),
                            subtitle: Text(widget.dateFormat
                                    .format(FetchData.todo[index].dateTodo) +
                                " - " +
                                FetchData.todo[index].timeOfDayTodo.hour
                                    .toString() +
                                ":" +
                                FetchData.todo[index].timeOfDayTodo.minute
                                    .toString()),
                          ),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(Icons.create),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateNewReminder()));
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CreateNewReminder extends StatefulWidget {
  CreateNewReminder({
    Key key,
  }) : super(key: key);
  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();
  DateTime pickerDate = new DateTime.now();
  DateFormat formateDate = DateFormat('yyyy-MM-dd');
  DateFormat formateTime = DateFormat('hh:mm');
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  TextEditingController timeController = TextEditingController();
  TextEditingController date = new TextEditingController();
  Function(Object) callback;

  @override
  _CreateNewReminderState createState() => _CreateNewReminderState();
}

class _CreateNewReminderState extends State<CreateNewReminder> {
  @override
  void initState() {
    widget.pickerDate = DateTime.now();
    widget.selectedTime =
        TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    super.initState();
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime,
    );
    if (picked != null)
      setState(() {
        widget.selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DemoLocalizations.of(context)
              .translate('Todo', 'AddewTask', key3: "appBar"),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07),
            child: GetBuilder<DialogAddtTodoController>(
              init: DialogAddtTodoController(),
              builder: (_) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    makeTitle(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    // GetBuilder<DialogAddtTodoController>(
                    //   init: DialogAddtTodoController(),
                    //   builder: (_) {
                    //     return choiceTaskOrEvent();
                    //   },
                    // ),
                    GetBuilder<DialogAddtTodoController>(
                      init: DialogAddtTodoController(),
                      builder: (_) {
                        return Get.find<DialogAddtTodoController>().index == 0
                            ? addNewTask(context)
                            : addNewEvent(context);
                      },
                    ),
                  ],
                );
              },
            )),
      ),
      floatingActionButton: GetBuilder<DialogAddtTodoController>(
          init: DialogAddtTodoController(),
          builder: (_) {
            return FloatingActionButton(
                child: Text(DemoLocalizations.of(context)
                    .translate('Todo', 'AddewTask', key3: "addButton")),
                backgroundColor: Colors.grey,
                onPressed: () {
                  Todo todo = new Todo(
                      type: Get.find<DialogAddtTodoController>().index == 0
                          ? 'task'
                          : 'Event',
                      timeOfDayTodo: widget.selectedTime,
                      dateTodo: widget.pickerDate,
                      titleTodo: widget.title.text,
                      description: widget.description.text);

                  FetchData.todo.add(todo);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/TodoPage', (route) => false);
                });
          }),
    );
  }

  makeTitle(BuildContext context) {
    return TextFormField(
      controller: widget.title,
      decoration: InputDecoration(
          hintText: DemoLocalizations.of(context)
              .translate('Todo', 'AddewTask', key3: "appBar"),
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(DemoLocalizations.of(context)
              .translate('Todo', 'AddewTask', key3: "appBar")),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey))),
    );
  }

  addNewTask(context) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.024,
            ),
            TextButton(
                onPressed: () {
                  pickDate();
                },
                child: Text(widget.formateDate.format(widget.pickerDate))),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.024,
            ),
            TextButton(
                onPressed: () {
                  selectTime(context);
                },
                child: Text(widget.selectedTime.hour.toString() +
                    ":" +
                    widget.selectedTime.minute.toString())),
            Expanded(child: Container()),
          ],
        ),
        TextFormField(
          maxLines: 10,
          controller: widget.description,
          decoration: InputDecoration(
              helperText: DemoLocalizations.of(context)
                  .translate('Todo', 'AddewTask', key3: "desc"),
              hintText: '\n' +
                  DemoLocalizations.of(context)
                      .translate('Todo', 'AddewTask', key3: "desc"),
              hintStyle: TextStyle(color: Colors.grey),
              // label: Text(DemoLocalizations.of(context)
              //     .translate('Todo', 'AddewTask', key3: "desc")),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey))),
        )
        // TextFormField(
        //   maxLines: 10,
        //   enabled: true,
        //   decoration: InputDecoration(
        //       contentPadding: EdgeInsets.only(
        //         left: MediaQuery.of(context).size.width * 0.06,
        //       ),
        //       helperText: DemoLocalizations.of(context)
        //           .translate('Todo', 'AddewTask', key3: "desc"),
        //       hintText: '\n' +
        //           DemoLocalizations.of(context)
        //               .translate('Todo', 'AddewTask', key3: "desc"),
        //       hintStyle: TextStyle(color: Colors.grey),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        //       enabledBorder:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        // )
      ],
    ));
  }

  pickDate() async {
    DateTime datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 75),
      initialDate:
          widget.pickerDate == null ? DateTime.now() : widget.pickerDate,
    );
    if (widget.date != null && datetime != null) {
      setState(() {
        widget.pickerDate = datetime;
        widget.pickerDate = datetime;
      });
    }
  }

  Column addNewEvent(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.024,
            ),
            TextButton(
                onPressed: () {
                  pickDate();
                },
                child: Text(widget.formateDate.format(widget.pickerDate))),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.024,
            ),
            TextButton(
                onPressed: () {
                  selectTime(context);
                },
                child: Text(widget.selectedTime.hour.toString() +
                    ":" +
                    widget.selectedTime.minute.toString())),
            Expanded(child: Container()),
          ],
        ),
        TextFormField(
          maxLines: 6,
          enabled: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.06,
              ),
              helperText: 'description',
              hintText: '\nDescription...',
              hintStyle: TextStyle(color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        )
      ],
    );
  }

  Row choiceTaskOrEvent() {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              Get.find<DialogAddtTodoController>().updateIndex(0);
            },
            child: Text(
              DemoLocalizations.of(context)
                  .translate('Todo', 'AddewTask', key3: "task"),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: Get.find<DialogAddtTodoController>().index == 0
                      ? FontWeight.bold
                      : FontWeight.normal,
                  decoration: TextDecoration.underline),
            )),
        TextButton(
            onPressed: () {
              Get.find<DialogAddtTodoController>().updateIndex(1);
            },
            child: Text(
              DemoLocalizations.of(context)
                  .translate('Todo', 'AddewTask', key3: "event"),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: Get.find<DialogAddtTodoController>().index == 1
                      ? FontWeight.bold
                      : FontWeight.normal,
                  decoration: TextDecoration.underline),
            )),
      ],
    );
  }
}
