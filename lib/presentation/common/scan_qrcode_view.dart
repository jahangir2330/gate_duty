import 'package:auth/presentation/gen/pages/view_employee.dart';
import 'package:flutter/material.dart';
//import 'package:jwt_auth_flutter/routes/route_name.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeView extends StatefulWidget {
  const ScanQrCodeView({super.key});

  @override
  State<ScanQrCodeView> createState() => _ScanQrCodeViewState();
}

class _ScanQrCodeViewState extends State<ScanQrCodeView> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: false,
    torchEnabled: false,
  );

  @override
  void dispose() {
    _scannerController
        .dispose(); // Properly dispose controller when leaving the screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/home");
            },
            icon: const Icon(Icons.qr_code),
          ),
        ],
      ),
      body: MobileScanner(
        controller: _scannerController, // Use class-level controller
        onDetect: (result) {
          final scannedData =
              result.barcodes.first.rawValue ?? "No QR Code Found";

          _scannerController.stop(); // Stop scanner before navigating
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewEmployeePage(
                parameterUrl: scannedData,
                referralCode: 'SOME_REFERRAL_CODE',
              ),
            ),
          );
        },
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // final viewModel = Provider.of<ScanQrCodeViewModel>(context, listen: false);

  return Scaffold(
    appBar: AppBar(
      title: const Text('Scan QR Code'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, "/home");
          },
          icon: const Icon(Icons.qr_code),
        ),
      ],
    ),
    body: MobileScanner(
      controller: MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        returnImage: false,
        torchEnabled: false,
      ),
      onDetect: (result) {
        final scannedData =
            result.barcodes.first.rawValue ?? "No QR Code Found";
        // Navigate to EmployeeDetailView, passing scannedData as an argument
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewEmployeePage(
              parameterUrl: scannedData,
              referralCode: 'SOME_REFERRAL_CODE',
            ),
          ),
        );
      },
    ),
  );
}
