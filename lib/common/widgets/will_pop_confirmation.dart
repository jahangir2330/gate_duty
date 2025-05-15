import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gipms/l10n/app_localizations.dart'; // Import your route names

class WillPopConfirmation extends StatelessWidget {
  final Widget child;

  const WillPopConfirmation({
    super.key,
    required this.child,
  });

  Future<void> _onPopInvoked(bool didPop, BuildContext context) async {
    // Receive context
    if (didPop) {
      return; // Do nothing, let the system handle the pop (which we prevent with canPop: false initially)
    }
    final localizations = AppLocalizations.of(context)!;
    final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(localizations.confirmExit),
            content: Text(localizations.exitConfirmation),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(localizations.no),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(localizations.yes),
              ),
            ],
          ),
        ) ??
        false;
    if (shouldPop) {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // We are handling the pop ourselves
      onPopInvoked: (didPop) =>
          _onPopInvoked(didPop, context), // Pass the context
      child: child,
    );
  }
}
