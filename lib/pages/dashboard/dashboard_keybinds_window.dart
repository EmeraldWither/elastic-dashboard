import 'package:flutter/material.dart';

import 'package:elastic_dashboard/pages/dashboard_page.dart';
import 'package:elastic_dashboard/services/hotkey_manager.dart';
import 'package:elastic_dashboard/widgets/keybinds_dialog.dart';

mixin DashboardPageKeybinds on DashboardPageViewModel {
  @override
  void displayKeybindsHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => KeybindsDialog(
        hotkeys: hotKeyManager.registeredHotKeyList,
      ),
    );
  }
}
