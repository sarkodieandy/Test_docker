import 'package:flutter/material.dart';

class HoverableAnimatedContainer extends StatefulWidget {
  final Widget child;
  final double normalSize;
  final double hoverSize;
  final Duration duration;

  const HoverableAnimatedContainer({
    super.key,
    required this.child,
    this.normalSize = 48,
    this.hoverSize = 64,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverableAnimatedContainer> createState() =>
      _HoverableAnimatedContainerState();
}

class _HoverableAnimatedContainerState
    extends State<HoverableAnimatedContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        height: _isHovered ? widget.hoverSize : widget.normalSize,
        width: _isHovered ? widget.hoverSize : widget.normalSize,
        child: widget.child,
      ),
    );
  }
}
