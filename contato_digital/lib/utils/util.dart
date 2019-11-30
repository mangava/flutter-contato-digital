import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'consts.dart';

void showToast(String msg, { ToastGravity toastGravity}) {

Fluttertoast.showToast(
        msg: msg,        
        toastLength: Toast.LENGTH_SHORT,        
        gravity: toastGravity ?? ToastGravity.CENTER,
        timeInSecForIos: 1,    
        textColor: Colors.white,            
        backgroundColor: Colors.lightBlueAccent[100],
        fontSize: 16.0);
}

Future<ConfirmAction> mensagemConfirmacao(BuildContext context, String title, String msg) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(msg),
            ],
          ),
        ),
        actions: <Widget>[          
          FlatButton(
            child: Text('Não'),   
            textColor: Colors.blue,
            color: Colors.blueGrey[50],
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: Text('Sim'),   
            textColor: Colors.red,         
            color: Colors.blueAccent[300],
            onPressed:() {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            }
          )
        ],
      );
    },
  );
}