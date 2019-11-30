import 'dart:convert';

import 'package:contato_digital/utils/mockJson.dart';
import 'package:contato_digital/views/tabelaEmbalagemPartialView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetalhePedidoView extends StatefulWidget {
  final String id;

  DetalhePedidoView({this.id});

  @override
  _DetalhePedidoViewState createState() => _DetalhePedidoViewState();
}

class _DetalhePedidoViewState extends State<DetalhePedidoView> {
  var _detalhePedido;

  @override
  void initState() {
    super.initState();
    _detalhePedido = (json.decode(jsonPedidos) as List)
        .firstWhere((f) => f["id"] == widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text("Detalhe Pedido")),
        body: SingleChildScrollView(
            child: Card(
                child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Código",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.id),
                          SizedBox(height: 10),
                          Text("Comprador",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_detalhePedido["nome"]),
                          SizedBox(height: 10),
                          Text("Data compra",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_detalhePedido["datacompra"]),
                          SizedBox(height: 10),
                          Text("Prazo",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_detalhePedido["prazo"]),
                          SizedBox(height: 10),
                          Text("Rua",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_detalhePedido["rua"]),
                          SizedBox(height: 10),
                          Text("Cep",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_detalhePedido["cep"]),
                          SizedBox(height: 10),
                          Text("Cidade",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_detalhePedido["cidade"] +
                              "/" +
                              _detalhePedido["uf"]),
                          tabelaTipoEmbalagemDetalhePedido()
                        ])))));
  }
}
