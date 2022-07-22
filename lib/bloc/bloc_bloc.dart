import 'dart:convert';
import 'package:flutter_app/model/code_bar_model.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  List<CodeBarModel> codeBars = [];

  late SharedPreferences sharedPreferences;

  BlocBloc() : super(BlocInitial()) {
    on<GetDataEvent>(((event, emit) async {
      await getData();
      emit(DataLoaded(codeBarsToLoad: codeBars));
    }));
    on<AddDataEvent>((event, emit) async {
      await saveData(event.id, event.codeBarToAdd, event.dataToAdd);

      emit(DataLoaded(codeBarsToLoad: codeBars));
    });
    on<RemoveDataEvent>((event, emit) async {
      await removeData(event.codeBarToDelete);
      emit(DataLoaded(
        codeBarsToLoad: codeBars,
      ));
    });
  }

  Future<void> getData() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    List<String> mySavedList =
        sharedPreferences.getStringList("myListString") ?? [];

    mySavedList.forEach((element) {
      Map<String, dynamic> stringJson = jsonDecode(element);
      CodeBarModel user = CodeBarModel.fromJson(stringJson);
      codeBars.add(user);
    });
  }

  Future<void> saveData(
      String id, String scannedCode, String scannedDate) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    CodeBarModel codeBar =
        CodeBarModel(id: id, scannedCode: scannedCode, date: scannedDate);
    List<String> codeBarToSave = [];

    codeBars.add(codeBar);
    codeBarToSave.add(jsonEncode(codeBar));

    List<String> savedListOfCodeBars =
        (sharedPreferences.getStringList('myListString') ?? []) + codeBarToSave;
    sharedPreferences.setStringList("myListString", savedListOfCodeBars);
  }

  Future<void> removeData(String id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String> mySavedList =
        sharedPreferences.getStringList("myListString") ?? [];
    mySavedList.removeWhere((codeBarToDelete) => codeBarToDelete.contains(id));
    codeBars.removeWhere((codeBarToDelete) => codeBarToDelete.id == id);
    sharedPreferences.setStringList('myListString', mySavedList);
  }
}
