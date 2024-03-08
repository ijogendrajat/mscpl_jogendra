import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class OTPInput extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final int boxCount;
  final double boxSize;
  const OTPInput({
    super.key,
    required this.onCompleted,
    this.boxCount = 6,
    this.boxSize = 50,
  });

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];
  final List<String> _code = [];
  int _currentIndex = 0;

  @override
  void initState() {
    if (_listFocusNode.isEmpty) {
      for (var i = 0; i < widget.boxCount; i++) {
        _listFocusNode.add(FocusNode());
        _listControllerText.add(TextEditingController());
        _code.add(' ');
      }
    }
    super.initState();
  }

  String _getInputVerify() {
    String pin = '';
    for (var i = 0; i < widget.boxCount; i++) {
      for (var index = 0; index < _listControllerText[i].text.length; index++) {
        if (_listControllerText[i].text[index] != ' ') {
          pin += _listControllerText[i].text[index];
        }
      }
    }
    return pin;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _widgetItemList()),
    );
  }

  List<Widget> _widgetItemList() {
    List<Widget> widgetList = [];
    for (int index = 0; index < widget.boxCount; index++) {
      double left = (index == 0) ? 0.0 : (widget.boxSize / 10);
      widgetList.add(Container(
          height: widget.boxSize,
          width: widget.boxSize,
          margin: EdgeInsets.only(left: left),
          child: _inputField(index)));
    }
    return widgetList;
  }

  Widget _inputField(int index) {
    return TextField(
      keyboardType: TextInputType.number,
      maxLines: 1,
      maxLength: 2,
      focusNode: _listFocusNode[index],
      decoration: InputDecoration(
          enabled: _currentIndex == index,
          counterText: "",
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(((widget.boxSize * 2) / 10)),
          filled: true,
          fillColor: const Color(0xffF2F4F7)),
      onChanged: (String value) {
        widget.onCompleted(_getInputVerify());
        if (value.length > 1 && index < widget.boxCount ||
            index == 0 && value.isNotEmpty) {
          if (index == widget.boxCount - 1) {
            return;
          }
          if (_listControllerText[index + 1].value.text.isEmpty) {
            _listControllerText[index + 1].value =
                const TextEditingValue(text: " ");
          }
          if (value.length == 2) {
            if (value[0] != _code[index]) {
              _code[index] = value[0];
            } else if (value[1] != _code[index]) {
              _code[index] = value[1];
            }
            if (value[0] == " ") {
              _code[index] = value[1];
            }
            _listControllerText[index].text = _code[index];
          }
          _next(index);

          return;
        }
        if (value.isEmpty && index > 0) {
          if (_listControllerText[index - 1].value.text.isEmpty) {
            _listControllerText[index - 1].value =
                const TextEditingValue(text: " ");
          }
          _prev(index);
        }
      },
      controller: _listControllerText[index],
      autocorrect: false,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24, color: Colors.black),
    );
  }

  void _next(int index) {
    if (index != widget.boxCount) {
      setState(() {
        _currentIndex = index + 1;
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_listFocusNode[index + 1]);
      });
    }
  }

  void _prev(int index) {
    if (index > 0) {
      setState(() {
        if (_listControllerText[index].text.isEmpty) {
          _listControllerText[index - 1].text = ' ';
        }
        _currentIndex = index - 1;
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_listFocusNode[index - 1]);
      });
    }
  }
}
