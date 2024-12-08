import 'package:flutter/material.dart';

class DraggableItem<T> extends StatelessWidget {
  final T data;
  final Function(T data, int direction) onReorder;
  final Widget child;

  const DraggableItem({
    super.key,
    required this.data,
    required this.onReorder,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx.abs() > 10) {
          onReorder(data, details.delta.dx > 0 ? 1 : -1);
        }
      },
      child: child,
    );
  }
}
