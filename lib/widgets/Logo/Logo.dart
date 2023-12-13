import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Drawer/DrawerWidget.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        toolbarHeight: 80.0,

        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),

            child: Image.asset(
              'lib/pictures/logos/Logo3.png',
              fit: BoxFit.cover,
              width: 100.0,
              height: 80.0,
            ),
          ),
        ),

      ),

      drawer: DrawerWidget(),

    );
  }
}