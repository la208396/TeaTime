import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatime/blocs/CategoryBloc.dart';



class AddCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AddCategoryBloc, AddCategoryState>(
      builder: (context, state)
    {

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

        body: const Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            Padding(
              padding:  EdgeInsets.all(20.0),
              child:  Text(
                'Ajouter une catégorie',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 24.0,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top : 40, left: 20.0, right: 20.0),

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nom de la catégorie : ',
                ),
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 15.0,
                ),
              ),
            ),

          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Ajouter la catégorie
          },
          child: const Icon(Icons.add),
        )

      );
    }
    );
  }
}