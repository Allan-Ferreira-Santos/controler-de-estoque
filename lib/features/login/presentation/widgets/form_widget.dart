import 'package:flutter/material.dart';
import 'package:controle_de_estoque/features/config/theme/colors.dart';
import 'package:controle_de_estoque/features/login/presentation/widgets/input_widget.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.4),
      child: const Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputWidget(
            labelText: "Email",
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            icon: Icon(
              Icons.alternate_email,
              color: ColorsApp.white,
            ),
          ),
          InputWidget(
            labelText: "Password",
            keyboardType: TextInputType.text,
            obscureText: true,
            icon: Icon(
              Icons.password,
              color: ColorsApp.white,
            ),
          ),
        ],
      )),
    );
  }
}
