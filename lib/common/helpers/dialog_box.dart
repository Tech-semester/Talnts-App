import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/flat_button.dart';

void logoutDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Container(
              color: Colors.white,
                height: height * 0.2,
                width: width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text('Logout',
                      style: TextStyle(fontSize: 20, color: red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),
                    const SizedBox(
                      height:25,
                    ),
                    const Text('Are you sure you want to logout?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Text('Yes',
                            style: TextStyle(color: statusBar, fontWeight: FontWeight.bold),),
                          )
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Flatbutton(
                              text: 'No',
                              onpressed: (){
                                Navigator.of(context).pop(false);
                              },
                              textStyle: const TextStyle(fontSize: 12),
                            )
                        ),
                      ],
                    ),
                  ],
                ));
          },
        ),
      ));
}
