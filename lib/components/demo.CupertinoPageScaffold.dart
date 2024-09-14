import 'package:flutter/cupertino.dart';
import 'package:ui_core/constant/core_colors.dart';

void main() {
  runApp(const MyApp());
}

//First Page
class CupertinoFullscreenDialogTransitionPage extends StatefulWidget {
  const CupertinoFullscreenDialogTransitionPage({super.key});

  @override
  _CupertinoFullscreenDialogTransitionState createState() =>
      _CupertinoFullscreenDialogTransitionState();
}

//Second Page
class FullDialogPage extends StatefulWidget {
  const FullDialogPage({super.key});

  @override
  _FullDialogPageState createState() => _FullDialogPageState();
}

class MyApp extends StatelessWidget {
  static const String _title = 'AppBar tutorial';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: _title,
      home: CupertinoPageScaffold(
          child: CupertinoFullscreenDialogTransitionPage()),
    );
  }
}

class _CupertinoFullscreenDialogTransitionState
    extends State<CupertinoFullscreenDialogTransitionPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoButton.filled(
            child: const Text("Next Page Cupertino Transition"),
            onPressed: () => Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, _, __) {
                  return const FullDialogPage();
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class _FullDialogPageState extends State<FullDialogPage>
    with TickerProviderStateMixin {
  late AnimationController _primary, _secondary;
  late Animation<double> _animationPrimary, _animationSecondary;

  @override
  Widget build(BuildContext context) {
    return CupertinoFullscreenDialogTransition(
      primaryRouteAnimation: _animationPrimary,
      secondaryRouteAnimation: _animationSecondary,
      linearTransition: false,
      child: CupertinoPageScaffold(
        backgroundColor: CoreColors.grey,
        child: GestureDetector(
          onLongPress: () {
            _primary.reverse();
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _primary.dispose();
    _secondary.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //Primaty
    _primary =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationPrimary = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _primary, curve: Curves.easeOut));
    //Secondary
    _secondary =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationSecondary = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _secondary, curve: Curves.easeOut));
    _primary.forward();
    super.initState();
  }
}
