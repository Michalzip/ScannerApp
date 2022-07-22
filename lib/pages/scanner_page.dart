import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/cubit/camera_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:uuid/uuid.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? codeBar;
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return Scaffold(
      body: BlocBuilder<CameraCubit, bool>(builder: (context, state) {
        return state
            ? Center(
                child: SizedBox(
                height: 1000,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (scannedCode) {
                    context
                        .read<CameraCubit>()
                        .changeValue(CameraCubit().cameraOff);

                    codeBar = scannedCode;
                  },
                ),
              ))
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          "Your Scanned Code:",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Center(
                        child: Text(codeBar ?? "invalid scanned code"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context
                                  .read<CameraCubit>()
                                  .changeValue(CameraCubit().cameraOn);
                            },
                            child: const Text('Remove'),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.pop(context);

                              context.read<BlocBloc>().add(AddDataEvent(
                                  id: const Uuid().v4(),
                                  codeBarToAdd:
                                      codeBar ?? 'INVALID SCANNED CODE',
                                  dataToAdd: date));

                              context
                                  .read<CameraCubit>()
                                  .changeValue(CameraCubit().cameraOn);
                            },
                            child: const Text('Add'),
                          )
                        ],
                      )
                    ]),
              );
      }),
    );
  }
}
