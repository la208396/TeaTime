import 'package:flutter_bloc/flutter_bloc.dart';


//STATE
class CategoryState {
  final bool isEmpty;
  final String name;
  CategoryState(this.isEmpty, {this.name = ''});
}


//EVENT
abstract class CategoryEvent {}

class AddCategory extends CategoryEvent {}


//BLOC
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState(false)) {
    on<AddCategory>((event, emit) => emit(CategoryState(state.isEmpty == true)));  //Name ?
  }
}