import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CutomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final Function(String) onChange;
  final TextInputType keyBoardType;
  final List<TextInputFormatter>? formatters;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  const CutomTextField(
      {Key? key,
      this.hint,
      required this.controller,
      required this.onChange,
      this.formatters,
      this.trailingWidget,
      this.leadingWidget,
      this.keyBoardType = TextInputType.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SizedBox(
        height: 48,
        child: TextFormField(
          keyboardType: keyBoardType,
          autovalidateMode: AutovalidateMode.always,
          controller: controller,
          maxLines: 1,
          inputFormatters: formatters,
          decoration: InputDecoration(
            prefixIcon: leadingWidget,
            suffixIcon: trailingWidget,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            labelText: hint,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            fillColor: Theme.of(context).primaryColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).accentColor,
                )),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          onChanged: onChange,
        ),
      ),
    );
  }
}
