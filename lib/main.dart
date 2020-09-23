import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _valorAlcool = TextEditingController();
  TextEditingController _valorGasolina = TextEditingController();
  String _resultado;

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _valorAlcool.text = '';
    _valorGasolina.text = '';
    setState(() {
      _resultado = 'Digite o valor sem ponto ou virgula';      
    });
  }

  AppBar bulidApp() {
    return AppBar(
      title: Text('Cálculo Combústivel'),
      backgroundColor: Colors.blueAccent,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              resetFields();
            })
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.lightGreen[100],
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), 
            child: buildForm()
        )
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Cálculo Combústivel'),
      backgroundColor: Colors.blue,      
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              resetFields();
            })
      ],
    );
  }

  Form buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildTextFormField(
                label: "Valor Alcool:",
                error: "Insira o valor",
                controller: _valorAlcool),
            buildTextFormField(
                label: "Valor Gasolina:",
                error: "Insira o valor",
                controller: _valorGasolina),
            buildTextResult(),
            buildCalculaButton(),
          ],
        ));
  }

  Form buildFormulario() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildTextFormField(
                label: "Valor Alcool:",
                error: "Insira o valor",
                controller: _valorAlcool),
            buildTextFormField(
                label: "Valor Gasolina:",
                error: "Insira o valor",
                controller: _valorGasolina),
            buildTextResult(),
            buildCalculaButton(),
          ],
        ));
  }

  void calculoComb() {
    double alcool = double.parse(_valorAlcool.text);
    double gasolina = double.parse(_valorGasolina.text);
    double resul = alcool / gasolina;
    setState(() {
      _resultado = "Resultado=${resul.toStringAsPrecision(2)}\n";
      if (resul > 0.7)
        _resultado += "Abasteça com Gasolina";
      else
        _resultado += "Abasteça com Alcool";
    });
  }

  Widget buildCalculaButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculoComb();
          }
        },
        child: Text(
          "Calcular",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.brown,
      ),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Text(
        _resultado,
        textAlign: TextAlign.center,
      ),
    );
  }

  TextFormField buildTextFormField(
      {TextEditingController controller, 
      String error, 
      String label}
    ) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}
