import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/observer_bloc/basic_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(App()),
    blocObserver: Observer(),
  );
}
