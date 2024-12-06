import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'draggable_item.dart';

class Dock<T extends Object> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item, double scale) builder;

  const Dock({
    super.key,
    required this.items,
    required this.builder,
  });

  @override
  State<Dock<T>> createState() => _DockState<T>();
}

class _DockState<T extends Object> extends State<Dock<T>> {
  late List<T> _items;
  int? _hoverIndex;

  @override
  void initState() {
    super.initState();
    _items = widget.items.toList();
  }

  void _onHover(int index) {
    setState(() {
      _hoverIndex = index;
    });
  }

  void _onExit() {
    setState(() {
      _hoverIndex = null;
    });
  }

  double _getScale(int index) {
    if (_hoverIndex == null) return 1.0;

    final distance = (_hoverIndex! - index).abs();
    if (distance == 0) return 1.5; // Hovered item scales to 1.5x.
    if (distance == 1) return 1.2; // Immediate neighbors scale to 1.2x.
    return 1.0;
  }

  void _onReorder(T data, int direction) {
    int currentIndex = _items.indexOf(data);
    int newIndex = currentIndex + direction;

    if (newIndex < 0 || newIndex >= _items.length) return;

    setState(() {
      final item = _items.removeAt(currentIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 80,
      borderRadius: 24,
      blur: 15,
      alignment: Alignment.center,
      border: 0.5,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.05),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_items.length, (index) {
          return MouseRegion(
            onEnter: (_) => _onHover(index),
            onExit: (_) => _onExit(),
            child: Draggable<T>(
              data: _items[index],
              feedback: Material(
                color: Colors.transparent,
                child: widget.builder(_items[index], _getScale(index)),
              ),
              childWhenDragging: Container(),
              child: DraggableItem<T>(
                data: _items[index],
                onReorder: _onReorder,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.identity()
                    ..translate(0.0, _hoverIndex == index ? -10.0 : 0.0),
                  child: widget.builder(_items[index], _getScale(index)),
                ).animate().scale(delay: 100.ms, duration: 300.ms),
              ),
            ),
          );
        }),
      ),
    );
  }
}
