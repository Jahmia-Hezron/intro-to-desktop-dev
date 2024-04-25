import 'package:desktop_practice/src/widgets/widget_export.dart';
import 'package:flutter/services.dart';

import '../../utils/utils_export.dart';
import 'package:flutter/material.dart';

class TextArea extends StatefulWidget {
  final int? maxLines;
  final int maxLength;
  final String hintText;
  final TextEditingController controller;

  const TextArea(
      {super.key,
      this.maxLines,
      required this.maxLength,
      required this.hintText,
      required this.controller});

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyToClipboard(context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    SnackBarUtils.showSnackbar(context, Icons.copy_all_rounded, 'Copied Text');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        focusNode: _focusNode,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: widget.controller,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        keyboardType: TextInputType.multiline,
        cursorColor: AppTheme.tertiary,
        style: TextStyle(color: AppTheme.tertiary, fontSize: 16),
        decoration: InputDecoration(
            hintText: widget.hintText,
            suffix: ActionButton(
              icon: Icons.copy_all_rounded,
              iconColor: AppTheme.tertiary,
              splashColor: AppTheme.secondary,
              disabledColor: AppTheme.secondary,
              onPressed: widget.controller.text.isNotEmpty
                  ? () => copyToClipboard(context, widget.controller.text)
                  : null,
            ),
            hintStyle: TextStyle(
                color: AppTheme.secondary, fontStyle: FontStyle.italic),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.tertiary),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.secondary),
            ),
            counterStyle: TextStyle(color: AppTheme.tertiary)),
      ),
    );
  }
}
