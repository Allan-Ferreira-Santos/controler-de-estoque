import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:controle_de_estoque/features/home/presentation/pages/home_page.dart';
import 'package:controle_de_estoque/features/app/presentation/module/app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const HomePage()));
}
