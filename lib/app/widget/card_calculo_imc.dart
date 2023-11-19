import 'package:flutter/material.dart';

class CardCalculoImc extends StatelessWidget {
  const CardCalculoImc({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.white70,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Data do calculo: 19/11/2023 08:00:00"),
            Text("Altura: 1,69"),
            Text("Peso: 85"),
            Text("IMC: XXXXXXX"),
          ],
        ),
      ),
    );
  }
}
