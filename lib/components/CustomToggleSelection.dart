import 'Extension.dart';
import 'package:flutter/material.dart';

class CustomToggleSelection extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelected;
  final double height;
  final double borderRadius;
  final int defaultSelectedIndex; // Added parameter

  const CustomToggleSelection({
    super.key,
    required this.options,
    required this.onSelected,
    this.height = 40,
    this.borderRadius = 20,
    this.defaultSelectedIndex = 0, // Default value
  });

  @override
  _CustomToggleSelectionState createState() => _CustomToggleSelectionState();
}

class _CustomToggleSelectionState extends State<CustomToggleSelection> {
  late int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Make it scrollable horizontally
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.options.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onSelected(widget.options[index]);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16.scalablePixel),
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? context.colorScheme.primary
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius.scalablePixel),
                ),
                child: Text(
                  widget.options[index],
                  style: context.textTheme.modifiedTextTheme(
                    context.textTheme.labelLarge,
                    _selectedIndex == index
                        ? context.colorScheme.onPrimary
                        : context.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
  }
}
