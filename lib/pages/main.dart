import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatime/blocs/CategoryBloc.dart';
import 'package:teatime/blocs/ModifyTeaBloc.dart';
import 'package:teatime/models/Firestore_service.dart';
import 'package:teatime/models/Tea_model.dart';
import 'package:teatime/pages/AddCategoryPage.dart';
import 'package:teatime/pages/AddTeaPage.dart';
import 'package:teatime/widgets/Drawer/DrawerWidget.dart';
import 'package:teatime/pages/ModifyTeaPage.dart';
import '../blocs/ModifyCategoryBloc.dart';
import '../blocs/TeaBloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teatime/firebase_options.dart';
import 'package:teatime/models/Tea_model.dart';
import 'package:teatime/models/Category_model.dart';
import 'ModifyCategoryPage.dart';


Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(       //Que pour la main page ??

      providers: [
        BlocProvider<TeaBloc>(
          create: (context) => TeaBloc(FirestoreService()),
        ),
      ],

      child: MaterialApp(       //Pour toute les pages ??
        title: 'Tea Time',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
          useMaterial3: true,
          fontFamily: 'TeaTimeStyle',     //Mettre tout le text de l'app en brun pour ne pas devoir le réécrire
        ),

        home: const MyHomePage(),      //Faire les autres pages dans ce style ??

        routes: {
          '/addTea': (context) => AddTeaPage(),
          '/addCategory': (context) => AddCategoryPage(),
          '/modifyTea': (context) => ModifyTeaPage(),
          '/modifyCategory': (context) => ModifyCategoryPage(),
        }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    BlocProvider.of<TeaBloc>(context).add(LoadCategoriesAndTeas());
    super.initState();
  }

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

      body: Center(
        child: BlocBuilder<TeaBloc, TeaState>(
          builder: (context, state) {

            if(state is TeaInitial){
              context.read<TeaBloc>().add(LoadCategoriesAndTeas());
              return const CircularProgressIndicator(color: Colors.brown);
            }

            if(state is TeaLoaded){

              final categories = state.categories;

              return ListView.builder(
                    itemCount: categories.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: GestureDetector(
                          onLongPress: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.add),
                                        title: Text('Ajouter un thé'),
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, '/addTea', arguments: categories[index]);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text('Supprimer la catégorie'),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Confirmation'),
                                                content: const Text('Voulez-vous vraiment supprimer cette catégorie ?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Annuler'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context.read<TeaBloc>().add(DeleteCategory(categories[index]));
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Supprimer'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },

                      child: ExpansionTile(
                          title: Text(categories[index].name),
                          children: [
                            ListView.builder(
                              itemCount: categories[index].teas.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, teaIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: ListTile(
                                    leading: Image.asset('lib/pictures/teas/DefaultTeaPicture.png'),
                                    title: Text(categories[index].teas[teaIndex].name),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/modifyTea',   arguments: {
                                        'tea': categories[index].teas[teaIndex],
                                        'category': categories[index],
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                  );
                },
              );

            }else{
              return const Text('Error');
            }
          },
        ),
      )
    );
  }
}