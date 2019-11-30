import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contato_digital/blocs/LoginController.dart';
import 'package:contato_digital/utils/util.dart';
import 'package:contato_digital/utils/consts.dart';
import 'package:contato_digital/views/cadastroContato.dart';
import 'package:contato_digital/views/detalheContato.dart';
import 'package:contato_digital/webservices/wscontato.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:contato_digital/models/contato.dart';
import 'package:flutter/services.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SwipeToRefreshContato extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwipeToRefreshState();
  }
}

class _SwipeToRefreshState extends State<SwipeToRefreshContato> {
  final LoginController _loginController =
      BlocProvider.getBloc<LoginController>();  
 

  _drawerHeader() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Drawer(
            //  elevation: 5.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                StreamBuilder(
                    stream: _loginController.outLogin,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                     

                      return Container(
                          child: UserAccountsDrawerHeader(
                              accountEmail: Text(snapshot.data.email),
                              accountName: Text(snapshot.data.nome),
                              currentAccountPicture: DecoratedBox(
                                  decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new AssetImage(
                                      'assets/images/logosplash.png'),
                                ),
                              ))));
                    }),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                      Navigator.of(context).pushReplacementNamed('/homeComerciante');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text('Configurações'),
                  onTap: () {
                    //Navigator.of(context).pushReplacementNamed('/detalheContato');
                    // Navigator.pop(context);
                    //Navigator.of(context).pushReplacementNamed('/gps');
                  },
                ),
                Divider(height: 2.0),
                ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Sair'),
                    onTap: () async {
                      await mensagemConfirmacao(
                              context, "Aviso", "Deseja sair do aplicativo?")
                          .then((result) {
                        result == ConfirmAction.ACCEPT
                            ? SystemNavigator.pop()
                            : Navigator.canPop(context);
                      });
                    })
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var contatos = <Contato>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Lista de Contatos"),
        ),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: _buildBills()),
        floatingActionButton: new FloatingActionButton(
            backgroundColor: Colors.blue,
            child: new Icon(Icons.add),
            onPressed: () {
             

Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_context) =>  new CadastroContatoPage(title: 'Contatos Digitais')),
                          ModalRoute.withName("/homeComerciante")
                          );
     

            }),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 6.0,
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: new BoxDecoration(color: Colors.blue),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.view_headline),
                    onPressed: _drawerHeader,
                  )
                ],
              ),
            )));
  }

  Widget _buildRow(Contato contato) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
        child: Column(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(contato.nome),
            SizedBox(height: 5),
            Text("Cidade:${contato.endereco.localidade}"),
            SizedBox(height: 5),
            Row(children: <Widget>[Expanded(flex: 1,child:Text("Média de Avaliação")), Expanded(child:SmoothStarRating(
                      allowHalfRating: true,
                      starCount: 5,
                      rating: contato.valorRaking,
                      size: 10.0,
                      color: Colors.blueAccent[100],
                      borderColor: Colors.blueAccent[200],
                      spacing: 0.0))])
          ],
        ));
  }

  Widget _buildBills() {
    return new Container(
        child: new ListView.builder(
            padding: const EdgeInsets.all(6.0),
            itemCount: contatos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  background: stackBehindDismiss(),
                  key: ObjectKey(contatos[index]),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                maintainState: false,
                                builder: (context) =>
                                    DetalheContato(contato: contatos[index]),
                                fullscreenDialog: true));
                      },
                      child: SizedBox(
                          width: double.infinity,
                          child: new Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                              child: Card(child: _buildRow(contatos[index]))))),
                  onDismissed: (direction) async {
                    await deleteContato(context, contatos[index].id);
                    setState(() {
                      contatos.removeAt(index);
                    });
                  });
            }));
  }

  Future<Null> _refresh() async {
    return await getListaContato().then((_lista) {
      if (_lista.isEmpty) {
        showToast("dados não encontrados");
      } else {
        setState(() => contatos = _lista);
      }
    }).catchError((error) {
      showToast(error.toString());
    });
  }

  Widget stackBehindDismiss() {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.red[100],
          borderRadius: new BorderRadius.all(const Radius.circular(10.0))),
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerRight,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
