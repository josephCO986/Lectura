import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark overlay
        Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        ),
        // Scanning area
        Center(
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // Corner indicators
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.green, width: 4),
                        left: BorderSide(color: Colors.green, width: 4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.green, width: 4),
                        right: BorderSide(color: Colors.green, width: 4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.green, width: 4),
                        left: BorderSide(color: Colors.green, width: 4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.green, width: 4),
                        right: BorderSide(color: Colors.green, width: 4),
                      ),
                    ),
                  ),
                ),
                // Scanning line animation
                const _ScanningLine(),
              ],
            ),
          ),
        ),
        // Instructions
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Coloca el código de barras dentro del marco',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _ScanningLine extends StatefulWidget {
  const _ScanningLine();

  @override
  State<_ScanningLine> createState() => _ScanningLineState();
}

class _ScanningLineState extends State<_ScanningLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: _animation.value * 260,
          left: 10,
          right: 10,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: Colors.green,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
