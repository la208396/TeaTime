import 'package:flutter_bloc/flutter_bloc.dart';

//EVENT
abstract class ModifyTeaEvent {}

class ModifyTea extends ModifyTeaEvent {

}

//STATE
class ModifyTeaState {
  final bool isEmpty;
  final String name;
  final String description;
  final String category;
  final String image;
  ModifyTeaState(this.isEmpty, {this.name = '', this.description = '', this.category = '', this.image = ''});
}

//BLOC
class ModifyTeaBloc extends Bloc<ModifyTeaEvent, ModifyTeaState> {
  ModifyTeaBloc() : super(ModifyTeaState(false)) {
    on<ModifyTea>((event, emit) => emit(ModifyTeaState(state.isEmpty == true)));
  }
}