import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/round_button.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';
import 'package:talnts_app/features/auth/views/reset_password.dart';

class PasswordResetOtpScreen extends StatefulWidget {
  const PasswordResetOtpScreen({Key? key, required this.emailAddress})
      : super(key: key);

  final String emailAddress;

  @override
  State<PasswordResetOtpScreen> createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<PasswordResetOtpScreen> {
  final introdata = GetStorage();
  final AuthController _authController = Get.put(AuthController());

  final TextEditingController _otpPinController = TextEditingController();

  Color get _colorBackground => Colors.white;

  Color get _colorBorder => Colors.grey.withOpacity(0.3);

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
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Forgot Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    height: 30,
                  ),
                  const Text(
                    'Please Input the OTP sent to your Email Address',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  PinCodeTextField(
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (value) {
                      if (value == '') {
                        return "Pin cannot be empty";
                      } else if (value!.length < 6) {
                        return 'Enter your 6 digit Pin';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {},
                    cursorColor: Colors.black,
                    appContext: context,
                    length: 6,
                    controller: _otpPinController,
                    backgroundColor: Colors.transparent,
                    enableActiveFill: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autoDisposeControllers: false,
                    enablePinAutofill: true,
                    autoFocus: false,
                    pinTheme: PinTheme(
                      errorBorderColor: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 1,
                      fieldWidth: 46,
                      fieldHeight: 48,
                      activeColor: _colorBorder,
                      activeFillColor: _colorBackground,
                      inactiveColor: _colorBorder,
                      selectedColor: _colorBorder,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      shape: PinCodeFieldShape.box,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Obx(
                    () => RoundedButtonWidget(
                        loading: _authController.isLoading.value,
                        buttonText: 'Continue',
                        width: double.infinity,
                        onpressed: () {
                          if (_otpPinController.text.length == 6) {
                            Get.to(() => ResetPassword(
                                emailAddress: widget.emailAddress,
                                otpCode: int.parse(_otpPinController.text)));
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        _authController.resendOtp(widget.emailAddress);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Did not get OTP?',
                          style: TextStyle(
                              color: grey, fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(
                                text: '  Resend',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
