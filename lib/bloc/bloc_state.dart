part of 'bloc_bloc.dart';

abstract class BlocState {}

class BlocInitial extends BlocState {}

class DataLoaded extends BlocState {
  DataLoaded({required this.listItems});

  List<dynamic> listItems = [];
}
