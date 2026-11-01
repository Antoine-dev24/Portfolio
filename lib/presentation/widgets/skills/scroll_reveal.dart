import 'package:flutter/material.dart';

/// Fait apparaître [child] après [delay], dès qu'il arrive à l'écran.
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({super.key, required this.delay, required this.child});

  static const _revealDuration = Duration(milliseconds: 350);

  final Duration delay;
  final Widget child;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.delay + ScrollReveal._revealDuration,
  );
  late final _progress = CurvedAnimation(
    parent: _controller,
    curve: Interval(
      widget.delay.inMilliseconds / _controller.duration!.inMilliseconds,
      1,
      curve: Curves.easeOut,
    ),
  );

  ScrollPosition? _position;
  bool _revealed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _position?.removeListener(_revealIfVisible);
    _position = null;
    if (_revealed) return;

    _position = Scrollable.maybeOf(context)?.position;
    _position?.addListener(_revealIfVisible);
    WidgetsBinding.instance.addPostFrameCallback((_) => _revealIfVisible());
  }

  @override
  void dispose() {
    _position?.removeListener(_revealIfVisible);
    _progress.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _revealIfVisible() {
    if (!mounted || _revealed) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final top = box.localToGlobal(Offset.zero).dy;
    if (top > MediaQuery.sizeOf(context).height) return;

    _revealed = true;
    _position?.removeListener(_revealIfVisible);
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _progress,
      child: ScaleTransition(
        scale: Tween(begin: 0.8, end: 1.0).animate(_progress),
        child: widget.child,
      ),
    );
  }
}
