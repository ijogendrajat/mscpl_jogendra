// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/otp_input.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  const OtpScreen({super.key, required this.mobileNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Timer _timer;
  int _secondsRemaining = 170; // OTP timer 2.50 => 2*60+50
  String _otp = "";
  int _resendCounter = 0;
  Color _containerColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_secondsRemaining <= 0) {
          timer.cancel();
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  void _onOTPCompleted(String otp) {
    _otp = otp;
    if (otp == "934477") {
      setState(() {
        _containerColor = Colors.green;
      });
    } else {
      setState(() {
        _containerColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: _secondsRemaining);
    String timerText =
        '${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify your phone",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Enter the verification code sent to ( ${widget.mobileNumber[0]}**) ***-**${widget.mobileNumber.substring(8, 10)}.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildOTPContainer(timerText),
              Spacer(),
              _buildResendButton(),
              SizedBox(height: 20),
              _buildChangeNumberButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPContainer(String timerText) {
    return Container(
      decoration: BoxDecoration(
        color: _containerColor,
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.infinity,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OTPInput(
              otpLength: 6,
              onCompleted: _onOTPCompleted,
            ),
          ),
          _buildOTPValidationText(timerText),
        ],
      ),
    );
  }

  Widget _buildOTPValidationText(String timerText) {
    return _otp.length == 6
        ? (_otp == "934477")
            ? Text(
                "Verified",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )
            : Text(
                "Invalid OTP",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )
        : Text(
            "Verification code expires in $timerText",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          );
  }

  Widget _buildResendButton() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: (_secondsRemaining == 0 && _resendCounter < 5)
            ? () {
                debugPrint("Sent OTP Again BTN Clicked");
                _startTimer();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('You can try max. 5 times : Alert'),
                  ),
                );
              }
            : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Resend Code",
          style: TextStyle(
              color: (_secondsRemaining == 0) ? Colors.black : Colors.grey),
        ),
      ),
    );
  }

  Widget _buildChangeNumberButton() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Change Number",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
