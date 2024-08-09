import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatime/blocs/CategoryBloc.dart';
import 'package:teatime/blocs/ModifyTeaBloc.dart';
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
          BlocProvider<TeaBloc>(create: (BuildContext context) => TeaBloc(),),
          BlocProvider<CategoryBloc>(create: (BuildContext context) => CategoryBloc(),),
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

      body: Center(
        child: BlocBuilder<TeaBloc, TeaState>(
          builder: (context, state) {

            if(state is TeaInitial){
              context.read<TeaBloc>().add(LoadTea());
              return const CircularProgressIndicator(color: Colors.brown);
            }

            if(state is TeaLoaded){
              return ListView.builder(
                    itemCount: state.categories.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom:5.0),
                        child: ExpansionTile(
                          title: Text(state.categories[index].name),
                          children: [
                            ListView.builder(
                              itemCount: state.categories[index].teas.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, teaIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: ListTile(
                                    leading: Image.asset('lib/pictures/teas/DefaultTeaPicture.png'),
                                    title: Text(state.categories[index].teas[teaIndex].name),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/modifyTea', arguments: state.categories[index].teas[teaIndex]);
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
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

/*class CatAndTea extends StatelessWidget {
  final List<Category> listCategories;

  const CatAndTea({super.key, required this.listCategories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listCategories.length,
        itemBuilder: (context, catIndex) {
      final category = listCategories[catIndex];
      return Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                category.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/modifyCategory');
              },
            ),
            const Divider(),
            ListView.builder(
              itemCount: category.teas.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, teaIndex) {
                final tea = category.teas[teaIndex];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: ListTile(
                    leading: Image.asset('lib/pictures/teas/DefaultTeaPicture.png'),
                    title: Text(tea.name),
                    onTap: () {
                      Navigator.pushNamed(context, '/modifyTea');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
    );
  }
}*/
