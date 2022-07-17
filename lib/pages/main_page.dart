import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/bloc/bloc_bloc.dart';
import 'package:flutter_app/pages/scanner_page.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

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
              return Flexible(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: state.listItems.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.listItems.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title:
                                    Text(state.listItems[index]["scannedCode"]),
                                subtitle: Text(state.listItems[index]["date"]),
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
                                              codeBarstoDelete:
                                                  state.listItems[index]['id']),
                                        );
                                  },
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text('EMPTY LIST'),
                          )),
              ));
            }

            return throw Exception('something bad hapend :/');
          }),
          Center(
            child: ElevatedButton(
                child: const Text('Take a scan of the barcode'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScannerPage()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
