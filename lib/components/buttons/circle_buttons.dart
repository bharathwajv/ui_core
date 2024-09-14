import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_core/constant/core_colors.dart';

import '../Extension.dart';

/// The core button that drives all other buttons.
class AppBtn extends StatelessWidget {
  // interaction:
  final VoidCallback? onPressed;

  late final String semanticLabel;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final void Function(bool hasFocus)? onFocusChanged;
  // content:
  late final Widget? child;

  late final WidgetBuilder? _builder;
  // layout:
  final EdgeInsets? padding;

  final bool expand;
  final bool circular;
  final Size? minimumSize;
  // style:
  final bool isSecondary;

  final BorderSide? border;
  final Color? bgColor;
  final bool pressEffect;
  // ignore: prefer_const_constructors_in_immutables
  AppBtn({
    super.key,
    required this.onPressed,
    required this.semanticLabel,
    this.enableFeedback = true,
    this.pressEffect = true,
    this.child,
    this.padding,
    this.expand = false,
    this.isSecondary = false,
    this.circular = false,
    this.minimumSize,
    this.bgColor,
    this.border,
    this.focusNode,
    this.onFocusChanged,
  }) : _builder = null;

  @override
  Widget build(BuildContext context) {
    Color defaultColor =
        isSecondary ? context.colorScheme.surface : CoreColors.grey;
    Color textColor = isSecondary
        ? context.colorScheme.onSurface
        : context.colorScheme.surface;
    BorderSide side = border ?? BorderSide.none;

    Widget content =
        _builder?.call(context) ?? child ?? const SizedBox.shrink();
    if (expand) content = Center(child: content);

    OutlinedBorder shape = circular
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(
            side: side, borderRadius: BorderRadius.circular(8.scalablePixel));

    ButtonStyle style = ButtonStyle(
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize ?? Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashFactory: NoSplash.splashFactory,
      backgroundColor:
          ButtonStyleButton.allOrNull<Color>(bgColor ?? defaultColor),
      overlayColor: ButtonStyleButton.allOrNull<Color>(
          Colors.transparent), // disable default press effect
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(
          padding ?? EdgeInsets.all(8.scalablePixel)),

      enableFeedback: enableFeedback,
    );

    Widget button = _CustomFocusBuilder(
      focusNode: focusNode,
      onFocusChanged: onFocusChanged,
      builder: (context, focus) => Stack(
        children: [
          Opacity(
            opacity: onPressed == null ? 0.5 : 1.0,
            child: TextButton(
              onPressed: onPressed,
              style: style,
              focusNode: focus,
              child: DefaultTextStyle(
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(color: textColor),
                child: content,
              ),
            ),
          ),
          if (focus.hasFocus)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.scalablePixel),
                        border: Border.all(
                            color: context.colorScheme.primary, width: 3))),
              ),
            )
        ],
      ),
    );

    // add press effect:
    if (pressEffect && onPressed != null) button = _ButtonPressEffect(button);

    // add semantics?
    if (semanticLabel.isEmpty) return button;
    return Semantics(
      label: semanticLabel,
      button: true,
      container: true,
      child: ExcludeSemantics(child: button),
    );
  }
}

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;
  const AppIcon(this.icon, {super.key, this.size = 22, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Icon(color: context.colorScheme.surface, icon),
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  final Color? bgColor;

  final Color? iconColor;
  final IconData? icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final bool? isDismissible;
  const BackBtn({
    super.key,
    this.icon,
    this.onPressed,
    this.semanticLabel,
    this.bgColor,
    this.iconColor,
    this.isDismissible,
  });

  @override
  Widget build(BuildContext context) {
    var toShow = isDismissible ?? true;
    return FullscreenKeyboardListener(
        onKeyDown: (event) => _handleKeyDown(context, event),
        child: toShow
            ? CircleIconBtn(
                icon: icon ?? Icons.close,
                bgColor: bgColor,
                color: iconColor,
                onPressed: () =>
                    isDismissible ?? true ? _handleOnPressed(context) : null,
                semanticLabel: semanticLabel ?? "back",
              )
            : const SizedBox.shrink());
  }

  Widget safe() => _SafeAreaWithPadding(child: this);

  bool _handleKeyDown(BuildContext context, KeyDownEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _handleOnPressed(context);
      return true;
    }
    return false;
  }

  void _handleOnPressed(BuildContext context) {
    if (onPressed != null) {
      onPressed?.call();
    } else {
      Navigator.of(context).pop();
    }
  }
}

class CircleBtn extends StatelessWidget {
  static double defaultSize = 27.scalablePixel;

  final VoidCallback? onPressed;

