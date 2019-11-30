import 'endereco.dart';

class Contato {
  String id;
  String nome;  
  Endereco endereco;
  double valorRaking;

  Contato({this.id, this.nome, this.endereco, this.valorRaking});

  factory Contato.fromMap(Map<String, dynamic> json) {
    return Contato(
        id: json['id'] as String,
        nome: json['nome'] as String,
        valorRaking: double.parse(json["valorRanking"].toString()),
        endereco: new Endereco(
            logradouro: json["endereco"] as String,
            localidade: json["cidade"] as String,
            cep: json["cep"] as String,
            uf: json["uf"] as String,
            bairro: json["bairro"] as String                        
            ));
  }  

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "cep": endereco.cep,
        "logradouro": endereco.logradouro,
        "localidade": endereco.localidade,
        "uf": endereco.uf,
        "bairro": endereco.bairro
      };
}