import 'package:flutter/material.dart';

class AppToast {
  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry; // Declare it first

    overlayEntry = OverlayEntry(
      builder: (context) => _DropDownToastWidget(
        message: message,
        duration: duration,
        onDismissed: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _DropDownToastWidget extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback onDismissed;

  const _DropDownToastWidget({
    required this.message,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_DropDownToastWidget> createState() => _DropDownToastWidgetState();
}

class _DropDownToastWidgetState extends State<_DropDownToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) => widget.onDismissed());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          elevation: 12,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(color: Colors.green, width: 6),
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, color: Colors.green),
                const SizedBox(width: 32),
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onDismissed,
                  child: Icon(Icons.close, size: 36, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
