import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatime/blocs/ModifyTeaBloc.dart';
import 'package:teatime/blocs/TeaBloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teatime/pages/main.dart';
import 'package:teatime/models/Tea_model.dart';

class ModifyTeaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Tea tea = ModalRoute.of(context)!.settings.arguments as Tea;

    return BlocBuilder<TeaBloc, TeaState>(
        builder: (context, state)
        {
          if (state is TeaLoaded) {
            final currentTea = state.categories
                .expand((category) => category.teas)
                .firstWhere((t) => t.name == tea.name);


            return Scaffold(

              backgroundColor: Colors.white,

              appBar: AppBar(
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .inversePrimary,
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

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentTea.name,
                            style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 24.0,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Afficher la boîte de dialogue de confirmation
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmation'),
                                    content: const Text(
                                        'Voulez-vous vraiment supprimer ce thé ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Annuler la suppression
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Annuler'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Supprimer le thé
                                          Navigator.of(context)
                                              .pop(); //Remplacer par des routes
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Supprimer'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                      child: RatingBar.builder(
                        initialRating: currentTea.quoting.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => const Icon(
                          Icons.ac_unit,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // Mettre à jour la valeur de 'quoting' dans l'objet currentTea
                          currentTea.quoting = rating.toInt();
                          print("Updated rating: ${currentTea.quoting}");
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description :',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.brown,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            height: 180,
                            child: TextField(
                              controller: TextEditingController(text: currentTea.description),
                              expands: true,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Avis :',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.brown,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            height: 180,
                            child: TextField(
                              controller: TextEditingController(text: currentTea.personalOpinion),
                              expands: true,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),

                      child: ElevatedButton( //Faire un bloc pour la caméra ou gérer dans le bloc ModifyTeaBloc ??
                        onPressed: () async {
                          final XFile? pickedFile =
                          await ImagePicker().pickImage(
                              source: ImageSource.camera);

                          if (pickedFile != null) {
                            // Créez le chemin complet pour le nouveau fichier
                            String newPath = '../pictures/teas/${DateTime
                                .now()
                                .millisecondsSinceEpoch}.png'; //Erreur chemin

                            // Copiez le fichier dans le nouveau chemin
                            File(pickedFile.path).copy(newPath);

                            print("Image enregistrée : $newPath");
                          }
                        },
                        child: const Text('Prendre une photo'),
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
          }
          return const CircularProgressIndicator();
        }
    );
  }
}