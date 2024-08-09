import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatime/blocs/ModifyTeaBloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teatime/pages/main.dart';
import 'package:teatime/blocs/TeaBloc.dart';


import '../blocs/ModifyCategoryBloc.dart';

class ModifyCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TeaBloc, TeaState>(
      builder: (context, state) {

        return Scaffold(

          backgroundColor: Colors.white,

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

          body: SingleChildScrollView(

            child :Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nom de la catégorie',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 24.0,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Voulez-vous vraiment supprimer cette catégorie ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Supprimer le thé
                                      Navigator.of(context).pop();      //Remplacer par des routes
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Supprimer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),

              ],

            ),
          ),

          floatingActionButton: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Valider',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),

        );
      },
    );
  }
}