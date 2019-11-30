import 'dart:async';
import 'dart:convert';
import 'package:contato_digital/models/contato.dart';

import 'package:contato_digital/utils/consts.dart';
import 'package:contato_digital/utils/util.dart';
import 'package:contato_digital/views/gridcontatorefresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

Future<List<Contato>> getListaContato() async {
   final response = await http.get(urlContatoList, headers: {"x-req": keyAccessRestFul});
   var obj = json.decode(response.body);
   var itens = new List<Contato>();

   if ( (obj[0] ==  null)) return itens;
  
   var itemsList = (obj as List).map((i) => Contato.fromMap(i)).toList(); 

   return itemsList;
}

Future fetchPostContato(BuildContext context, Contato contato) async {
  final response = await http.post(urlContatoCreate, headers: {
    "x-req": keyAccessRestFul
  }, body: {
    "nome": contato.nome,
    "endereco": contato.endereco.logradouro,
    "cidade": contato.endereco.localidade,
    "bairro": contato.endereco.bairro,
    "cep": contato.endereco.cep,
    "uf": contato.endereco.uf
  });

  var responseJson = jsonDecode(response.body);

  showToast(responseJson);
  await new Future.delayed(new Duration(seconds: 2));

  Navigator.push(context,
      MaterialPageRoute(builder: (context) => new SwipeToRefreshContato()));
}

Future deleteContato(BuildContext context, String id) async {  

  final response = await http.get(urlContatoDelete + "/$id",  headers: { "x-req" : keyAccessRestFul});
  showToast(response.body);
}