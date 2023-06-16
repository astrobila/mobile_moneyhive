import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    super.key,
    this.icon,
    required this.title,
    this.padding,
    this.onTap,
  });

  final IconData? icon;
  final String title;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              size: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
            child: Text(
              title,
              textScaleFactor: 1.1,
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
