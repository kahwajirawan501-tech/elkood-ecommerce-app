import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor:AppColors.darkText,
  fontSize: 16.0,

);
enum ToastStates{
  SUCCESS,EROOR,WARNING
}
Color chooseToastColor(ToastStates state)
{  Color color;
switch(state){
  case ToastStates.SUCCESS:
    color=AppColors.lightBackground;

    break;
  case ToastStates.EROOR:
    color= AppColors.error;
    break;
  case ToastStates.WARNING:
    color=  AppColors.warning;
    break;

}
return color;

}