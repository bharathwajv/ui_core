import '../Extension.dart';
import '../popups/CustomSnackbar.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final BuildContext context;
  final bool enabled;
  final VoidCallback onPressed;
  final IconData icon;
  final bool isCircular;
  final String? validationMessage;

  const CustomIconButton({
    super.key,
    required this.context,
    required this.enabled,
    required this.onPressed,
    required this.icon,
    required this.isCircular,
    this.validationMessage,
  });

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: widget.enabled
                ? context.colorScheme.primary
                : context.colorScheme.outline,
            borderRadius: BorderRadius.circular(
                widget.isCircular ? 30.scalablePixel : 12.0.scalablePixel),
          ),
          child: IconButton(
            iconSize: 25.scalablePixel,
            onPressed: () async {
              if (widget.enabled) {
                _animationController.forward();
                //refactor
                //just to simulate button click animation
                await Future.delayed(const Duration(milliseconds: 100), () {
                  _animationController.reverse();
                });
                widget.onPressed();
              } else if (widget.validationMessage?.isNotEmpty ?? false) {
                CustomSnackbar.show(
                    context: context, message: widget.validationMessage ?? "");
              }
            },
            icon: Icon(widget.icon, color: widget.context.colorScheme.surface),
          ),
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
}
