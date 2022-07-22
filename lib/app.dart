import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_page.dart';
import 'package:flutter_app/bloc/bloc_bloc.dart';
import 'package:flutter_app/cubit/camera_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BlocBloc>(
            create: (BuildContext context) => BlocBloc()..add(GetDataEvent()),
          ),
          BlocProvider<CameraCubit>(
            create: (BuildContext context) => CameraCubit(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainPage(),
        ));
  }
}
