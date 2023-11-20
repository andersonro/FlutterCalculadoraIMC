import 'dart:ffi';

import 'package:get/get.dart';

class ImcModel {
  double _peso = 0.0;
  double _altura = 0.0;
  String _imc = "";
  DateTime _dhCadastro = DateTime.now();

  ImcModel();

  double get peso => _peso;
  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;
  set altura(double altura) {
    _altura = altura;
  }

  DateTime get dhCadastro => _dhCadastro;

  String get img => _imc;
  set imc(String imc) {
    _imc = imc;
  }

  double _calculaIMC() {
    if (peso < 1) {
      throw ArgumentError("O peso não pode ser zero!");
    }
    if (altura == 0) {
      throw ArgumentError("A altura não pode ser zero!");
    }
    return peso / (altura * altura);
  }

  String retornaIMC(){
    var t = "";
    var imc = _calculaIMC();
    var ds_imc = imc.toStringAsFixed(2);
    if (imc < 16) {
      t = "Magreza grave";
    } else if (imc >=16 && imc < 17) {
      t = "Magreza moderada";
    } else if (imc >=17 && imc < 18.5) {
      t = "Magreza leve";
    } else if (imc >=18.5 && imc < 25) {
      t = "Saudável";
    } else if (imc >=25 && imc < 30) {
      t = "Sobrepeso";
    } else if (imc >=30 && imc < 35) {
      t = "Obesidade Grau I";
    } else if (imc >=35 && imc < 40) {
      t = "Obesidade Grau II";
    } else {
      t = "Obesidade Grau III";
    }
    return "$ds_imc $t";
  }

}