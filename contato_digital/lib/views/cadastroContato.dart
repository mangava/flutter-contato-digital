import 'package:contato_digital/models/contato.dart';
import 'package:contato_digital/models/endereco.dart';
import 'package:contato_digital/utils/componentes.dart';
//import 'package:contato_digital/utils/consts.dart';
import 'package:contato_digital/utils/util.dart';
import 'package:contato_digital/views/gridcontatorefresh.dart';
import 'package:contato_digital/webservices/wsCep.dart';
import 'package:contato_digital/webservices/wsContato.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastroContatoPage extends StatefulWidget {
  CadastroContatoPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CadastroContatoHomePageState createState() =>
      _CadastroContatoHomePageState();
}

class _CadastroContatoHomePageState extends State<CadastroContatoPage> {
  /*_drawerHeader() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Drawer(
            //  elevation: 5.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/gridContato');
                    }),
                ListTile(
                    leading: Icon(Icons.pie_chart),
                    title: Text('Dashboard'),
                    onTap: () {
                      showToast(notImplemet);
                    })
              ],
            ),
          );
        });
  }*/

  DateTime currentBackPressTime = DateTime.now();
  TextEditingController _cep = new TextEditingController();
  TextEditingController _nome = new TextEditingController();
  TextEditingController _endereco = new TextEditingController();
  TextEditingController _bairro = new TextEditingController();

  String _cidade = "";
  String _uf = "";
  bool _visibility = false;
  final _formKey = GlobalKey<FormState>();

  void _consultarCep() async {
    if (_cep.text.length < 8) {
      _visibility = false;
      showToast("cep inválido");
      return;
    }

    await wsConsultaCep(_cep.text).then((res) {
      setState(() {
        _endereco.text = res.logradouro;
        _bairro.text = res.bairro;
        _cidade = res.localidade;
        _uf = res.uf;

        if (res.localidade == null) {
          _visibility = false;
          showToast("Cep não encontrado");
        } else {
          _visibility = true;
        }
      });
    }).catchError((er) {
      showToast(er.toString());
    });
  }

  Future<bool> _onBackPressed() async {
    // DateTime now = DateTime.now();
    // if (now.difference(currentBackPressTime) > Duration(seconds: 3)) {
    //   currentBackPressTime = now;
    //   showToast("Pressione novamente para sair");
    //   return Future.value(false);
    // }
    //return Future.value(true);
    //return Future.value(false);

   

Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_context) => SwipeToRefreshContato()),
                          ModalRoute.withName("/homeComerciante")
                          );
   

    return Future.value(false);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _visibility = false;
    });
  }

  Widget bodyform(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Column(
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: CustomTextFormField(
                      controller: _nome,
                      keyboardType: TextInputType.text,
                      hintText: "Nome",
                      maxLength: 100)),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Row(children: <Widget>[
                    Expanded(
                        child: CustomTextFormField(
                            controller: _cep,
                            keyboardType: TextInputType.number,
                            hintText: "Cep",
                            maxLength: 8),
                        flex: 5),
                    Spacer(flex: 1),
                    Flexible(
                        child: FlatButton(
                            textColor: Colors.white,
                            child: Icon(Icons.search),
                            color: Colors.blueAccent,
                            onPressed: _consultarCep),
                        flex: 3)
                  ]))),
              Offstage(
                  offstage: !_visibility,
                  child: Column(children: <Widget>[
                    CustomTextFormField(
                        hintText: "Endereço",
                        controller: _endereco,
                        maxLength: 100,
                        isVisible: _visibility),
                    SizedBox(height: 30),
                    CustomTextFormField(
                        hintText: "Bairro",
                        controller: _bairro,
                        maxLength: 100,
                        isVisible: _visibility),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Cidade: $_cidade')),
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Estado: $_uf')),
                  ])),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            floatingActionButton: new FloatingActionButton(
                backgroundColor: Colors.blueGrey,
                mini: true,
                child: new Icon(Icons.save),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var contato = new Contato(
                        nome: _nome.text,
                        endereco: new Endereco(
                            logradouro: _endereco.text,
                            localidade: _cidade,
                            cep: _cep.text,
                            bairro: _bairro.text,
                            uf: _uf));

                    await fetchPostContato(context, contato);
                  }
                }),
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(widget.title),
            ),
            body: SingleChildScrollView(
                child: Center(
                    child: Form(key: _formKey, child: bodyform(context)))),
            // bottomNavigationBar: BottomAppBar(
            //     shape: CircularNotchedRectangle(),
            //     notchMargin: 6.0,
            //     child: new Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10.0),
            //         decoration: new BoxDecoration(color: Colors.blueAccent),
            //         child: Row(
            //           mainAxisSize: MainAxisSize.max,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //             IconButton(
            //               icon: Icon(Icons.menu),
            //               onPressed: _drawerHeader,
            //             )
            //           ],
            //         )))
                    ));
  }
}
