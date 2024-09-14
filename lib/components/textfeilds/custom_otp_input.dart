import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpInput extends StatefulWidget {
  final int length;
  final void Function(String) onCompleted;

  const CustomOtpInput({
    super.key,
    this.length = 6,
    required this.onCompleted,
  });

  @override
  _CustomOtpInputState createState() => _CustomOtpInputState();
}

class _CustomOtpInputState extends State<CustomOtpInput> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
        (index) => Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            obscureText: true,
            obscuringCharacter: '●', // Black circle
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12), // Match the rounded corners
                borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2), // Black border with 2px width
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2), // Black border with 2px width when focused
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: (value) => _onChanged(value, index),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
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
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
    _controllers =
        List.generate(widget.length, (index) => TextEditingController());

    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _moveToNextEmptyField();
        }
      });
    }
  }

  void _checkCompletion() {
    final otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  void _moveToNextEmptyField() {
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.isEmpty) {
        _focusNodes[i].requestFocus();
        return;
      }
    }
    // If all fields are filled, move to the last field
    _focusNodes.last.requestFocus();
  }

  void _onChanged(String value, int index) {
    if (value.isEmpty && index > 0) {
      // Clear all fields when backspace is pressed
      for (int i = index; i < widget.length; i++) {
        _controllers[i].clear();
      }
      _focusNodes[index - 1].requestFocus();
    } else if (value.isEmpty && index == widget.length - 1) {
      // Clear all fields if the last field is erased
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].clear();
      }
      _focusNodes[0].requestFocus();
    } else if (value.length == 1) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _checkCompletion();
      }
    }
  }
}
