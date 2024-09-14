import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_core/constant/core_colors.dart';

import '../Extension.dart';

class CustomPhoneNumberField extends StatefulWidget {
  final String placeholder;
  final Color borderColor;
  final Color? focusedBorderColor; // New property for focused color
  final Color textColor;
  final Color placeholderColor;
  final TextEditingController controller;
  final String flagIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;

  const CustomPhoneNumberField({
    super.key,
    required this.placeholder,
    required this.borderColor,
    required this.textColor,
    required this.placeholderColor,
    required this.controller,
    required this.flagIcon,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.focusedBorderColor, // Initialize new property
  });

  @override
  State<CustomPhoneNumberField> createState() => _CustomPhoneNumberFieldState();
}

class _CustomPhoneNumberFieldState extends State<CustomPhoneNumberField> {
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 10.0.scalablePixel),
                  SvgPicture.asset(
                    widget.flagIcon,
                    width: 18.0.scalablePixel,
                    height: 18.0.scalablePixel,
                  ),
                  SizedBox(width: 15.0.scalablePixel),
                  Text(
                    "+91",
                    style: TextStyle(
                      color: CoreColors.grey,
                      fontSize: context.textTheme.bodyLarge?.fontSize,
                    ),
                  ),
                  SizedBox(width: 5.0.scalablePixel),
                  SizedBox(
                    height: 20.scalablePixel,
                    child: VerticalDivider(
                      width: 20.scalablePixel,
                      thickness: 1,
                      color: CoreColors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(width: 5.0.scalablePixel),
              Expanded(
                child: TextField(
                  focusNode: _internalFocusNode,
                  controller: widget.controller,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: false),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) {
                    widget.onChanged?.call(value);
                  },
                  style: context.textTheme.justColor(widget.textColor),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: context.textTheme.modifiedTextTheme(
                        context.textTheme.bodyLarge, widget.placeholderColor),
                    border: InputBorder.none,
                  ),
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
