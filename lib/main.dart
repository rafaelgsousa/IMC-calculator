import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String textInfo = 'Informe seus dados';

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      textInfo = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!
    });
  }

  void calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight/(height * height);
      if (imc < 18.6){
        textInfo = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9){
        textInfo = 'Peso ideal (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9){
        textInfo = 'Levemente acima do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9){
        textInfo = 'Obesidade grau I (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 34.9 && imc <= 39.9){
        textInfo = 'Obesidade grau II (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 40){
        textInfo = 'Obesidade grau II (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC Calculator'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: _resetFields,
              icon: const Icon(Icons.refresh)
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_2_outlined,
                size: 120,
                color: Colors.green
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira seu peso';
                  }
                  return '';
                },
              ),
              TextFormField(
                controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira sua altura';
                  }
                    return '';
                  },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          calculate();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Calcular',
                        style: TextStyle(fontSize: 25),
                      ),
                  ),
                ),
              ),
              Text(
                textInfo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}