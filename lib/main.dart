import 'package:flutter/material.dart';
import 'package:mscpl_jogendra/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

class OTPTextField extends StatefulWidget {
  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  FocusNode nextFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    otpFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: index < otpController.text.length
                    ? Colors.white
                    : Colors.grey,
              ),
              alignment: Alignment.center,
              child: Text(
                index < otpController.text.length
                    ? otpController.text[index]
                    : '',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: otpController,
          focusNode: nextFocusNode,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          onChanged: (value) {
            if (value.length == 6) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
            setState(() {});
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
    nextFocusNode.dispose();
    super.dispose();
  }
}
