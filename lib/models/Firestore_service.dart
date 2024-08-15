import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teatime/models/Category_model.dart';

import 'Tea_model.dart';

class FirestoreService {

  final _categoriesCollection = FirebaseFirestore.instance.collection('Categories');

  Future<List<Category>> getCategoriesAndTeas() async {
    try {
      final querySnapshot = await _categoriesCollection.get();
      print("Successfully completed");

      List<Category> categories = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');

        // Await the teas collection fetch
        final teasSnapshot = await _categoriesCollection
            .doc(docSnapshot.id)
            .collection('Teas')
            .get();

        var teas = <Tea>[];

        for (var element in teasSnapshot.docs) {
          print('${element.id} => ${element.data()}');
          var tea = Tea.fromFirestore(element);
          teas.add(tea);
        }
        Category category = Category.fromFirestore(docSnapshot, teas);
        categories.add(category);
      }

      return categories;
    } catch (e) {
      print("Error completing: $e");
      rethrow;
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final querySnapshot = await _categoriesCollection.get();
      print("Successfully completed");

      List<Category> categories = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');

        Category category = Category.fromFirestore(docSnapshot, []);
        categories.add(category);
      }

      return categories;
    } catch (e) {
      print("Error completing: $e");
      rethrow;
    }
  }

  Future<void> addCategory(String categoryName) async {

    try {
      DocumentReference categoryDoc = _categoriesCollection.doc(categoryName);    //Vérifier si le doc existe déjà

      await categoryDoc.set({   //Ajouter le doc si il n'existe pas
        'name': categoryName,
      });

    } catch (e) {
      print("Document already exists: $e");
      rethrow;
    }
  }

  Future<void> updateCategory(Category category) {
    return _categoriesCollection.doc(category.name).update({
      'name': category.name,
    });
  }

  Future<void> deleteCategory(Category categoryName) async{
    try {
      CollectionReference categoryCollection = _categoriesCollection.doc(categoryName.name).collection('Teas');
      QuerySnapshot querySnapshot = await categoryCollection.get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      await _categoriesCollection.doc(categoryName.name).delete();

      print("Category and its sub-collection deleted successfully");
    } catch (e) {
      print("Error deleting collection: $e");
      rethrow;
    }
  }

  Future<void> deleteTea(String teaName, Category categoryName) async{
    try {

      CollectionReference teasCollection = _categoriesCollection.doc(categoryName.name).collection('Teas');
      QuerySnapshot querySnapshot = await teasCollection.where('name', isEqualTo: teaName).get();   //récupère l'id grace au champ name

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }
      } else {
        print("No document found with name $teaName");
      }
    } catch (e) {
      print("Error deleting document: $e");
      rethrow;
    }
  }

  Future<void> addTea(String teaName, String description, String personalOpinion,int quoting, Category categoryName) async {
    try {
      DocumentReference categoryDoc = _categoriesCollection.doc(categoryName.name);    //Vérifier si le doc existe déjà
      CollectionReference teasDoc = _categoriesCollection.doc(categoryName.name).collection('Teas');

      if(teasDoc.doc(teaName).get() != null){
        await teasDoc.add({
          'name': teaName,
          'description': description,
          'personalOpinion': personalOpinion,
          'quoting': quoting,
        });
      }else{
        await categoryDoc.collection('Teas').doc().set({
          'name': teaName,
          'description': description,
          'personalOpinion': personalOpinion,
          'quoting': quoting,
        });
      }
      print("Tea added");
    } catch (e) {
      print("Document already exists: $e");
      rethrow;
    }
  }

Future<void> updateTea(Tea tea, Category category) async{
    try {
      CollectionReference teasCollection = _categoriesCollection.doc(category.name).collection('Teas');
      QuerySnapshot querySnapshot = await teasCollection.where('name', isEqualTo: tea.name).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await doc.reference.update({
            'name': tea.name,
            'description': tea.description,
            'personalOpinion': tea.personalOpinion,
            'quoting': tea.quoting,
          });
        }
        print ("Tea updated");
      } else {
        print("No document found with name ${tea.name}");
      }
    } catch (e) {
      print("Error updating document: $e");
      rethrow;
    }
  }
}