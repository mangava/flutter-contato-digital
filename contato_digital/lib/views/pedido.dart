import 'dart:convert';
import 'package:contato_digital/models/produto.dart';
import 'package:contato_digital/utils/componentes.dart';
import 'package:contato_digital/utils/mockJson.dart';
import 'package:contato_digital/utils/util.dart';
import 'package:contato_digital/views/tabelaEmbalagemPartialView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PedidoView extends StatefulWidget {
  @override
  _PedidoViewState createState() => _PedidoViewState();
}

class _PedidoViewState extends State<PedidoView>
    with SingleTickerProviderStateMixin {
  String _currentProduto;
  String _currentCliente;
  String _currentTransportadora;

  TextEditingController _precoController = new TextEditingController();
  TextEditingController _quantidadeController = new TextEditingController();
  TextEditingController _observacaoController = new TextEditingController();

  ScrollController _scrollController;
  TabController _tabController;
  int pagadorSelected = 0;

  final Map<int, Widget> cardpayments = <int, Widget>{
    0: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Text("Remetente")),
    1: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Text("Destinatário")),
    2: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Text("Cortesia")),
  };

  List<dynamic> _produtos;
  var _lstProdutoPedido = new List<DataRow>();

  void initState() {
    _produtos = gerarListaMockProdutos();
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 2);
  }

  gerarListaMockFornecedores() {
    var obj = json.decode(jsonProdutos);
    return (obj as List).toList();
  }

  gerarListaMockProdutos() {
    var obj = json.decode(jsonProdutos);
    return (obj as List).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  gerarListaMockClientes() {
    var obj = json.decode(jsonClientes);
    return (obj as List).toList();
  }

  void changedDropDownItemProduto(String selectedProduto) {
    setState(() {
      _currentProduto = selectedProduto;
      var pr = _produtos.firstWhere((w) => w['id'] == selectedProduto);
      _precoController.text = pr["preco"];
      _quantidadeController.text = "";
    });
  }

  void changedDropDownCliente(String selectedCliente) {
    setState(() {
      _currentCliente = selectedCliente;
    });
  }

  Widget opcaoPagador() {
    return Column(children: <Widget>[
      Text("Pagador", style: Theme.of(context).textTheme.body1),
      SizedBox(height: 5),
      CupertinoSegmentedControl<int>(
        children: cardpayments,
        onValueChanged: (int val) {
          setState(() {
            pagadorSelected = val;
          });
        },
        groupValue: pagadorSelected,
      )
    ]);
  }

  void changedDropDownTransportadora(String selectedTransportadora) {
    setState(() {
      _currentTransportadora = selectedTransportadora;
    });
  }

  _onclick(key) {
    setState(() {
      _lstProdutoPedido.removeWhere((f) => f.key == key);
    });
  }

  _dataRow() {
    setState(() {
      if (_quantidadeController.text.isEmpty || _currentProduto.isEmpty) {
        showToast("Preencha todos os campos");
        return;
      }

      var pr = _produtos.firstWhere((w) => w['id'] == _currentProduto);
      var _key = UniqueKey();
      var total = double.parse(_quantidadeController.text) *
          double.parse(pr["preco"].toString());
      _lstProdutoPedido.add(DataRow(
        key: _key,
        cells: [
          DataCell(IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              color: Colors.amber,
              tooltip: 'Adicionar ao pedido',
              onPressed: () {
                _onclick(_key);
              })),
          DataCell(Text(pr["nome"])),
          DataCell(Text(pr["preco"])),
          DataCell(Text(_quantidadeController.text)),
          DataCell(Text(total.toString())),
        ],
      ));
    });
  }

  _pageOne() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text("Cliente"),
              DropdownButton(
                  style: Theme.of(context).textTheme.body1,
                  items: gerarComboProduto(jsonClientes),
                  value: _currentCliente,
                  onChanged: changedDropDownCliente),
              SizedBox(height: 20),
              Text("Produto"),
              DropdownButton(
                  style: Theme.of(context).textTheme.body1,
                  items: gerarComboProduto(jsonProdutos),
                  value: _currentProduto,
                  onChanged: changedDropDownItemProduto),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                      child: CustomTextFormField(
                          hintText: "Preço",
                          controller: _precoController,
                          readOnly: true,
                          maxLength: 20),
                      flex: 1),
                  SizedBox(width: 60),
                  Expanded(
                      child: CustomTextFormField(
                          hintText: "Quantidade",
                          controller: _quantidadeController,
                          keyboardType: TextInputType.number,
                          maxLength: 20),
                      flex: 1),
                ],
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    child: Icon(Icons.add_circle_outline),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      _dataRow();
                    },
                  )),
              Offstage(
                  offstage: !(_lstProdutoPedido.length > 0),
                  child: DataTable(
                      columnSpacing: 10,
                      columns: [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('Produto')),
                        DataColumn(label: Text('Valor')),
                        DataColumn(label: Text('Qtd.')),
                        DataColumn(label: Text('Total'))
                      ],
                      rows: _lstProdutoPedido)), //
            ])));
  }

  _pageTwo() {
    return Column(children: <Widget>[
      Align(child: Text("Transportadora"), alignment: Alignment.centerLeft),
      Align(
          child: DropdownButton(
              items: gerarComboProduto(jsonTransportadores),
              style: Theme.of(context).textTheme.body1,
              value: _currentTransportadora,
              onChanged: changedDropDownTransportadora),
          alignment: Alignment.centerLeft),
      SizedBox(height: 20),
      opcaoPagador(),
      SizedBox(height: 20),
      tabelaTipoEmbalagemPedido(),
      SizedBox(height: 40),
      CustomTextFormField(
          controller: _observacaoController, hintText: "Observação")     
     
    ]);
  }

  void salvar() {
    if (_currentCliente == null ||
        _currentTransportadora == null ||
        _lstProdutoPedido.length == 0)
      showToast("É necessário preencher todos os campos");
    else {
      showToast("Pedido salvo com sucesso");
      Navigator.pushNamed(context, "/homeComerciante");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(persistentFooterButtons: <Widget>[IconButton(
              icon: new Icon(Icons.save),              
              onPressed: salvar,
              color: Colors.blue)],
        body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    expandedHeight: 100,
                    pinned: true,
                    forceElevated: boxIsScrolled,
                    floating: true,
                    bottom: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.confirmation_number),
                          text: "Venda",
                        ),
                        Tab(
                            icon: Icon(Icons.transfer_within_a_station),
                            text: "Entrega"),
                      ],
                    ))
              ];
            },
            body: TabBarView(controller: _tabController, children: <Widget>[
              _pageOne(),
              SingleChildScrollView(
                  child:
                      Padding(child: _pageTwo(), padding: EdgeInsets.all(15)))
            ])));
  }
}
