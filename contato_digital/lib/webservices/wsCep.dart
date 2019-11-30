import 'dart:async';
import 'dart:convert';
import 'package:contato_digital/models/endereco.dart';
import 'package:http/http.dart' as http;

Future<Endereco> wsConsultaCep(String cep) async {
  
  final response = await http.get('https://viacep.com.br/ws/$cep/json');      
  final responseJson  = json.decode(response.body);

  //await new Future.delayed(new Duration(seconds: 2));

  return Endereco.fromMap(responseJson);
}