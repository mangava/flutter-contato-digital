import 'package:contato_digital/models/contato.dart';
import 'package:contato_digital/webservices/wsClassificaContato.dart';
import 'package:flutter/material.dart';
import 'package:contato_digital/models/classificaContato.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalheContato extends StatefulWidget {
  final Contato contato; 

  DetalheContato({this.contato});

  @override
  _DetalheContatoState createState() => _DetalheContatoState();
}

class _DetalheContatoState extends State<DetalheContato> {
  var rating = 0.0;  

  @override
  void initState() {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();    
  }

 //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Detalhe Contatos"),
        ),
        body: SingleChildScrollView(child: Container(
            padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsetsDirectional.only(
                start: 20.0, top: 20.0, bottom: 60.0, end: 20.0),
            child:  Column(
              children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(children: [
                    new Align(
                        alignment: Alignment.centerLeft, child: Text("Código", style: TextStyle(fontWeight: FontWeight.bold))),
                    new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(widget.contato.id)),

                  ])),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(children: [
                    new Align(
                        alignment: Alignment.centerLeft, child: Text("Nome", style: TextStyle(fontWeight: FontWeight.bold))),
                    new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(widget.contato.nome)),

                  ])), 
                  Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(children: [
                    new Align(
                        alignment: Alignment.centerLeft, child: Text("Telefone", style: TextStyle(fontWeight: FontWeight.bold))),
                    new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text("(14) 99123-9875")),

                  ])),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(children: [
                    new Align(
                        alignment: Alignment.centerLeft, child: Text("Endereço", style: TextStyle(fontWeight: FontWeight.bold))),
                    new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(widget.contato.endereco.logradouro)),

                  ])),
                  Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(children: [
                    new Align(
                        alignment: Alignment.centerLeft, child: Text("Bairro", style: TextStyle(fontWeight: FontWeight.bold))),
                    new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(widget.contato.endereco.bairro)),

                  ])),
                   Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(children: [
                    new Align(
                        alignment: Alignment.centerLeft, child: Text("Cep", style: TextStyle(fontWeight: FontWeight.bold))),
                    new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(widget.contato.endereco.cep)),

                  ])),
                    Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(children: [
                    new Align(
                        alignment: Alignment.centerLeft, child: Text("Complemento", style: TextStyle(fontWeight: FontWeight.bold))),
                    new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(widget.contato.endereco.complemento ?? "")),

                  ])),
                    Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(children: [
                    new Align(
                        alignment: Alignment.centerLeft, child: Text("Cidade", style: TextStyle(fontWeight: FontWeight.bold))),
                    new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(widget.contato.endereco.localidade + "/" + widget.contato.endereco.uf)),

                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothStarRating(
                      allowHalfRating: true,
                      onRatingChanged: (v) {
                        setState(() {
                          rating = v;
                        });
                      },
                      starCount: 5,
                      rating: rating,
                      size: 30.0,
                      color: Colors.blueAccent[100],
                      borderColor: Colors.blueAccent[200],
                      spacing: 4.0)
                ],
              ),
              SizedBox(height: 30),
              new InkWell(
                highlightColor: Colors.blue,
              child: new Text('clique para visualizar o endereço no mapa'),
              onTap: () => launch('https://www.google.com/maps/place/Rua+An%C3%ADsio+do+Prado,+Ja%C3%BA+-+SP,+17206-410/@-22.2709472,-48.5681695,17z/data=!3m1!4b1!4m5!3m4!1s0x94b8a87311d55769:0x39266ceef605503!8m2!3d-22.2709522!4d-48.5659808')
          ),
            Divider(height: 50),            
                      FlatButton(child: Text('Rankear'), color: Colors.blueAccent, textColor: Colors.white, onPressed: () async {
                          var classifica = new ClassificacaoContato(
                            contatoId: int.parse(widget.contato.id),
                            valor : rating
                          );

                          await fetchPostContato(context,classifica);
                                                     
                      }),
                     
        ]))));
  }
}