  final Color? bgColor;
  final BorderSide? border;
  final Widget child;
  final double? size;
  final String semanticLabel;
  const CircleBtn({
    super.key,
    required this.child,
    required this.onPressed,
    this.border,
    this.bgColor,
    this.size,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    double sz = size ?? defaultSize;
    return AppBtn(
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      minimumSize: Size(sz, sz),
      padding: EdgeInsets.zero,
      circular: true,
      bgColor: bgColor,
      border: border,
      child: child,
    );
  }
}

class CircleIconBtn extends StatelessWidget {
  //TODO: Reduce size if design re-exports icon-images without padding
  static double defaultSize = 28;

  final IconData icon;

  final VoidCallback? onPressed;
  final BorderSide? border;
  final Color? bgColor;
  final Color? color;
  final String semanticLabel;
  final double? size;
  final double? iconSize;
  final bool flipIcon;
  const CircleIconBtn({
    super.key,
    required this.icon,
    required this.onPressed,
    this.border,
    this.bgColor,
    this.color,
    this.size,
    this.iconSize,
    this.flipIcon = false,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    Color defaultColor = CoreColors.grey;
    Color iconColor = color ?? CoreColors.lightgrey;
    return CircleBtn(
      onPressed: onPressed,
      border: border,
      size: size,
      bgColor: bgColor ?? defaultColor,
      semanticLabel: semanticLabel,
      child: Transform.scale(
        scaleX: flipIcon ? -1 : 1,
        child: AppIcon(icon, size: iconSize ?? defaultSize, color: iconColor),
      ),
    );
  }

  Widget safe() => _SafeAreaWithPadding(child: this);
}

class FullscreenKeyboardListener extends StatefulWidget {
  final Widget child;
  final bool Function(KeyDownEvent event)? onKeyDown;
  final bool Function(KeyUpEvent event)? onKeyUp;
  final bool Function(KeyRepeatEvent event)? onKeyRepeat;
  const FullscreenKeyboardListener(
      {super.key,
      required this.child,
      this.onKeyDown,
      this.onKeyUp,
      this.onKeyRepeat});

  @override
  State<FullscreenKeyboardListener> createState() =>
      _FullscreenKeyboardListenerState();
}

/// //////////////////////////////////////////////////
/// _ButtonDecorator
/// Add a transparency-based press effect to buttons.
/// //////////////////////////////////////////////////
class _ButtonPressEffect extends StatefulWidget {
  final Widget child;
  const _ButtonPressEffect(this.child);

  @override
  State<_ButtonPressEffect> createState() => _ButtonPressEffectState();
}

class _ButtonPressEffectState extends State<_ButtonPressEffect> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTapDown: (_) => setState(() => _isDown = true),
      onTapUp: (_) => setState(
          () => _isDown = false), // not called, TextButton swallows this.
      onTapCancel: () => setState(() => _isDown = false),
      behavior: HitTestBehavior.translucent,
      child: Opacity(
        opacity: _isDown ? 0.7 : 1,
        child: ExcludeSemantics(child: widget.child),
      ),
    );
  }
}

class _CustomFocusBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, FocusNode focus) builder;
  final void Function(bool hasFocus)? onFocusChanged;
  final FocusNode? focusNode;
  const _CustomFocusBuilder(
      {required this.builder, this.focusNode, this.onFocusChanged});
  @override
  State<_CustomFocusBuilder> createState() => _CustomFocusBuilderState();
}

class _CustomFocusBuilderState extends State<_CustomFocusBuilder> {
  late final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context, _focusNode);
  }

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChanged);
    super.initState();
  }

  void _handleFocusChanged() {
    widget.onFocusChanged?.call(_focusNode.hasFocus);
    setState(() {});
  }
}

class _FullscreenKeyboardListenerState
    extends State<FullscreenKeyboardListener> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_handleKey);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_handleKey);
  }

  bool _handleKey(KeyEvent event) {
    bool result = false;

    /// Exit early if we are not the current;y focused route (dialog on top?)
    if (ModalRoute.of(context)?.isCurrent == false) return false;

    if (event is KeyDownEvent && widget.onKeyDown != null) {
      result = widget.onKeyDown!.call(event);
    }
    if (event is KeyUpEvent && widget.onKeyUp != null) {
      result = widget.onKeyUp!.call(event);
    }
    if (event is KeyRepeatEvent && widget.onKeyRepeat != null) {
      result = widget.onKeyRepeat!.call(event);
    }
    return result;
  }
}

class _SafeAreaWithPadding extends StatelessWidget {
  final Widget child;

  const _SafeAreaWithPadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all(8.scalablePixel),
        child: child,
      ),
    );
  }
}
