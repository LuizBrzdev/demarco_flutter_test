import 'package:flutter/material.dart';

class CFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: const Key('FloatingActionButton'),
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
