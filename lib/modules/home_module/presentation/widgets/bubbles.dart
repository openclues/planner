import 'dart:math';

import 'package:flutter/material.dart';

class Bubble {
  Offset position;
  double speedX;
  double speedY;
  double radius; // Dynamic radius
  String title;

  Bubble({
    required this.position,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.title,
  });
}

class BubblePage extends StatefulWidget {
  @override
  _BubblePageState createState() => _BubblePageState();
}

class _BubblePageState extends State<BubblePage> {
  late List<Bubble> bubbles;
  double defaultRadius = 50.0; // Default radius
  Bubble? selectedBubble; // The bubble being interacted with

  @override
  void initState() {
    super.initState();
    bubbles = List.generate(10, (index) {
      return Bubble(
        position:
            Offset(Random().nextDouble() * 300, Random().nextDouble() * 500),
        speedX: 0, // No initial speed
        speedY: 0, // No initial speed
        radius: defaultRadius,
        title: 'Bubble $index',
      );
    });

    // Start the animation loop
    WidgetsBinding.instance?.addPostFrameCallback(_animateBubbles);
  }

  void _handleTapDown(TapDownDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    final tappedBubble = bubbles.firstWhere(
      (bubble) => (bubble.position - localPosition).distance <= bubble.radius,
    );

    setState(() {
      selectedBubble = tappedBubble;
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (selectedBubble != null) {
      setState(() {
        selectedBubble!.position += details.delta;

        // Keep the bubble within the screen bounds
        selectedBubble!.position = Offset(
          selectedBubble!.position.dx
              .clamp(0.0, 300.0 - selectedBubble!.radius),
          selectedBubble!.position.dy
              .clamp(0.0, 500.0 - selectedBubble!.radius),
        );
      });
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    selectedBubble = null;
  }

  void _animateBubbles(Duration duration) {
    for (var i = 0; i < bubbles.length; i++) {
      var bubble = bubbles[i];
      bubble.position += Offset(bubble.speedX, bubble.speedY);

      // Check collisions with other bubbles
      for (var j = i + 1; j < bubbles.length; j++) {
        var otherBubble = bubbles[j];
        var dx = bubble.position.dx - otherBubble.position.dx;
        var dy = bubble.position.dy - otherBubble.position.dy;
        var distance = sqrt(dx * dx + dy * dy);
        var minDistance = bubble.radius + otherBubble.radius;

        if (distance < minDistance) {
          // Handle collision by adjusting directions and speeds
          var collisionVector = Offset(dx, dy);
          collisionVector = collisionVector / distance;
          var displacement = (minDistance - distance) / 2;
          bubble.position += collisionVector * displacement;
          otherBubble.position -= collisionVector * displacement;

          // Adjust speeds after collision
          var relativeSpeed = bubble.speedX - otherBubble.speedX;
          bubble.speedX -= relativeSpeed;
          otherBubble.speedX += relativeSpeed;
        }
      }

      // Screen bounds check
      if (bubble.position.dx < 0 || bubble.position.dx > 300) {
        bubble.speedX *= -1;
      }
      if (bubble.position.dy < 0 || bubble.position.dy > 500) {
        bubble.speedY *= -1;
      }
    }

    // Trigger the next frame
    setState(() {});

    // Continue the animation loop
    WidgetsBinding.instance?.addPostFrameCallback(_animateBubbles);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: bubbles.map((bubble) {
            return Positioned(
              left: bubble.position.dx,
              top: bubble.position.dy,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedBubble = bubble;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      bubble.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
