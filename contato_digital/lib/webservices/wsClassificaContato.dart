import 'dart:async';
import 'dart:convert';
import 'package:contato_digital/models/classificaContato.dart';

import 'package:contato_digital/utils/consts.dart';
import 'package:contato_digital/utils/util.dart';
import 'package:contato_digital/views/gridcontatorefresh.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future fetchPostContato(BuildContext context, ClassificacaoContato contato) async {
  final response = await http.post(urlClassificaContatoCreate, headers: {
    "x-req": keyAccessRestFul
  }, body: {
    "contatoId": contato.contatoId.toString(),
    "valor": contato.valor.toString()
  });

  var responseJson = jsonDecode(response.body);

  showToast(responseJson);
  await new Future.delayed(new Duration(seconds: 2));

  Navigator.push(context,
      MaterialPageRoute(builder: (context) => new SwipeToRefreshContato()));
}