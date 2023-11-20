import 'package:brasil_fields/brasil_fields.dart';
import 'package:calculadoraimc/app/controller/imc_controller.dart';
import 'package:calculadoraimc/app/widget/card_calculo_imc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _formKey = GlobalKey<FormState>();
  final _peso = TextEditingController();
  final _altura = TextEditingController();
  late String _imc = "";

  late final imcController = ImcController();

  calculateIMC() async {
    double peso = double.parse((_peso.text).replaceAll(',', '.'));
    double altura = double.parse((_altura.text).replaceAll(',', '.'));
    _imc = await imcController.calculateIMC(peso, altura);
    print("IMC ${_imc}");
  }

  salvarCalculo() async {
    double peso = double.parse((_peso.text).replaceAll(',', '.'));
    double altura = double.parse((_altura.text).replaceAll(',', '.'));
    await imcController.saveCalculos(peso, altura);
  }

  limparCampos() {
    _peso.text = '';
    _altura.text = '';
    _imc = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Calculadora IMC")),
          body: Obx(() =>
              ListView.builder(
                itemCount: imcController.listaCalculosImc.length,
                itemBuilder: (_, int index){
                  return CardCalculoImc(imcModel: imcController.listaCalculosImc[index]);
                },
              )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: AlertDialog(
                        title: const Text(
                            "Calculo IMC",
                            style: TextStyle(
                                color: Colors.indigo
                            ),
                        ),
                        content: Container(
                          padding: const EdgeInsets.all(4),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _peso,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Peso"
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    PesoInputFormatter()
                                  ],
                                  validator: (value){
                                    if (value!.isEmpty) {
                                      return "O campo peso não pode ser vázio!!";
                                    } else {
                                      String str = value.replaceAll(',', '.');
                                      double v = double.parse(str);
                                      if (v < 1) {
                                        return "O campo peso deve ser maior que 0!!!";
                                      }
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8,),
                                TextFormField(
                                  controller: _altura,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Altura"
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    AlturaInputFormatter()
                                  ],
                                  validator: (value){

                                    if (value!.isEmpty) {
                                      return "O campo altura não pode ser vázio!!";
                                    } else {
                                      String str = value.replaceAll(',', '.');
                                      double v = double.parse(str);
                                      if (v < 1) {
                                        return "O campo altura deve ser maior que 0!!!";
                                      }
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 22,),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _imc,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12,),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton.icon(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          calculateIMC();
                                        }
                                      },
                                      icon: const Icon(
                                          Icons.calculate_outlined,
                                          color: Colors.white,
                                      ),
                                      label: const Text(
                                          "Calcular",
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)
                                          )
                                        )
                                      ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          Row(
                            children: [
                              TextButton(
                                  onPressed: (){
                                    Navigator.pop(this.context);
                                    limparCampos();
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.close),
                                      SizedBox(width: 2,),
                                      Text(
                                        "Cancelar",
                                        style: TextStyle(
                                            color: Colors.indigo
                                        ),
                                      ),
                                    ]
                                  )
                              ),
                              TextButton(
                                onPressed: (){
                                  if (_formKey.currentState!.validate()) {
                                    salvarCalculo();
                                    Navigator.pop(this.context);
                                    limparCampos();
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.save),
                                    SizedBox(width: 2,),
                                    Text(
                                      "Salvar",
                                      style: TextStyle(
                                          color: Colors.indigo
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
              );
            },
            backgroundColor: Colors.indigo,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
    );
  }
}
