class ContatosModel {
  List<Contato> contatos = [];

  ContatosModel(this.contatos);

  ContatosModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <Contato>[];
      json['results'].forEach((v) {
        contatos.add(Contato.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = contatos.map((v) => v.toJson()).toList();
    return data;
  }
}

class Contato {
  String objectId = "";
  String imagem = "";
  String nome = "";
  String celular = "";
  String createdAt = "";
  String updatedAt = "";

  Contato(
    this.objectId,
    this.imagem,
    this.nome,
    this.celular,
    this.createdAt,
    this.updatedAt,
  );

  Contato.criar(
    this.imagem,
    this.nome,
    this.celular,
  );

  Contato.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    imagem = json['imagem'];
    nome = json['nome'];
    celular = json['celular'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imagem'] = imagem;
    data['nome'] = nome;
    data['celular'] = celular;
    return data;
  }
}
