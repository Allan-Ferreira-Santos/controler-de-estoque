import 'package:flutter/material.dart';
import 'package:controle_de_estoque/features/config/theme/colors.dart';
import 'package:controle_de_estoque/features/app/presentation/widgets/app_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.primary,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBarWidget(title: "Seja Bem-Vindo"),
      ),
      body: Container(),
    );
  }
}
