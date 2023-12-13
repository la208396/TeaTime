import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        return Drawer(
          child: Column(

            children: <Widget>[

                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.brown,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),

                        child: IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Text(
                          'Tea Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ListTile(
                title: Text('Ajouter un thé'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/addTea');
                },
              ),

              ListTile(
                title: Text('Ajouter une catégorie'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/addCategory');
                },
              ),

            ],
          ),
        );
  }
}