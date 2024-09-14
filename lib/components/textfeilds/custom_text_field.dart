import 'package:flutter/material.dart';

import '../Extension.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
  final Color borderColor;
  final Color? focusedBorderColor; // New property for focused color
  final Color textColor;
  final Color placeholderColor;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>?
      onSubmitted; // New property for onSubmitted callback
  final Widget? icon;
  final VoidCallback? onTap;
  final FocusNode? focusNode; // New property for focus node

  const CustomTextField({
    super.key,
    required this.placeholder,
    required this.borderColor,
    required this.textColor,
    required this.placeholderColor,
    this.controller,
    this.onChanged,
    this.onSubmitted, // Initialize new property
    this.icon,
    this.onTap,
    this.focusNode, // Initialize new property
    this.focusedBorderColor, // Initialize new property
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(13.scalablePixel),
          border: Border.all(
            color: _isFocused
                ? widget.focusedBorderColor ?? context.colorScheme.primary
                : widget.borderColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.scalablePixel),
          child: Row(
            children: [
              if (widget.icon != null)
                Padding(
                  padding: EdgeInsets.only(
                      right: 10.0.scalablePixel, left: 10.0.scalablePixel),
                  child: widget.icon,
                ),
              Expanded(
                child: Stack(
                  children: [
                    TextField(
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      onSubmitted:
                          widget.onSubmitted, // Set the onSubmitted callback
                      style: context.textTheme.justColor(widget.textColor),
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        hintStyle: context.textTheme.modifiedTextTheme(
                          context.textTheme.bodyLarge,
                          widget.placeholderColor,
                        ),
                        border: InputBorder.none,
                      ),
                      focusNode: _internalFocusNode,
                    ),
                    if (widget.onTap != null)
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.onTap,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }
}
