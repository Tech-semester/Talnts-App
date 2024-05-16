import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/round_button.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';
import 'package:talnts_app/features/auth/views/register.dart';

import '../../../common/widgets/textform_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key,}) : super(key: key);


  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final introdata = GetStorage();

  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  bool validateEmail(String email) {
    final valid_email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return valid_email.hasMatch(email);
  }


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children:  [
                    const SizedBox(
                      height: 50,
                    ),
                    Text('Forgot Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: primaryColor,
                        fontWeight: FontWeight.bold,),),
                    const SizedBox(
                      height: 3,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 80,
                        color: primaryColor,
                        height: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Enter your registered email address below to reset your password',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center,),
                        const SizedBox(
                          height: 40,
                        ),
                        LabelTextFormField(
                          hintText: 'Your Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val){
                            validateEmail(val);
                          },
                          validator: (value) {
                            if (value == '') {
                              return "Field cannot be empty";
                            } else {
                              bool result = validateEmail(value!);
                              if(result) {
                                return null;
                              } else {
                                return "Email format not correct";
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Obx(
                                () => RoundedButtonWidget(
                                    loading: _authController.isLoading.value,
                                    buttonText: 'Reset',
                                    width: double.infinity,
                                    onpressed: () {
                               if(_formKey.currentState!.validate()){
                                   _authController.forgotPassword(
                                 email: _emailController.text);
                                    }
                                   })),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Get.offAll(() => const Register());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '  Sign Up',
                                      style: TextStyle(color: primaryColor,
                                          fontSize: 16))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

