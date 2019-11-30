import 'package:contato_digital/views/entregasDisponiveis.dart';
import 'package:contato_digital/views/minhasEntregas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeTransportador extends StatefulWidget {
  @override
  _HomeTransportadorState createState() => _HomeTransportadorState();
}

class _HomeTransportadorState extends State<HomeTransportador> {
  @override
   Widget build(BuildContext context) {
    return new Scaffold(  
      floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.account_box),
            onPressed: () {
              
                Navigator.pushReplacementNamed(context, '/login');
            }),        
            appBar: new AppBar(
              title: new Text(
                "Visão de Transportador",
                style: new TextStyle(color: Colors.white),
              ),
            ),body: 
            Column(children: <Widget>[ SizedBox(height: 100),  Align(child:RaisedButton(textColor: Colors.white, color: Colors.blue, child:Text("Entregas Disponiveis"),
    onPressed: (){
       Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EntregaDisponivelView()),
                          ModalRoute.withName("/homeTransportador")
                          );

      //Navigator.push(context, MaterialPageRoute(builder: (context)))

    })),
    RaisedButton(textColor: Colors.white, color: Colors.blue, child:Text("    Minhas Entregas    "),
    onPressed: (){
       Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MinhasEntregasView()),
                          ModalRoute.withName("/homeTransportador")
                          );
    })
    ])
       
      
    );
  }
}