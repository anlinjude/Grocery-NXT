import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customTextField(BuildContext context,
    {TextInputType? textInputType,
    Widget? prefix,
    String hint = "",
    double? borderRadius=8,
    Color? borderColor,
    Color? fillColor,
    double? height,
    Widget? suffix,
    bool obscureText = false,
    Color? color,
    EdgeInsetsGeometry? contentPadding,
    TextCapitalization? textCapitalization,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    Function(String?)? onSaved,
    Function(String?)? onChanged,
      TextInputAction ?textInputAction,
    int? maxLength,
      int ?maxlines,

    }) {
  return TextFormField(
    onChanged: onChanged,
    keyboardAppearance: Brightness.dark,
    textInputAction: textInputAction ?? TextInputAction.done,
    obscureText: obscureText,
    maxLength: maxLength,
    maxLines: maxlines,
    inputFormatters: inputFormatters,
    controller: controller,
    validator: validator,
    autovalidateMode: AutovalidateMode.always,
    keyboardType: textInputType ?? TextInputType.text,
    style: const TextStyle(fontSize: 12, color: Colors.black),
    textCapitalization: textCapitalization ?? TextCapitalization.words,
    onSaved: onSaved,
    decoration: InputDecoration(
      disabledBorder: InputBorder.none,
      //errorStyle: GoogleFonts.jost(),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.3)),
      isDense: true,
      filled: true,
      //contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 15.h),
      fillColor: fillColor ?? Colors.white.withOpacity(0.2),
      counterText: "",
      prefixIcon: prefix,
      suffixIcon: suffix,
      hintText: hint,
      hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.4),
          fontSize: 12,
          fontWeight: FontWeight.w400
      ),
      enabled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        borderSide: BorderSide(
          // width: 0.90,
          color: borderColor ?? Colors.transparent,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        borderSide: BorderSide(
            color: borderColor ??
                Colors.transparent), // Set border color to transparent
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        borderSide: BorderSide(
            color: borderColor ??
                Colors.transparent), // Set border color to transparent
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(borderRadius ?? 24.5.r),
      // ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 0.3), // Set border color to transparent
      ),
      // focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(borderRadius ?? 24.5.r),
      //     borderSide: const BorderSide(width: 0.5))
    ),
  );
}
