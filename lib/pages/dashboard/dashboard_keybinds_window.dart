import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:elastic_dashboard/pages/dashboard_page.dart';
import 'package:elastic_dashboard/services/hotkey_manager.dart';
import 'package:elastic_dashboard/widgets/keybinds_dialog.dart';

mixin DashboardPageKeybinds on DashboardPageViewModel {
  @override
  void displayKeybindsHelpDialog(BuildContext context) {
    List<DisplayableKeybindCategory> keybindCategories =
        _convertKeybindsToCategories();
    showDialog(
      context: context,
      builder: (context) => KeybindsDialog(
        keybindCategories: keybindCategories,
      ),
    );
  }

  List<DisplayableKeybindCategory> _convertKeybindsToCategories() {
    List<DisplayableKeybindCategory> convertedKeybinds = [];
    HashMap<String, List<DisplayableHotkey>> keybindMap = HashMap();
    for (var key in hotKeyManager.registeredHotKeyList) {
      if (!key.display) continue;
      DisplayableHotkey displayableHotkey = _fromHotkey(key);
      if (!keybindMap.containsKey(key.category)) {
        keybindMap[key.category] = [displayableHotkey];
      } else {
        keybindMap[key.category]!.add(displayableHotkey);
      }
    }
    for (final entry in keybindMap.entries) {
      final key = entry.key;
      final value = entry.value;
      convertedKeybinds.add(DisplayableKeybindCategory(key, value));
    }
    return convertedKeybinds;
  }

  DisplayableHotkey _fromHotkey(HotKey key) {
    List<String> keys = [];
    if (key.modifiers != null) {
      for (KeyModifier modifier in key.modifiers!) {
        keys.add(modifier.displayName);
      }
    }
    keys.add(key.logicalKey.keyLabel);
    return DisplayableHotkey(keys, key.description);
  }
}

class DisplayableKeybindCategory {
  final String name;
  final List<DisplayableHotkey> keybinds;

  DisplayableKeybindCategory(this.name, this.keybinds);
}

class DisplayableHotkey {
  final List<String> keys;
  final String description;

  DisplayableHotkey(this.keys, this.description);
}
