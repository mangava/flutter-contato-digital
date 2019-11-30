
import 'package:contato_digital/views/gridcontatorefresh.dart';
import 'package:contato_digital/views/pedido.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeComerciante extends StatefulWidget {
  @override
  _HomeComercianteState createState() => _HomeComercianteState();
}

class _HomeComercianteState extends State<HomeComerciante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
       floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.account_box),
            onPressed: () {
               Navigator.pushReplacementNamed(context, '/login');
              
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginWidget()),
              // );
            }),         
            appBar: new AppBar(
              title: new Text(
                "Visão de Comerciante",
                style: new TextStyle(color: Colors.white),
              ),
            ),
          body: Column(children: <Widget>[
      SizedBox(height: 100),  
      Align(child:     
      RaisedButton(textColor: Colors.white, color: Colors.blue, child: Text("Pedidos"), onPressed: () {
         Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_context) => PedidoView()),
                          ModalRoute.withName("/homeComerciante")
                          );
      })),
      
          RaisedButton(textColor: Colors.white, color: Colors.blue,
              child: Text("Contatos"),
              onPressed: () {               

 Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_context) => SwipeToRefreshContato()),
                          ModalRoute.withName("/homeComerciante")
                          );
                

              })
    ]));
  }
}
