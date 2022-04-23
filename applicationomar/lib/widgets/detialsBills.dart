import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DetialsBills extends StatelessWidget {
  const DetialsBills({
    Key key,
    @required this.test,
  }) : super(key: key);

  final List test;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: test.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: ExpansionTileCard(
                    animateTrailing: true,
                    trailing: Icon(Icons.arrow_drop_down),
                    initialElevation: 20,
                    elevation: 20,
                    borderRadius: BorderRadius.circular(10),
                    // baseColor: Colors.yellow[900],
                    title: Text('Digital Radio     89.99  x4'),
                    leading: Card(
                      color: Colors.blue[500],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sell',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    subtitle: Text('2021/5/22'),
                    children: [
                      ListTile(
                        title: Text('Product 1'),
                        subtitle: Text('date'),
                      ),
                      ListTile(
                        title: Text('Product 2'),
                        subtitle: Text('date'),
                      ),
                      ListTile(
                        title: Text('Product 3'),
                        subtitle: Text('date'),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
