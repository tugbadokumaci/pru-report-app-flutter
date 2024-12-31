import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  final BuildContext context;
  final Color buttonColor;
  final Widget content;
  final Color? borderColor;
  final void Function()? onPressed;
  final bool enabled;

  const MyButtonWidget({super.key, 
    required this.context,
    required this.buttonColor,
    required this.content,
    this.borderColor,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: (borderColor == null) ? buttonColor : borderColor!,
                width: 1.0,
              ),
            ),
          ),
        ),
        child: content,
      ),
    );
  }
}
