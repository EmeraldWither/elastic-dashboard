import 'package:flutter/material.dart';

import 'package:elastic_dashboard/pages/dashboard/dashboard_keybinds_window.dart';

class KeybindsDialog extends StatefulWidget {
  final List<DisplayableKeybindCategory> keybindCategories;

  const KeybindsDialog({super.key, required this.keybindCategories});

  @override
  State<KeybindsDialog> createState() => _KeybindsDialogState();
}

class _KeybindsDialogState extends State<KeybindsDialog> {
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Column(
      children: [Text('Keyboard Shortcuts'), Divider()],
    ),
    content: SizedBox(
      width: 350,
      child: Wrap(
        direction: Axis.horizontal,
        children: _buildFullKeyBindList(widget.keybindCategories),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Close'),
      ),
    ],
  );

  List<Widget> _buildFullKeyBindList(
    List<DisplayableKeybindCategory> keybinds,
  ) {
    /// Builds the entire page for the keybinds based on all the provided caterogies which contains keybinds
    List<Widget> keybindWidgets = [];
    for (DisplayableKeybindCategory keybindCategory in keybinds) {
      keybindWidgets.add(_buildKeyBindCategory(keybindCategory));
    }
    return [
      ...keybindWidgets,
    ];
  }

  Widget _buildKeyBindCategory(DisplayableKeybindCategory category) {
    /// Builds a list of keybinds for a category with the name of the category
    List<Widget> keybindWidgets = [];
    for (int i = 0; i < category.keybinds.length; i++) {
      keybindWidgets.add(
        _buildFullKeybindWidget(
          category.keybinds[i].keys,
          category.keybinds[i].description,
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Wrap(
        direction: Axis.vertical,
        spacing: 4,
        children: [
          Text(category.name, style: Theme.of(context).textTheme.titleMedium),
          ...keybindWidgets,
        ],
      ),
    );
  }

  Widget _buildFullKeybindWidget(List<String> keys, String description) {
    /// Builds a single keybind entry, showing the keys and the description
    List<Widget> keybindChips = [];
    for (int i = 0; i < keys.length; i++) {
      keybindChips.add(_buildSingleKeybindChip(keys[i]));
      if (i < keys.length - 1) {
        //the "+" between keys
        keybindChips.add(
          Row(
            children: [
              const SizedBox(width: 5),
              Text('+'),
              const SizedBox(width: 5),
            ],
          ),
        );
      }
    }
    //description of the key on the right side
    keybindChips.add(
      Row(
        children: [
          const SizedBox(width: 5),
          Text('-'),
          const SizedBox(width: 5),
          Text(
            description,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
    return Row(mainAxisSize: MainAxisSize.min, children: keybindChips);
  }

  Widget _buildSingleKeybindChip(String text) => Chip(
    label: Text(text),
    padding: EdgeInsets.all(2),
    labelStyle: Theme.of(context).textTheme.bodySmall,
    // backgroundColor: Theme.of(context).cardColor,
  );
}
