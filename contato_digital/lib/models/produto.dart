import 'dart:convert';

import 'package:flutter/material.dart';

class Produto {
  String id;
  String nome;
  double preco;

  Produto({this.id, this.nome, this.preco});

  factory Produto.fromMap(Map<String, dynamic> json) {
    return Produto(
      id: json["id"] as String,
      nome: json["nome"] as String,
      preco: double.parse(json["preco"].toString()),
    );
  }

  Map<String, dynamic> toMap() => {"id": id, "nome": nome, "preco": preco};
}

List<DropdownMenuItem<String>> gerarComboProduto(String dados) {
  List<DropdownMenuItem<String>> list = new List();

  var rest = json.decode(dados).cast<Map<String, dynamic>>();
  for (var i in rest) {
    list.add(new DropdownMenuItem(value: i["id"], child: new Text(i["nome"])));
  }

  return list;
}

// List<DropdownMenuItem<String>> gerarComboFromArray(List<String> itens) {

//         List<DropdownMenuItem<String>> list= new List();

//         for(var i =0; i < itens.length; i++) {
//           list.add(new DropdownMenuItem(
//              value:i.toString(),
//              child:new Text(itens[i])
//           ));
//         }
//         return list;
// }
