import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({super.key,required this.onPressed,required this.backgroundColor,required this.textColor,required this.text});
final Function()onPressed;
final Color backgroundColor;
final Color textColor;
final String text;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(style: 
                      ElevatedButton.styleFrom(backgroundColor: backgroundColor,shape: const RoundedRectangleBorder()),
                        onPressed: onPressed,
                        child: KStyles().med14(text:text,color: textColor),
                      );
  }
}