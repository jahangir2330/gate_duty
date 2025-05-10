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
                arguments: {
                  'parameterUrl': scannedData,
                  'referralCode': 'SOME_REFERRAL_CODE',
                },
              );
            }
          }
        },
      ),
    );
  }
}
