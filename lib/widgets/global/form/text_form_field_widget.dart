import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/typedefs.dart' show TextFormFieldValidatorTypedef, OnSavedTextFormFieldTypedef;
import 'package:invoice/functions/core_function.dart';

class TextFormFieldWidget extends StatelessWidget {

  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final Widget? counter;
  final String? helperText;
  final bool? obscureText;
  final Icon? icon;
  final double? borderRadius;
  final double? widthBorder;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final FocusNode? focusNode;
  final TextFormFieldValidatorTypedef? validator;
  final OnSavedTextFormFieldTypedef? onSaved;
  final OnSavedTextFormFieldTypedef? onChanged;

  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.counter,
    this.helperText,
    this.obscureText,
    this.icon,
    this.borderRadius,
    this.widthBorder,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textAlign,
    this.inputFormatters,
    this.errorText,
    this.focusNode,
    this.validator,
    this.onSaved,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.next,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: keyboardType == TextInputType.number ? TextDirection.ltr : null,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w500),
      inputFormatters: keyboardType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly , ...inputFormatters ?? []] : inputFormatters,
      decoration: InputDecoration(
        label: Text(label ?? ''),
        helperText: helperText ?? '',
        errorText: errorText,
        counter: counter,
        icon: icon,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(.6)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Config.borderRadius),
          borderSide: BorderSide(
            color: switchColor(context, light: Theme.of(context).colorScheme.primary.withOpacity(.3), dark: Theme.of(context).colorScheme.primary.withOpacity(.2)),
            width: widthBorder ?? Config.widthBorder
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Config.borderRadius),
          borderSide: BorderSide(
            color: Config.brandColor,
            width: widthBorder ?? Config.widthBorder
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Config.borderRadius),
          borderSide: BorderSide(
            color: Config.dangerColor.withOpacity(.7),
            width: widthBorder ?? Config.widthBorder
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Config.borderRadius),
          borderSide: BorderSide(
            color: Config.dangerColor.withOpacity(.7),
            width: widthBorder ?? Config.widthBorder
          ),
        ),
        errorMaxLines: 3,
        // prefixIconColor: 
        // suffixIconColor: 
        helperMaxLines: 3,
        helperStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary.withOpacity(.5),
          fontSize: Config.fontSizeExtraSmall
        ),
      ),
    );
  }
}
