import 'package:baxi/custom/custom_border.dart';
import 'package:flutter/material.dart';

class AnimatedTextField extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String? hintText;
  final FocusNode focusNode;
  final Widget? suffix;
  const AnimatedTextField({Key? key, required this.suffix, required this.focusNode, this.onTap, this.hintText})
      : super(key: key);

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<double> alpha;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    final Animation<double> curve =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOut);
    alpha = Tween(begin: 0.0, end: 1.0).animate(curve);

    // controller?.forward();
    controller?.addListener(() {
      setState(() {});
    });
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        controller?.forward();
      } else {
        controller?.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.primary),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Theme(
        data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: theme.colorScheme.primary,
                )),
        child: CustomPaint(
          painter: CustomAnimateBorder(animationPercent: alpha.value, theme),
          child: TextField(
            cursorOpacityAnimates: true,
            onTap: widget.onTap,
            cursorColor: theme.colorScheme.onPrimary,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              suffix: widget.suffix,
            ),
          ),
        ),
      ),
    );
  }
}