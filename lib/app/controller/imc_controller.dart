import 'package:calculadoraimc/app/model/imc_model.dart';
import 'package:get/get.dart';

class ImcController extends GetxController {

  late ImcModel imcModel = ImcModel();

  final _listaCalculosImc = [].obs;
  RxList get listaCalculosImc => _listaCalculosImc;

  final _imc = "".obs;
  Rx<String> get getImc => _imc;

  Future<String> calculateIMC(double peso, double altura) async {
    imcModel.peso = peso;
    imcModel.altura = altura;
    return 'Resultado: ${imcModel.retornaIMC()}';
  }

  Future loadCalculos() async {
    listaCalculosImc.reversed.toList();
    listaCalculosImc.refresh();
  }

  Future saveCalculos(double peso, double altura) async {
    ImcModel imcModel = ImcModel();
    imcModel.peso = peso;
    imcModel.altura = altura;
    imcModel.imc = await calculateIMC(peso, altura);
    listaCalculosImc.value.add(imcModel);
    listaCalculosImc.value = listaCalculosImc.reversed.toList();
    listaCalculosImc.refresh();
  }

}