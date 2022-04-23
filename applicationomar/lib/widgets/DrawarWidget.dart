import 'dart:async';
import 'dart:io';
import 'package:applicationomar/Api/Controller/HomeController.dart';
import 'package:applicationomar/localization/localizationFile.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/state_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';
import '../SecurityClass.dart';
import '/models/Human/Employee.dart';
import '/views/Register/Register.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    Key key,

    @required this.cardA,
  }) : super(key: key);
   Employee employee = Employee(id: '1', name: 'Ahmad', pin: '5555', career: 'مدير');
  final GlobalKey<ExpansionTileCardState> cardA;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // TextEditingController pinController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool styleActivePinColor = false;
  StreamController<ErrorAnimationType> errorController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GetBuilder(
              init: HomeController(),
              builder: (_) {
                return DrawerHeader(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor

                          // borderRadius: BorderRadius.only(
                          //     bottomLeft: Radius.circular(25),
                          //     bottomRight: Radius.circular(25)),
                          ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AvatarGlow(
                            endRadius: 30,
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 100),
                            glowColor: Colors.blue,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person_outline_rounded,
                                size: 50,
                              ),
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     MyApp.changeMode(context);
                          //   },
                          //   icon: MyApp().isDarkTheme
                          //       ? Icon(Icons.dark_mode, color: Colors.white)
                          //       : Icon(Icons.light, color: Colors.white),
                          // )
                        ],
                      ),
                      Expanded(child: Container()),
                      Text(
                        widget.employee.name,
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                      Expanded(child: Container()),
                      Text(
                        'id : ' + widget.employee.id,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      )
                    ],
                  ),
                );
              }),
          ListTile(
            leading: Icon(
              Icons.lock_open,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              DemoLocalizations.of(context).translate('Drawar', 'ActivateApp'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).hintColor,
              ),
            ),
            onTap: () {
              activeAppMethod(context);
              // Update the state of the app.
              // ...
            },
          ),
          // widget.employee.career == 'Manager' ||
          //         widget.employee.career == 'مدير'
               ListTile(
                  leading: Icon(
                    Icons.person_add_alt,
                    color: Theme.of(context).hintColor,
                  ),
                  title: Text(
                    DemoLocalizations.of(context)
                        .translate('Drawar', 'Register'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                    // Update the state of the app.
                    // ...
                  },
                ),
              // : null,
          ListTile(
            leading: Icon(
              Icons.support_agent,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              DemoLocalizations.of(context)
                  .translate('Drawar', 'technicalSupport'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).hintColor,
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          title: Text(DemoLocalizations.of(context)
                              .translate('Drawar', 'technicalSupport')),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(DemoLocalizations.of(context).translate(
                                    'Drawar', 'contentTechnincalSupport'))
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: IconButton(
                                    onPressed: () async {
                                      if (Platform.isIOS) {
                                        await FlutterPhoneDirectCaller
                                            .callNumber('0988242848');
                                      } else {
                                        if (Platform.isAndroid) {
                                          await FlutterPhoneDirectCaller
                                              .callNumber('0988242848');
                                        }
                                      }
                                    },
                                    icon: FaIcon(FontAwesomeIcons.phone),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: openTelegramApp,
                                    icon: FaIcon(FontAwesomeIcons.telegram,
                                        color: Color(0xff0088cc)),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: openwhatsapp,
                                    icon: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Color(0xff25D366),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]));
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
              leading: Icon(
                Icons.vpn_key_outlined,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                DemoLocalizations.of(context)
                    .translate('Drawar', 'ChangePassword'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).hintColor,
                ),
              ),
              onTap: () {}),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              DemoLocalizations.of(context).translate('Drawar', 'LogOut'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).hintColor,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/choiceUser',
              );
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }

  openwhatsapp() async {
    var whatsapp = "+963988242848";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  openTelegramApp() async {
    var whatsapp = "+963988242848";
    var whatsappURl_android =
        "telegram://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  Future<dynamic> activeAppMethod(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        contentPadding: EdgeInsets.only(
          top: 8.0,
        ),
        titlePadding: EdgeInsets.only(bottom: 8.0),
        title: Container(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 17,
              ),
              Text(
                DemoLocalizations.of(context)
                    .translate('Drawar', 'DialogActivate', key3: 'title'),
                style: TextStyle(color: Colors.white),
              ),
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
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Text(DemoLocalizations.of(context).translate(
                          'Drawar', 'DialogActivate',
                          key3: 'content')),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Security.maxNumberOfAttempts > Security.numberOfAttempts
                      ? Form(
                          key: formKey,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 30),
                              child: pinCodeText(context)),
                        )
                      : TextButton(
                          onPressed: () {},
                          child: Text(
                            DemoLocalizations.of(context)
                                .translate('choiceUser', 'OverTimesInterPin'),
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(DemoLocalizations.of(context)
                .translate('Drawar', 'DialogActivate', key3: "ButtonCancel")),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(DemoLocalizations.of(context)
                .translate('Drawar', 'DialogActivate', key3: "ButtonSure")),
          )
        ],
      ),
    );
  }

  buildSnackBar() {
    return SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey[600],
        elevation: 8,
        duration: Duration(milliseconds: 900),
        content: Text(DemoLocalizations.of(context)
            .translate('choiceUser', 'afterEnterPinAndItsCorrect')));
  }

  onComplete(v) async {
    if (v == widget.employee.pin) {
      setState(() {
        styleActivePinColor = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(buildSnackBar());
    } else {
      Security.numberOfAttempts++;
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: Text(DemoLocalizations.of(context)
                      .translate('choiceUser', 'titleDialog')),
                  content: Text(DemoLocalizations.of(context)
                          .translate('choiceUser', 'content_first') +
                      (Security.maxNumberOfAttempts - Security.numberOfAttempts)
                          .toString() +
                      DemoLocalizations.of(context)
                          .translate('choiceUser', 'content_second')),
                  actions: [
                    MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(DemoLocalizations.of(context)
                            .translate('choiceUser', 'buttonBackDialog')))
                  ]));
    }
  }

  PinCodeTextField pinCodeText(BuildContext context) {
    return PinCodeTextField(
      // readOnly: true,
      onChanged: (value) {},
      appContext: context,
      pastedTextStyle: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
      length: 4,
      // obscureText: true,
      // obscuringCharacter: '*',
      // obscuringWidget: FlutterLogo(
      //   size: 24,
      // ),
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        if (v.length < 3) {
          return DemoLocalizations.of(context)
              .translate('choiceUser', 'validatorPin');
        } else {
          return null;
        }
      },
      pinTheme: PinTheme(
        activeColor: Colors.green,
        // activeColor: styleActivePinColor ? Colors.green : Colors.red,
        inactiveFillColor: Colors.grey,
        inactiveColor: Colors.grey,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
      ),
      cursorColor: Colors.black,
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      errorAnimationController: errorController,
      // controller: pinController,
      keyboardType: TextInputType.number,
      boxShadows: [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onCompleted: onComplete,

      // onChanged: (value) {
      //   print(value);
      //   setState(() {
      //     currentText = value;
      //     print(currentText);
      //   });
      //   print(currentText);
      // },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
