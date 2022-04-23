import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '/localization/local_keys.g.dart';

class Settings_Screen extends StatefulWidget {
  @override
  _Settings_viewstate createState() => _Settings_viewstate();
}

class _Settings_viewstate extends State<Settings_Screen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(8),
              color: Colors.blue[600],
              child: ListTile(
                onTap: () {},
                title: Text(
                  'John Doe',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ExpansionTileCard(
                    baseColor: Colors.white,
                    key: cardA,
                    leading: Icon(
                      FontAwesomeIcons.language,
                      color: Colors.blue[600],
                    ),
                    title: Text('change_lang'),
                    children: <Widget>[
                      Divider(
                        thickness: 2,
                      ),
                      InkWell(
                        onTap: () async =>
                            await context.setLocale(Locale('en')),
                        child: ListTile(
                          title: Text('English'),
                        ),
                      ),
                      InkWell(
                        onTap: () async =>
                            await context.setLocale(Locale('ar')),
                        child: ListTile(
                          title: Text('العربية'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ExpansionTileCard(
                    baseColor: Colors.white,
                    leading: Icon(
                      FontAwesomeIcons.moon,
                      color: Colors.blue[600],
                    ),
                    title: Text('Change Theme'),
                    children: <Widget>[
                      Divider(
                        thickness: 2,
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('Light'),
                          trailing: Icon(FontAwesomeIcons.sun),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text('Dark'),
                          trailing: Icon(FontAwesomeIcons.cloudMoon),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
