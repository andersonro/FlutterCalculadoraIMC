import 'package:brasil_fields/brasil_fields.dart';
import 'package:calculadoraimc/app/model/imc_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardCalculoImc extends StatelessWidget {

  const CardCalculoImc({super.key, required this.imcModel,});
  final ImcModel imcModel;

  @override
  Widget build(BuildContext context) {
    String d = DateFormat('hh/MM/yyyy HH:mm:ss').format(imcModel.dhCadastro);

    return Card(
      color: Colors.white,
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
                "Data do calculo: ${d}",
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
            Text("Altura: ${imcModel.altura}"),
            Text("Peso: ${imcModel.peso}"),
            Text("IMC: ${imcModel.img}"),
          ],
        ),
      ),
    );
  }
}
