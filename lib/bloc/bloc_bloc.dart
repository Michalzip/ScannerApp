import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<dynamic> listOfitem = [];
  List<dynamic> itemToRemove = [];

  BlocBloc() : super(BlocInitial()) {
    on<GetDataEvent>(((event, emit) async {
      await getData();
      emit(DataLoaded(listItems: listOfitem));
    }));
    on<AddDataEvent>((event, emit) async {
      await addData(event.codeBarToAdd, event.dataToAdd);

      emit(DataLoaded(listItems: listOfitem));
    });
    on<RemoveDataEvent>((event, emit) async {
      await removeData(event.codeBarstoDelete);
      emit(DataLoaded(
        listItems: listOfitem,
      ));
    });
  }

  Future<void> getData() async {
    final SharedPreferences prefs = await _prefs;

    var codeData = prefs.getStringList("list") ?? [];

    try {
      codeData.forEach((element) {
        return listOfitem.add(jsonDecode(element));
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addData(String dataToAdd, String dateToAdd) async {
    final SharedPreferences prefs = await _prefs;
    final Map<String, dynamic> item = {};

    var codeData = prefs.getStringList("list") ?? [];
    item['id'] = const Uuid().v4();
    item['scannedCode'] = dataToAdd;
    item['date'] = dateToAdd;
    codeData.add(jsonEncode(item));

    listOfitem.add(item);
    itemToRemove.add(item);

    prefs.setStringList("list", codeData);
  }

  Future<void> removeData(String id) async {
    final SharedPreferences prefs = await _prefs;
    itemToRemove.forEach((element) {
      listOfitem.removeWhere((element) => element['id'] == id);
    });
    var codeData = prefs.getStringList("list") ?? [];

    codeData.removeWhere((element) => element.contains(id));

    prefs.setStringList("list", codeData);
  }
}
