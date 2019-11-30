import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contato_digital/splashscreen.dart';
import 'package:contato_digital/views/cadastroContato.dart';
import 'package:contato_digital/views/entregasDisponiveis.dart';
import 'package:contato_digital/views/gridcontatorefresh.dart';
import 'package:contato_digital/views/homeComerciante.dart';
import 'package:contato_digital/views/homeTransportador.dart';
import 'package:contato_digital/views/login.dart';
import 'package:contato_digital/views/minhasEntregas.dart';
import 'package:contato_digital/views/pedido.dart';
import 'package:flutter/material.dart';

import 'blocs/LoginController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
     return BlocProvider(        
        blocs: [
          Bloc((i) => LoginController()),
        ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contatos Digitais',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //initialRoute: '/home',
        home: new SplashScreen(),
        routes: {
          '/login': (context) => new LoginWidget(),
          '/cadastroContato': (context) => new  CadastroContatoPage(title: 'Contatos Digitais'),
          '/gridContato': (context) => new SwipeToRefreshContato(),
          '/homeComerciante':(context) => new HomeComerciante(),
          '/homeTransportador':(context) => new HomeTransportador(),
          '/pedidoView':(context) => new PedidoView(),
          '/entregasDisponiveis': (context) => new EntregaDisponivelView(),
          '/minhasEntregas':(context)=> new MinhasEntregasView()
        }));
  }
}