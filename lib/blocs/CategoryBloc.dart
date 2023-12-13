import 'package:flutter_bloc/flutter_bloc.dart';

//EVENT
abstract class CategoryEvent {}

class AddCategory extends CategoryEvent {}   //A quoi sert t-il ?

//STATE
class AddCategoryState {
  final bool isEmpty;
  final String name;
  AddCategoryState(this.isEmpty, {this.name = ''});
}

//BLOC
class AddCategoryBloc extends Bloc<CategoryEvent, AddCategoryState> {
  AddCategoryBloc() : super(AddCategoryState(false)) {
    on<AddCategory>((event, emit) => emit(AddCategoryState(state.isEmpty == true)));  //Name ?
  }
}