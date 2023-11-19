import 'package:calculadoraimc/app/widget/card_calculo_imc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Calculadora IMC")),
          body: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, int index){
                return CardCalculoImc();
              },
          ),
        ),
    );
  }
}
