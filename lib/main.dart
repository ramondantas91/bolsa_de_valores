import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'componentes.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //informa que não existe ações na bolsa de valores com o nome informado
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            content: Text('Ação Não Encontrada'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(color: Colors.red),),
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController txtAcao = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  double price = 0.00;
  String nomeCompany = "";

  Function validaAcao = ((value) {
    if (value.isEmpty) {
      return "Ação inválida";
    }
    return null;
  });

  clicouBotao() async {
    Uri url = Uri.parse(
        "https://api.hgbrasil.com/finance/stock_price?key=eaea954c&symbol=${txtAcao
            .text}");

    Response resposta = await get(url);
    Map bolsa = json.decode(resposta.body);
    if (bolsa["results"][txtAcao.text.toUpperCase()]["price"] != null) {
      setState(() {
        price = bolsa["results"][txtAcao.text.toUpperCase()]["price"];
        nomeCompany =
        bolsa["results"][txtAcao.text.toUpperCase()]["company_name"];
      });
    }
    else{
      _showDialog(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: keyForm,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: new BoxDecoration(color: Colors.indigo),
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/imgs/bolsa_valores.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Componentes.caixaDeTexto(
                  "Ação", "Informe a ação", txtAcao, validaAcao),
              Container(
                decoration: new BoxDecoration(color: Colors.black38),
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Componentes.rotulo(" "),
                    Componentes.rotulo(
                        "Valor da Ação: BRL " + price.toString() + ""),
                    Componentes.rotulo("Cia: " + nomeCompany),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white70,
                  ),
                  child: Text(
                    "Buscar",
                  ),
                  onPressed: clicouBotao,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}