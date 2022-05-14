import 'dart:ui';

import 'package:flutter/material.dart';

class Componentes {

  static rotulo(String rotulo) {
    return Text(rotulo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),);
  }

  static caixaDeTexto(
      String rotulo, String dica, TextEditingController controlador, valicao, {bool obscure = false, bool numero = false}) {
    return TextFormField(
      controller: controlador,
      obscureText: obscure,
      validator: valicao,
      keyboardType: numero ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: rotulo,
        border: InputBorder.none,
        labelStyle: TextStyle(fontSize: 20, color: Colors.blue),
        hintText: dica,
        hintStyle: TextStyle(fontSize: 15, color: Colors.blue),
      ),
    );
  }

  // static botao(String _texto, Function _f) {
  //   return Container(
  //     child: RaisedButton(
  //       onPressed: _f,
  //       child: Text(
  //         _texto,
  //         style: TextStyle(color: Colors.blue, fontSize: 30.0),
  //       ),
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           side: const BorderSide(color: Colors.blue, width: 10)),
  //       color: Colors.black87.withOpacity(1),
  //       hoverColor: Colors.yellow.withOpacity(1),
  //     ),
  //   );
  // }
}