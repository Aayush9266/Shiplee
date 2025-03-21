import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../main.dart';

class FormField extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget child;

  const FormField({
    Key? key,
    required this.label,
    required this.icon,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
