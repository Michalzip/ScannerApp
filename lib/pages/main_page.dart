import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/bloc/bloc_bloc.dart';
import 'package:flutter_app/pages/scanner_page.dart';
import 'package:flutter_app/model/code_bar_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<BlocBloc, BlocState>(builder: (context, state) {
            if (state is BlocInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is DataLoaded) {
              List<CodeBarModel> data = state.codeBarsToLoad;
              return Flexible(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: data.isNotEmpty
                              ? ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(data[index].scannedCode),
                                      subtitle: Text(data[index].date),
                                      trailing: IconButton(
                                        iconSize: 20,
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        tooltip: 'delete barcode',
                                        onPressed: () {
                                          context.read<BlocBloc>().add(
                                              RemoveDataEvent(
                                                  codeBarToDelete:
                                                      data[index].id));
                                        },
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text('Empty List Of Scanned Code'),
                                ))));
            }

            return throw Exception('something bad hapend :/');
          }),
          Center(
            child: ElevatedButton(
                child: const Text('Take a scan of the barcode'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScannerPage()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
