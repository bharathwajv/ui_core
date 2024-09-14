import '../../Extension.dart';
import '../../buttons/custom_text_button.dart';
import '../../plugins/ElegantSpring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomPageViewContent extends StatefulWidget {
  final List<Widget Function(VoidCallback animateToNextPage)> pageBuilders;
  final double fixedHeight;
  final VoidCallback? onLastPage;

  const CustomPageViewContent({
    super.key,
    required this.pageBuilders,
    required this.fixedHeight,
    this.onLastPage,
  });

  @override
  State<CustomPageViewContent> createState() => _CustomPageViewContentState();
}

class _CustomPageViewContentState extends State<CustomPageViewContent> {
  late PageController _pageController;
  int _currentPage = 0;

  Future<void> animateToNextPage() async {
    bool isLastPage = _currentPage == widget.pageBuilders.length;
    if (!isLastPage) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
      setState(() {
        _currentPage++;
      });
    } else if (widget.onLastPage != null) {
      widget.onLastPage!();
    }
  }

  Future<void> animateToPreviousPage() async {
    if (_currentPage > 0) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
        _pageController.hasClients ? (_pageController.page ?? 0) : 0;
    return SizedBox(
      height: (widget.fixedHeight + (progress * 60.scalablePixel)),
      child: Column(
        children: [
          SizedBox(height: 16.scalablePixel),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: widget.pageBuilders
                  .map((builder) => builder(animateToNextPage))
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15.scalablePixel, vertical: 20.scalablePixel),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    flex: 1,
                    child: CustomTextButton(
                      showSpinner: false,
                      isOutlined: true,
                      tintedBackground: true,
                      icon: Icons.chevron_left,
                      buttonText: Text(
                        '',
                        style: context.textTheme.modifiedTextTheme(
                          context.textTheme.bodyLarge,
                          context.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onClick: animateToPreviousPage,
                      color: context.colorScheme.primary,
                    ),
                  ).animate().slide(
                        duration: 300.ms,
                        begin: const Offset(-1, 0),
                        curve: ElegantSpring(duration: 150.ms, bounce: 0.25),
                      ),
                if (_currentPage > 0) SizedBox(width: 15.scalablePixel),
                Expanded(
                  flex: _currentPage == 0 ? 4 : 3,
                  child: CustomTextButton(
                    showSpinner: false,
                    isIconTrailing: true,
                    tintedBackground: true,
                    icon: Icons.navigate_next_rounded,
                    buttonText: Text(
                      'Continue',
                      style: context.textTheme.modifiedTextTheme(
                        context.textTheme.bodyLarge,
                        context.colorScheme.onPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onClick: animateToNextPage,
                    color: context.colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(() => setState(() {}));
  }
}
