import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talnts_app/common/widgets/dimensions.dart';
import 'package:talnts_app/common/widgets/colors.dart';



Widget fieldLabel(String label, bool showRequiredSymbol) {
  return Row(children: [
    Text(label,
    style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
    SizedBox(
      width: size2.w,
    ),
    showRequiredSymbol
        ? const Text(
            "*",
            style: TextStyle(
                fontSize: 19, color: textColor, fontWeight: FontWeight.w900),
          )
        : const SizedBox()
  ]);
}