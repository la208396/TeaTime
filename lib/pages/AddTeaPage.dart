import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../blocs/TeaBloc.dart';
import '../models/Category_model.dart';


class AddTeaPage extends StatelessWidget {

  final TextEditingController _teaControllerName = TextEditingController();
  final TextEditingController _teaControllerDescription = TextEditingController();
  final TextEditingController _teaControllerpersonalOpinion = TextEditingController();
  final TextEditingController _teaControllerQuoting = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final Category category = ModalRoute.of(context)!.settings.arguments as Category;
    int teaQuoting = 0;

    return BlocBuilder<TeaBloc, TeaState>(
      builder: (context, state) {

      if (state is TeaLoaded) {

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

          body: SingleChildScrollView(

            child :Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[

                 const Padding(
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

                  child: Text(
                    'Catégorie sélectionnée : ${category.name}',
                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 15.0,
                    ),
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.only(top : 40, left: 20.0, right: 20.0),
                   child: TextField(
                     controller: _teaControllerName,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Nom du thé : ',
                     ),
                     style: const TextStyle(
                       color: Colors.brown,
                       fontSize: 15.0,
                     ),
                   ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top : 40, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: _teaControllerDescription,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description : ',
                    ),
                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 15.0,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top : 40, left: 20.0, right: 20.0),
                  child: TextField(
                    controller: _teaControllerpersonalOpinion,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Avis : ',
                    ),
                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 15.0,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top : 40, left: 20.0, right: 20.0),
                  child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.ac_unit,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      teaQuoting = rating.toInt();
                    },
                  ),
                ),

              ],

            ),
          ),

          floatingActionButton: FloatingActionButton(         // Widget prédéfini dans Scafold et se met automatiquement en bas à droite
            onPressed: () {
              final teaName = _teaControllerName.text.trim();
              final teaDescription = _teaControllerDescription.text.trim();
              final teaPersonalOpinion = _teaControllerpersonalOpinion.text.trim();

              if (teaName.isNotEmpty && teaDescription.isNotEmpty) {
                context.read<TeaBloc>().add(AddTea(teaName, teaDescription, teaPersonalOpinion, teaQuoting, category));
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.add),
          ),

        );
      } else {
        return const CircularProgressIndicator(color: Colors.brown);
        }
      },
    );
  }
}