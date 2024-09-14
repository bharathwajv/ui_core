import 'package:flutter/material.dart';
import 'package:ui_core/constant/core_colors.dart';

import '../Extension.dart';
import '../animations/Loader.dart';

class CustomTextButton extends StatefulWidget {
  final Widget buttonText;
  final Future<void> Function() onClick;
  final Color color;
  final IconData? icon;
  final bool isOutlined; // New parameter
  final double? minWidth; // New parameter
  final bool tintedBackground;
  final bool disabled; // New parameter
  final bool isIconTrailing; // New parameter
  final bool showSpinner; // New parameter

  const CustomTextButton({
    super.key,
    required this.buttonText,
    required this.onClick,
    required this.color,
    this.icon,
    this.isIconTrailing = false,
    this.isOutlined = false, // Default value is false
    this.tintedBackground = false,
    this.minWidth, // Optional minimum width
    this.disabled = false, // Default value is false
    this.showSpinner = true, // Default value is false
  });

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null && !widget.isIconTrailing) ...[
          Icon(widget.icon,
              color: widget.isOutlined || widget.disabled
                  ? context.colorScheme.primary
                  : context.colorScheme.onInverseSurface),
          SizedBox(width: 2.width),
        ],
        widget.buttonText,
        if (widget.icon != null && widget.isIconTrailing) ...[
          Icon(widget.icon,
              color: widget.isOutlined || widget.disabled
                  ? context.colorScheme.primary
                  : context.colorScheme.onInverseSurface),
          SizedBox(width: 2.width),
        ],
      ],
    );

    return GestureDetector(
      onTapDown: (_) {
        if (!widget.disabled) _animationController.forward();
      },
      onTapUp: (_) {
        if (!widget.disabled) _animationController.reverse();
      },
      onTapCancel: () {
        if (!widget.disabled) _animationController.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: TextButton(
          style: TextButton.styleFrom(
            elevation: widget.tintedBackground
                ? 4.scalablePixel
                : 6.scalablePixel, // Defines Elevation
            shadowColor: context.colorScheme.primary, // Defines shadowColor
            splashFactory: NoSplash.splashFactory,
            foregroundColor: widget.isOutlined
                ? context.colorScheme.onSurface.withOpacity(0.5)
                : widget.disabled
                    ? CoreColors.grey
                    : context.colorScheme.onInverseSurface,
            minimumSize: Size(widget.minWidth ?? 6.width, 6.height),
            padding: const EdgeInsets.symmetric(),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              side: widget.isOutlined && !widget.disabled
                  ? BorderSide(color: widget.color)
                  : BorderSide.none,
            ),
            backgroundColor: widget.isOutlined
                ? widget.tintedBackground
                    ? context.colorScheme.surfaceContainerHighest
                    : Colors.transparent
                : widget.disabled
                    ? CoreColors.grey
                    : widget.color,
            textStyle: context.textTheme.bodyLarge,
          ),
          onPressed: widget.disabled || _isLoading ? null : _onButtonPressed,
          child: widget.showSpinner && _isLoading
              ? SizedBox(
                  child: AppLoadingIndicator(
                    width: 20.scalablePixel,
                    height: 20.scalablePixel,
                    strokeWidth: 3,
                    color: widget.isOutlined || widget.disabled
                        ? context.colorScheme.onSurface.withOpacity(0.5)
                        : context.colorScheme.onInverseSurface,
                  ),
                )
              : buttonContent,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
  }

  Future<void> _onButtonPressed() async {
    setState(() {
      _isLoading = true;
    });

    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 100), () {
      _animationController.reverse();
    });

    await widget.onClick();

    setState(() {
      _isLoading = false;
    });
  }
}
