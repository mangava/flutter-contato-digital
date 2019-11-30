import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contato_digital/blocs/LoginController.dart';
import 'package:contato_digital/models/usuario.dart';
import 'package:contato_digital/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String _versionName;
  String _versionCode;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final LoginController _loginController =
      BlocProvider.getBloc<LoginController>();
  var _emailController = new TextEditingController();

  int gradientColor1 = 0xFF4285F4;
  int gradientColor2 = 0x0037BAF5;
  bool _obscureText = true;

  @override
  void initState() {
    //  PackageInfo.fromPlatform().then((p) {
    //    if (mounted) {
    //    _versionName = p.appName;
    //    _versionCode = p.version;
    //    }
    //  });

    //SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  _onPressed() {
    var usuario = new Usuario(
        nome: "User", email: _emailController.text ?? "email@email.com.br");
    _loginController.inLogin.add(usuario);

    if (_emailController.text == 'c')
      Navigator.pushReplacementNamed(context, '/homeComerciante');
    else if (_emailController.text == 't')
      Navigator.pushReplacementNamed(context, '/homeTransportador');
    else
      showToast("Digite c para comerciante ou t para transportador");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Color(gradientColor2), Color(gradientColor1)],
                )),
                child: FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.hasData ||
                          snap.connectionState == ConnectionState.done) {
                        _versionCode = snap.data.version;
                        _versionName = snap.data.appName;
                        return Text("$_versionName: $_versionCode",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.blue, fontSize: 10));
                      } else
                        return Container(child: Text(""));
                    }))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _onPressed();
          },
          child: Icon(Icons.arrow_forward_ios),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width, //mesma largura da tela
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(gradientColor1), Color(gradientColor2)],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.verified_user,
                          size: 90, color: Colors.white)),
                  Spacer(),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 32, bottom: 32),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 18),
                          )))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.redAccent,
                          icon: Icon(
                            Icons.email,
                            color: Colors.blueAccent,
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: EdgeInsets.only(top: 32),
                    height: 50,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.blueAccent,
                          ),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                semanticLabel: _obscureText
                                    ? 'show password'
                                    : 'hide password',
                                color: Colors.blueAccent,
                              )),
                        )),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, right: 32),
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      )),
                ],
              ),
            ),
          ]),
        )));
  }
}
