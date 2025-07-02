
import 'package:flutter/material.dart';

void main() {
  runApp(JurosSardaApp());
}

class JurosSardaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juros Sarda',
      theme: ThemeData.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {'title': 'Juros Simples', 'icon': Icons.calculate, 'page': JurosSimplesPage()},
    {'title': 'Juros Compostos', 'icon': Icons.analytics, 'page': JurosCompostosPage()},
    {'title': 'Valor da Prestação', 'icon': Icons.attach_money, 'page': ValorPrestacaoPage()},
    {'title': 'Nº de Prestações', 'icon': Icons.format_list_numbered, 'page': NumeroPrestacoesPage()},
    {'title': 'Taxa de Juros', 'icon': Icons.percent, 'page': TaxaDeJurosPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: options.map((option) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => option['page']),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(option['icon'], size: 36, color: Colors.amber),
                        const SizedBox(height: 12),
                        Text(option['title'], textAlign: TextAlign.center),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JurosSimplesPage extends StatefulWidget {
  @override
  _JurosSimplesPageState createState() => _JurosSimplesPageState();
}

class _JurosSimplesPageState extends State<JurosSimplesPage> {
  final TextEditingController capitalController = TextEditingController();
  final TextEditingController taxaController = TextEditingController();
  final TextEditingController tempoController = TextEditingController();
  String resultado = "";

  void calcularJurosSimples() {
    double c = double.tryParse(capitalController.text) ?? 0;
    double i = double.tryParse(taxaController.text) ?? 0;
    double t = double.tryParse(tempoController.text) ?? 0;

    double juros = c * (i / 100) * t;
    double montante = c + juros;

    setState(() {
      resultado = "Juros: R\$ ${juros.toStringAsFixed(2)}\nMontante: R\$ ${montante.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildFormPage(
      context,
      "Juros Simples",
      [capitalController, taxaController, tempoController],
      ["Capital (R\$)", "Taxa de Juros (%)", "Tempo (meses)"],
      calcularJurosSimples,
      resultado,
    );
  }
}

class JurosCompostosPage extends StatefulWidget {
  @override
  _JurosCompostosPageState createState() => _JurosCompostosPageState();
}

class _JurosCompostosPageState extends State<JurosCompostosPage> {
  final TextEditingController capitalController = TextEditingController();
  final TextEditingController taxaController = TextEditingController();
  final TextEditingController tempoController = TextEditingController();
  String resultado = "";

  void calcularJurosCompostos() {
    double c = double.tryParse(capitalController.text) ?? 0;
    double i = double.tryParse(taxaController.text) ?? 0;
    double t = double.tryParse(tempoController.text) ?? 0;

    double montante = c * (pow((1 + (i / 100)), t));
    double juros = montante - c;

    setState(() {
      resultado = "Juros: R\$ ${juros.toStringAsFixed(2)}\nMontante: R\$ ${montante.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildFormPage(
      context,
      "Juros Compostos",
      [capitalController, taxaController, tempoController],
      ["Capital (R\$)", "Taxa de Juros (%)", "Tempo (meses)"],
      calcularJurosCompostos,
      resultado,
    );
  }
}

class ValorPrestacaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildPlaceholderPage(context, "Valor da Prestação (em breve)");
  }
}

class NumeroPrestacoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildPlaceholderPage(context, "Nº de Prestações (em breve)");
  }
}

class TaxaDeJurosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildPlaceholderPage(context, "Taxa de Juros (em breve)");
  }
}

Widget buildFormPage(
  BuildContext context,
  String title,
  List<TextEditingController> controllers,
  List<String> labels,
  VoidCallback onCalculate,
  String resultado,
) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          for (int i = 0; i < controllers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: controllers[i],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: labels[i],
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ElevatedButton(
            onPressed: onCalculate,
            child: Text("Calcular"),
          ),
          const SizedBox(height: 20),
          Text(
            resultado,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    ),
  );
}

Widget buildPlaceholderPage(BuildContext context, String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text("Em desenvolvimento", style: TextStyle(fontSize: 18))),
  );
}

import 'dart:math';
