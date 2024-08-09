import 'package:flutter_bloc/flutter_bloc.dart';

//EVENT
abstract class CategoryEvent {}

class AddCategory extends CategoryEvent {}

//STATE
class CategoryState {
  final bool isEmpty;
  final String name;
  CategoryState(this.isEmpty, {this.name = ''});
}

//BLOC
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState(false)) {
    on<AddCategory>((event, emit) => emit(CategoryState(state.isEmpty == true)));  //Name ?
  }
}