import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class CameraCubit extends Cubit<bool> {
  CameraCubit() : super(true);
  bool cameraOff = false;
  bool cameraOn = true;

  void changeValue(bool booleanToChange) {
    booleanToChange = !state;
    emit(booleanToChange);
  }
}
