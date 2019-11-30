 import 'package:flutter/material.dart';

tabelaTipoEmbalagemPedido() {
    return DataTable(columnSpacing: 8, columns: [
      DataColumn(label: Text('Tipo de Caixa')),
      DataColumn(label: Text('Dimensões')),
      DataColumn(label: Text('Qtd.'))
    ], rows: [
      DataRow(selected: true, onSelectChanged: (c) {}, cells: [
        DataCell(Text("Caixa de Encomenda Flex")),
        DataCell(Text("26 x 21 x 1 a 6")),
        DataCell(Text(""), showEditIcon: true, placeholder: false),
      ]),
      DataRow(
          selected: false,
          onSelectChanged: (c) {},
          key: UniqueKey(),
          cells: [
            DataCell(Text("Caixa de encomenda 1")),
            DataCell(Text("18 x 13,5 x 9")),
            DataCell(Text(""), showEditIcon: true, placeholder: false),
          ]),
      DataRow(
          selected: false,
          onSelectChanged: (c) {},
          key: UniqueKey(),
          cells: [
            DataCell(Text("Caixa de Encomenda 2")),
            DataCell(Text("27 x 18 x 9")),
            DataCell(Text(""), showEditIcon: true, placeholder: false),
          ]),
      DataRow(
          selected: true,
          onSelectChanged: (c) {},
          key: UniqueKey(),
          cells: [
            DataCell(Text("Caixa de Encomenda 3")),
            DataCell(Text("27 X 22,5 X 13,5")),
            DataCell(Text(""), showEditIcon: true, placeholder: false),
          ])
    ]);
  }

  tabelaTipoEmbalagemDetalhePedido() {
    return DataTable(columnSpacing: 8, columns: [
      DataColumn(label: Text('Tipo de Caixa')),
      DataColumn(label: Text('Dimensões')),
      DataColumn(label: Text('Qtd.'))
    ], rows: [
      DataRow(cells: [
        DataCell(Text("Caixa de Encomenda Flex")),
        DataCell(Text("26 x 21 x 1 a 6")),
        DataCell(Text("2"), placeholder: false),
      ]),
      DataRow(
          key: UniqueKey(),
          cells: [
            DataCell(Text("Caixa de encomenda 1")),
            DataCell(Text("18 x 13,5 x 9")),
            DataCell(Text("1"), placeholder: false),
          ]),      
      DataRow(
          key: UniqueKey(),
          cells: [
            DataCell(Text("Caixa de Encomenda 3")),
            DataCell(Text("27 X 22,5 X 13,5")),
            DataCell(Text("3"), placeholder: false),
          ])
    ]);
  }