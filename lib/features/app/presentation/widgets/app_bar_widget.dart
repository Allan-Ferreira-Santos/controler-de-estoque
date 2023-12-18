import 'package:flutter/material.dart';
import 'package:controle_de_estoque/features/config/theme/fonts.dart';
import 'package:controle_de_estoque/features/config/theme/colors.dart';

class AppBarWidget extends StatelessWidget {
  final String title;

  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsApp.primary,
      elevation: 0,
      title: Text(
        title.toUpperCase(),
        style: FontsApp.heading1.copyWith(
          letterSpacing: 3
        ),

      ),
    );
  }
}
