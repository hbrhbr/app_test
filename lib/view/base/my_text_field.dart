import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_test/util/color_constants.dart';
import 'package:app_test/util/dimensions.dart';
import 'package:app_test/util/styles.dart';

TextStyle postTextStyle({
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.w400,
  String ?fontFamily,
  TextDecoration decoration = TextDecoration.none,
  Color color = Colors.black,
  FontStyle fontStyle = FontStyle.normal,
}){

  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
    decoration: decoration,
    color: color,
    fontStyle: fontStyle,
  );
}

class PostDoneButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final double minWidth;
  final Color ?backGroundColor;
  const PostDoneButton({Key? key,required this.onPressed, this.buttonText = 'Done',this.minWidth=double.infinity, this.backGroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      height: 40,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(33),
      ),
      color: backGroundColor??Theme.of(context).primaryColor,
      child: Text(
        buttonText,
        style: postTextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class CustomInputTextField extends StatefulWidget {

  final TextEditingController controller;
  final FocusNode ?focusNode;
  final BuildContext context;
  final double? width;
  final Color ?backgroundShadow;
  final void Function()? onTap;
  final bool readOnly;
  final String ?hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? Function(String?)? onValueChange;
  final List<TextInputFormatter> ?inputFormatters;
  final TextInputAction? textInputAction;
  final int ?minLines;
  final int ?maxLines;
  final int? maxTextLength;
  final bool obscureText;
  final bool noPadding;
  final bool noBorder;
  final double fieldRadius;


  const CustomInputTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.context,
    this.width,
    this.noBorder = true,
    this.backgroundShadow,
    this.onTap,
    this.readOnly = false,
    this.hintText,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction,
    this.minLines,
    this.maxLines,
    this.maxTextLength,
    this.validator,
    this.onValueChange,
    this.isPassword = false,
    this.obscureText = false,
    this.noPadding = false,
    this.fieldRadius = Dimensions.BORDER_RADIUS,
  }) : super(key: key);

  @override
  State<CustomInputTextField> createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width??double.infinity,
      padding: EdgeInsets.symmetric(horizontal: widget.noPadding? 0: 10),
      decoration: widget.noBorder ? BoxDecoration(
        // boxShadow: [
        //   BoxShadow(color: Colors.grey.shade100, blurRadius: 5.0, spreadRadius: 0.1),
        // ],
        borderRadius: BorderRadius.circular(widget.fieldRadius)
      ) : null,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        textCapitalization: TextCapitalization.sentences,
        onTap: widget.onTap!=null?(){
          FocusScope.of(context).unfocus();
          widget.onTap!();
        }:null,
        onChanged: widget.onValueChange,
        maxLength: widget.maxTextLength,
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        style: poppinsSemiBold.copyWith(fontSize: 15,),
        enabled: !widget.readOnly,
        decoration: inputFieldDecoration(context: context,hintText: widget.hintText, suffixIcon: widget.suffixIcon, fieldRadius: widget.fieldRadius, noBorder: widget.noBorder),
      ),
    );
  }
}
TextInputType getKeyboardTypeForDigitsOnly(){
  return Platform.isIOS?TextInputType.datetime:TextInputType.number;
}

InputBorder inputFieldBorder({required double fieldRadius, bool noBorder = true}){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(fieldRadius),
    // borderSide: BorderSide(color: noBorder ? Colors.transparent : Colors.black),
    borderSide: const BorderSide(color: Colors.black),
  );
}

InputDecoration inputFieldDecoration({required BuildContext context,String ?hintText, Widget? suffixIcon, required double fieldRadius, bool noBorder = true}){
  return InputDecoration(
    contentPadding: const EdgeInsets.all(15,),
    filled: true,
    fillColor:  Theme.of(context).primaryColorLight,
    errorMaxLines: 2,
    errorStyle: poppinsSemiBold.copyWith(color: Colors.red, fontSize: 11,),
    floatingLabelStyle: poppinsSemiBold.copyWith(fontSize: context.height*0.025,),
    hintText: hintText!=null? "Enter $hintText":"",
    hintStyle: poppinsSemiBold.copyWith(color: Theme.of(context).hintColor),
    counterStyle:  poppinsSemiBold.copyWith(fontSize: context.height*0.025,),
    suffixIcon: suffixIcon,
    suffixIconColor: Colors.black,
    disabledBorder: inputFieldBorder(fieldRadius: fieldRadius, noBorder: noBorder),
    enabledBorder: inputFieldBorder(fieldRadius: fieldRadius, noBorder: noBorder),
    border: inputFieldBorder(fieldRadius: fieldRadius, noBorder: noBorder),
    errorBorder: inputFieldBorder(fieldRadius: fieldRadius, noBorder: noBorder),
    focusedBorder: inputFieldBorder(fieldRadius: fieldRadius, noBorder: noBorder),
    focusedErrorBorder: inputFieldBorder(fieldRadius: fieldRadius, noBorder: noBorder),
  );
}
