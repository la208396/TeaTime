import 'package:flutter_bloc/flutter_bloc.dart';

//EVENT
abstract class TeaEvent {}

class AddTea extends TeaEvent {
  // final String name;
  // final String description;
  // final String category;
  // final String image;
  // Ajouter sur Firebase, plustard en db local pour ne pas dépendre du wifi
}

class DeleteTea extends TeaEvent {
}

//STATE
class AddTeaState {
  final bool isEmpty;
  final String name;
  final String description;
  final String category;
  final String image;
  AddTeaState(this.isEmpty, {this.name = '', this.description = '', this.category = '', this.image = ''});
}

//BLOC
class AddTeaBloc extends Bloc<TeaEvent, AddTeaState> {
  AddTeaBloc() : super(AddTeaState(false)) {
    on<AddTea>((event, emit) => emit(AddTeaState(state.isEmpty == true)));
  }
}