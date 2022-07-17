part of 'bloc_bloc.dart';

abstract class BlocEvent {}

class GetDataEvent extends BlocEvent {}

class AddDataEvent extends BlocEvent {
  AddDataEvent({required this.codeBarToAdd, required this.dataToAdd});

  final String codeBarToAdd;
  final String dataToAdd;
}

class RemoveDataEvent extends BlocEvent {
  RemoveDataEvent({
    required this.codeBarstoDelete,
  });

  final String codeBarstoDelete;
}
