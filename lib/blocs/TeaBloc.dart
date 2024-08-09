import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatime/models/Tea_model.dart';
import 'package:teatime/models/Category_model.dart';


//STATE
abstract class TeaState extends Equatable {
  const TeaState();

  @override
  List<Object> get props => [];
}

class TeaInitial extends TeaState {}

class TeaLoaded extends TeaState {
  final List<Category> categories;
  const TeaLoaded({required this.categories});

  @override
  List<Object> get props => [categories];   //To be able to compare the state
}

//EVENT
abstract class TeaEvent extends Equatable{
  const TeaEvent();

  @override
  List<Object> get props => [];
}

class AddTea extends TeaEvent {
  final Tea tea;

  const AddTea(this.tea);

  @override
  List<Object> get props => [tea];
}

class DeleteTea extends TeaEvent {
  final Tea tea;

  const DeleteTea(this.tea);

  @override
  List<Object> get props => [tea];
}

class LoadTea extends TeaEvent {
}

//BLOC
class TeaBloc extends Bloc<TeaEvent, TeaState> {

  TeaBloc() : super(TeaInitial()) {                                //Initial state when we start the app
    on<LoadTea>((event, emit) async {                              //Then the LoadTea event is started
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(TeaLoaded(categories: Category.categories));                        //Then the state is changed to TeaLoaded
    });

    on<AddTea>((event, emit) {
      if(state is TeaLoaded) {
        final state = this.state as TeaLoaded;
        emit(TeaLoaded(categories: List<Category>.from(state.categories))   //Add the tea to the list of teas. Create a new state and add Tea in the screen
        );
      }
    });

    on<DeleteTea>((event, emit) {
      if(state is TeaLoaded) {
        final state = this.state as TeaLoaded;
        emit(
          TeaLoaded(categories: List<Category>.from(state.categories))   //Remove the tea from the list of teas. Create a new state and remove Tea in the screen
        );
      }
    });
  }
}