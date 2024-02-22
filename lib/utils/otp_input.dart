// custom otp container

import 'package:flutter/material.dart';

class OTPInput extends StatefulWidget {
  final int otpLength;
  final Function(String) onCompleted;

  OTPInput({required this.otpLength, required this.onCompleted});

  @override
  _OTPInputState createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  Color boxColor = Colors.grey.withOpacity(0.2);

  @override
  void initState() {
    super.initState();
    _focusNodes =
        List<FocusNode>.generate(widget.otpLength, (index) => FocusNode());
    _controllers = List<TextEditingController>.generate(
        widget.otpLength, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.otpLength,
        (index) => Container(
          decoration: BoxDecoration(
            color: boxColor,
            // color: containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 50,
          height: 50,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                counterText: ""),
            maxLength: 1,
            onChanged: (value) {
              if (value.isNotEmpty) {
                boxColor = Colors.white;
                if (index < widget.otpLength - 1) {
                  _focusNodes[index + 1].requestFocus();
                } else {
                  _focusNodes[index].unfocus();
                  if (widget.onCompleted != null) {
                    widget.onCompleted(_controllers
                        .map((controller) => controller.text)
                        .join());
                  }
                }
              } else {
                if (index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
              }
            },
            onSubmitted: (value) {
              if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
