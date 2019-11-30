class Endereco {   
   final String cep;
   final String logradouro;   
   final String localidade;
   final String uf;
   final String bairro;
   final String complemento;
   
   Endereco({this.cep, this.logradouro, this.localidade, this.uf, this.bairro, this.complemento});

   factory Endereco.fromMap(Map<String, dynamic> json) => new Endereco(        
        cep: json["cep"],
        logradouro: json["logradouro"],
        localidade: json["localidade"],
        uf: json["uf"],
        bairro: json["bairro"],
        complemento: json["complemento"]        
      );

   Map<String, dynamic> toMap() => {        
        "cep": cep,
        "logradouro": logradouro,
        "localidade": localidade,
        "uf" : uf,
        "bairro": bairro,
        "complemento": complemento
      };
}