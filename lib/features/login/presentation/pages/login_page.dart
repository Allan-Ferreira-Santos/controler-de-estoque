import '../widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:controle_de_estoque/features/config/theme/colors.dart';
import 'package:controle_de_estoque/features/app/presentation/widgets/app_bar_widget.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 90, right: 20, left: 20),
      color: ColorsApp.primary,
      child: const Column(
        children: [AppBarWidget(title: "Seja bem-vindo"), FormWidget()],
      ),
    ));
  }
}
