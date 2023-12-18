import 'package:flutter/material.dart';
import 'package:controle_de_estoque/features/config/theme/fonts.dart';
import 'package:controle_de_estoque/features/config/theme/colors.dart';

class InputWidget extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Icon? icon;

  const InputWidget(
      {super.key,
      required this.labelText,
      required this.obscureText,
      required this.keyboardType,
      this.icon});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      cursorColor: ColorsApp.white,
      style: FontsApp.caption1.copyWith(color: ColorsApp.white),
      decoration: InputDecoration(
          labelText: widget.labelText,
          errorMaxLines: 2,
          errorStyle: FontsApp.caption1.copyWith(color: ColorsApp.red),
          prefixIcon: widget.icon),
    );
  }
}
