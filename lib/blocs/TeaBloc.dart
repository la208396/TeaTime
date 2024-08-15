import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatime/models/Tea_model.dart';
import 'package:teatime/models/Category_model.dart';
import '../models/Firestore_service.dart';


//STATE
abstract class TeaState extends Equatable {
  const TeaState();

  @override
  List<Object> get props => [];
}

class TeaInitial extends TeaState {}

class TeaLoading extends TeaState {}

class TeaLoaded extends TeaState {
  final List<Category> categories;
  TeaLoaded(this.categories);

  @override
  List<Object> get props => [categories];   //To be able to compare the state
}

class OperationSuccess extends TeaState {
  final String message;

  const OperationSuccess(this.message);
}

class Error extends TeaState {
  final String errorMessage;

  const Error(this.errorMessage);
}

//EVENT
abstract class TeaEvent extends Equatable{
  const TeaEvent();

  @override
  List<Object> get props => [];
}

class LoadCategoriesAndTeas extends TeaEvent {
}

class LoadCategories extends TeaEvent {
}

class AddTea extends TeaEvent {
  final String teaName;
  final String teaDescription;
  final String teaPersonalOpinion;
  final int teaQuoting;
  final Category currentCategory;

  const AddTea(this.teaName, this.teaDescription, this.teaPersonalOpinion, this.teaQuoting, this.currentCategory);

  @override
  List<Object> get props => [teaName, teaDescription, teaPersonalOpinion, teaQuoting, currentCategory];
}

class AddCategory extends TeaEvent {
  final String categoryName;

  const AddCategory(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}

class DeleteTea extends TeaEvent {
  final String tea;
  final Category category;

  const DeleteTea(this.tea, this.category);

  @override
  List<Object> get props => [tea, category];
}

class DeleteCategory extends TeaEvent {
  final Category category;

  const DeleteCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateTea extends TeaEvent {
  final Tea tea;
  final Category category;

  const UpdateTea(this.tea, this.category);

  @override
  List<Object> get props => [tea, category];
}

class UpdateCategory extends TeaEvent {
  final Category category;

  const UpdateCategory(this.category);

  @override
  List<Object> get props => [category];
}

//BLOC
class TeaBloc extends Bloc<TeaEvent, TeaState> {
  final FirestoreService firestoreService;

  TeaBloc(this.firestoreService) : super(TeaInitial()) {                                //Initial state when we start the app

    on<LoadCategoriesAndTeas>((event, emit) async {
      try {
        emit(TeaLoading());
        final categories = await firestoreService.getCategoriesAndTeas();
        emit(TeaLoaded(categories));
      } catch (e) {
        emit(Error('Failed to load categories and teas'));
      }
    });

    on<LoadCategories>((event, emit) async {
      try {
        emit(TeaLoading());
        final categories = await firestoreService.getCategories();
        emit(TeaLoaded(categories));
      } catch (e) {
        emit(Error('Failed to load categories'));
      }
    });

    on<AddCategory>((event, emit) async {
      try {
        emit(TeaLoading());
        await firestoreService.addCategory(event.categoryName);
        emit(OperationSuccess('Category added successfully.'));
        final categories = await firestoreService.getCategoriesAndTeas();
        emit(TeaLoaded(categories));
      } catch (e) {
        emit(Error('Failed to add todo.'));
      }
    });

    on<AddTea>((event, emit) async {
      try {
        emit(TeaLoading());
        await firestoreService.addTea(event.teaName, event.teaDescription, event.teaPersonalOpinion, event.teaQuoting, event.currentCategory);
        emit(OperationSuccess('Tea added successfully.'));
        final categories = await firestoreService.getCategoriesAndTeas();
        emit(TeaLoaded(categories));
      } catch (e) {
        emit(Error('Failed to add todo.'));
      }
    });

    on<DeleteCategory>((event, emit) async {
      try {
        emit(TeaLoading());
        await firestoreService.deleteCategory(event.category);
        emit(OperationSuccess('Category deleted successfully.'));
        final categories = await firestoreService.getCategoriesAndTeas();
        emit(TeaLoaded(categories));
      } catch (e) {
        emit(Error('Failed to delete todo.'));
      }
    });

    on<DeleteTea>((event, emit) async {
      try {
        emit(TeaLoading());
        await firestoreService.deleteTea(event.tea, event.category);
        emit(OperationSuccess('Tea deleted successfully.'));
        final categories = await firestoreService.getCategoriesAndTeas();
        emit(TeaLoaded(categories));
      } catch (e) {
        emit(Error('Failed to delete todo.'));
      }
    });

    on<UpdateTea>((event, emit) async {
      try {
        emit(TeaLoading());
        await firestoreService.updateTea(event.tea, event.category);
        emit(OperationSuccess('Tea updated successfully.'));
        final categories = await firestoreService.getCategoriesAndTeas();
        emit(TeaLoaded(categories));
      } catch (e) {
        emit(Error('Failed to update todo.'));
      }
    });

  }
}