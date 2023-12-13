import 'package:flutter_bloc/flutter_bloc.dart';

//EVENT
abstract class ModifyCategoryEvent {}

class ModifyCategory extends ModifyCategoryEvent {    //Ici ou dans le bloc TeaBloc ?

}

//STATE
class ModifyCategoryState {
  final bool isEmpty;
  final String name;
  final String description;
  final String category;
  final String image;
  ModifyCategoryState(this.isEmpty, {this.name = '', this.description = '', this.category = '', this.image = ''});
}

//BLOC
class ModifyCategoryBloc extends Bloc<ModifyCategoryEvent, ModifyCategoryState> {
  ModifyCategoryBloc() : super(ModifyCategoryState(false)) {
    on<ModifyCategory>((event, emit) => emit(ModifyCategoryState(state.isEmpty == true)));
  }
}