import 'package:flutter/material.dart';

class CustomBottomSheet {
  final BuildContext context;
  final double heightFactor;
  final Widget child;
  CustomBottomSheet({required this.context, this.heightFactor = 0.9, required this.child}) {
    _showModalBottomSheet();
  }
  void _showModalBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
            heightFactor: 0.9,
            child: Container(
              color: Colors.transparent,
              child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: child),
            ));
      },
    );
  }
}
