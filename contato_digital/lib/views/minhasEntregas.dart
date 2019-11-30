import 'dart:convert';

import 'package:contato_digital/utils/mockJson.dart';
import 'package:contato_digital/views/detalhePedido.dart';
import 'package:flutter/material.dart';

class MinhasEntregasView extends StatefulWidget {
  @override
  _MinhasEntregasViewState createState() => _MinhasEntregasViewState();
}

class _MinhasEntregasViewState extends State<MinhasEntregasView> {
  gerarListaMockPedidos() {
    var obj = json.decode(jsonPedidos);

    return (obj as List)
        .map((f) => (new DataRow(cells: [
              DataCell(IconButton(
                  icon: Icon(Icons.shop_two),
                  color: Colors.green,
                  tooltip: 'Adicionar ao pedido',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                new DetalhePedidoView(id: f["id"].toString())));
                  })),
              DataCell(Text(f["nome"])),
              DataCell(Text(f["datacompra"])),
              DataCell(Text(f["prazo"]))
            ])))
        .toList();
  }

  tabelaPedidos() {
    return DataTable(
        columnSpacing: 8,
        columns: [
          DataColumn(label: Text('')),
          DataColumn(label: Text('Nome')),
          DataColumn(label: Text('Data\nCompra')),
          DataColumn(label: Text('Prazo'))
        ],
        rows: gerarListaMockPedidos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Minhas Entregas"),
        ),
        body: SingleChildScrollView(child: Container(child: tabelaPedidos())));
  }
}
