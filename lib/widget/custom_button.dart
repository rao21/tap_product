import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final bool isEnable;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.title,
    this.isEnable = false,
    this.isLoading = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.5,
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Text(title!),
          onPressed: isEnable ? onPressed : () {},
          style: ElevatedButton.styleFrom(
            onPrimary: Theme.of(context).primaryColor,
            primary: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ),
    );
  }
}
