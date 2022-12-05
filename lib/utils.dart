import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(double size, [Color? color, FontWeight? fw]){
  return GoogleFonts.montserrat(fontSize: size, color: color, fontWeight: fw,
  );
}

List<String> categories = ['General','Science','Sports','Technology','Business',
  'Health','Entertainment'];

List<String> countryCodes = ['ae','ar','at','au','be','bg','br','ca','ch','cn',
  'co','cu','cz','de','eg','fr','gb','gr','hk','hu','id','ie','il','in','it','jp',
  'kr','lt','lv','ma','mx','my','ng','nl','no','nz','ph','pl','pt','ro','rs','ru',
  'sa','se','sg','si','sk','th','tr','tw','ua','us','ve','za'];