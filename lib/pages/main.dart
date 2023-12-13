import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatime/blocs/CategoryBloc.dart';
import 'package:teatime/blocs/ModifyTeaBloc.dart';
import 'package:teatime/pages/AddCategoryPage.dart';
import 'package:teatime/pages/AddTeaPage.dart';
import 'package:teatime/widgets/Drawer/DrawerWidget.dart';
import 'package:teatime/pages/ModifyTeaPage.dart';
import '../blocs/ModifyCategoryBloc.dart';
import '../blocs/TeaBloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teatime/firebase_options.dart';

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

          BlocProvider<AddTeaBloc>(create: (BuildContext context) => AddTeaBloc(),),
          BlocProvider<AddCategoryBloc>(create: (BuildContext context) => AddCategoryBloc(),),
          BlocProvider<ModifyTeaBloc>(create: (BuildContext context) => ModifyTeaBloc(),),
          BlocProvider<ModifyCategoryBloc>(create: (BuildContext context) => ModifyCategoryBloc(),),

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
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late FirebaseFirestore _db;

  @override
  void initState() {
    super.initState();
    _db = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {

    var categories = _db.collection('categories').snapshots();
    var teas = _db.collection('teas').snapshots();

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

      body: const ListCatAndTea(),
    );
  }
}

class ListCatAndTea extends StatelessWidget {
  const ListCatAndTea({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for three lists
    List<List<String>> listTeas = [
      ['Item 1', 'Item 2', 'Item 3'],
      ['Item A', 'Item B', 'Item C', 'Item D'],
      ['Item X', 'Item Y', 'Item Z'],
    ];

    List<List<String>> listCategories = [
      ['Thé vert'],
      ['Thé noir'],
      ['Infusion'],
    ];

    return ListView.builder(
      itemCount: listTeas.length,
      itemBuilder: (context, index) {
        return CatAndTea(listTeas: listTeas[index], listCategories: listCategories[index]);
      },
    );
  }
}

class CatAndTea extends StatelessWidget {
  final List<String> listTeas;
  final List<String> listCategories;

  CatAndTea({required this.listTeas, required this.listCategories});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [

          ListTile(
            title: Text(listCategories[0]),   //Catégories
            onTap: () {
              Navigator.pushNamed(context, '/modifyCategory');
            }
          ),

          const Divider(),

          ListView.builder(
            itemCount: listTeas.length,     //Thés
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom:5.0),     //Thés Widget
                child: ListTile(
                  leading: Image.asset('lib/pictures/teas/DefaultTeaPicture.png'),
                  title: Text(listTeas[index]),
                  onTap: () {
                    Navigator.pushNamed(context, '/modifyTea');
                  }
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
