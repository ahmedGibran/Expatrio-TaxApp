import 'package:flutter/material.dart';

class CustomBottomSheet {
  final BuildContext context;
  final double heightFactor;
  final Widget child;
  final EdgeInsets padding;
  CustomBottomSheet(
      {required this.context, this.heightFactor = 0.9, required this.child, this.padding = const EdgeInsets.all(32)}) {
    _showModalBottomSheet();
  }
  void _showModalBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
            heightFactor: heightFactor,
            child: Container(
              color: Colors.transparent,
              child: Container(
                  padding: padding,
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
