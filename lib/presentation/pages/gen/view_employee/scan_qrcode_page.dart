// import 'package:flutter/material.dart';
// import 'package:gipms/core/routes/route_name.dart';
// import 'package:gipms/l10n/app_localizations.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class ScanQrCodePage extends StatefulWidget {
//   const ScanQrCodePage({super.key});

//   @override
//   State<ScanQrCodePage> createState() => _ScanQrCodeViewState();
// }

// class _ScanQrCodeViewState extends State<ScanQrCodePage>
//     with WidgetsBindingObserver {
//   late MobileScannerController _scannerController; // Make it late
//   bool _isScanning = true;

//   Future<bool> _onWillPop() async {
//     Navigator.of(context).pop();
//     return false;
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _scannerController = MobileScannerController(
//       // Initialize here
//       detectionSpeed: DetectionSpeed.noDuplicates,
//       returnImage: false,
//       torchEnabled: false,
//     );
//     _startScanner();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _stopScanner(); // Stop before disposing
//     _scannerController.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.resumed) {
//       _startScanner();
//     } else if (state == AppLifecycleState.paused) {
//       _stopScanner();
//     }
//   }

//   void _startScanner() {
//     if (_isScanning) {
//       try {
//         _scannerController.start();
//       } catch (e) {
//         // Handle the exception, e.g., show an error message
//         print("Error starting scanner: $e");
//         // Consider showing a dialog to the user:
//         if (mounted) {
//           showDialog(
//             context: context,
//             builder:
//                 (context) => AlertDialog(
//                   title: const Text("Scanner Error"),
//                   content: const Text(
//                     "Failed to start the camera. Please check camera permissions and try again.",
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text("OK"),
//                     ),
//                   ],
//                 ),
//           );
//         }
//       }
//     }
//   }

//   void _stopScanner() {
//     if (_isScanning) {
//       try {
//         _scannerController.stop();
//       } catch (e) {
//         print("Error stopping scanner: $e");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(AppLocalizations.of(context)!.qrscan),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   _isScanning = !_isScanning;
//                   if (_isScanning) {
//                     _startScanner();
//                   } else {
//                     _stopScanner();
//                   }
//                   _scannerController.toggleTorch();
//                 });
//               },
//               icon: Icon(_isScanning ? Icons.stop : Icons.play_arrow),
//             ),
//           ],
//         ),
//         body: MobileScanner(
//           controller: _scannerController,
//           onDetect: (result) {
//             if (result.barcodes.isNotEmpty) {
//               final scannedData =
//                   result.barcodes.first.rawValue ?? "No QR Code Found";
//               if (mounted) {
//                 _stopScanner();
//                 Navigator.pushNamed(
//                   context,
//                   RouteName.employeeview,
//                   arguments: {
//                     'parameterUrl': scannedData,
//                     'referralCode': null,
//                   },
//                 ).then((_) {
//                   _startScanner();
//                 });
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodePage extends StatefulWidget {
  const ScanQrCodePage({super.key});

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodeViewState();
}

class _ScanQrCodeViewState extends State<ScanQrCodePage> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: false,
    torchEnabled: false,
  );
  bool _isScanning = true; // Track scanning state

  @override
  void initState() {
    super.initState();
    // Start the scanner in initState
    _scannerController.start();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.qrscan),
        actions: [
          IconButton(
            onPressed: () {
              // Example of manually controlling the scanner.
              setState(() {
                if (_isScanning) {
                  _scannerController.stop();
                } else {
                  _scannerController.start();
                }
                _isScanning = !_isScanning;
              });
            },
            icon: Icon(_isScanning ? Icons.stop : Icons.play_arrow),
          ),
        ],
      ),
      body: MobileScanner(
        controller: _scannerController,
        onDetect: (result) {
          if (result.barcodes.isNotEmpty) {
            final scannedData =
                result.barcodes.first.rawValue ?? "No QR Code Found";
            if (mounted) {
              // Check if the widget is still in the tree.
              _scannerController.stop(); // Stop scanning
              Navigator.popAndPushNamed(
                context,
                RouteName.employeeview, // Use route name directly
                arguments: {'parameterUrl': scannedData, 'referralCode': null},
              );
            }
          }
        },
      ),
    );
  }
}
