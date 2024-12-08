import 'package:flutter/material.dart';
import 'package:test_dock/widgets/docker.dart';
import 'package:test_dock/widgets/hoverable_animated_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            DragTarget<int>(
              onAcceptWithDetails: (icon) {
                // Handle what happens when an icon is dropped here
              },
              builder: (context, candidateData, rejectedData) {
                return Center(
                  child: Dock(
                    items: const [
                      Icons.person,
                      Icons.message,
                      Icons.call,
                      Icons.camera,
                      Icons.photo,
                    ],
                    builder: (icon, scale) {
                      return HoverableAnimatedContainer(
                        normalSize: 48,
                        hoverSize: 64,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.primaries[icon.hashCode % Colors.primaries.length],
                          ),
                          width: 48 * scale, // Scale width dynamically.
                          height: 48 * scale, // Scale height dynamically.
                          child: Center(
                            child: Icon(icon, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
