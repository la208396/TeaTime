import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/TeaBloc.dart';

class AddTeaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TeaBloc, TeaState>(
      builder: (context, state) {

        return Scaffold(

          backgroundColor: Colors.white,      //Couleur intéressante ??

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

          body: const SingleChildScrollView(

            child :Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[

                 Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Ajouter un thé',
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
                      labelText: 'Nom du thé : ',
                    ),
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 15.0,
                    ),
                  ),
                ),

                 Padding(
                  padding: EdgeInsets.only(top : 40, left: 20.0, right: 20.0),

                  child: TextField(               //List avec toutes les catégories existantes
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Catégorie : ',
                    ),
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 15.0,
                    ),
                  ),
                ),

                 Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                  child: SizedBox(
                    height: 200,
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        border: OutlineInputBorder(),
                        labelText: 'Description : ',
                      ),
                    ),
                  ),
                ),

              ],

            ),
          ),

          floatingActionButton: FloatingActionButton(         // Widget prédéfini dans Scafold et se met automatiquement en bas à droite
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.add),
          ),

        );
      },
    );
  }
}