class Demande {
  String nommedicament;
  int iduser;
  String image;
  String description;
  String datePublication;
  int quantite;
  String unite;
  String lieu;

  Demande(
      {
        this.nommedicament,
        this.iduser,
        this.image,
        this.description,
        this.datePublication,
        this.lieu,
        this.quantite,
        this.unite,
      });

  Demande.fromJson(Map<String, dynamic> json) {
    print('ee');
    print(json['nommedicament']);
    print(json['iduser']);
    print(json['image']);
    print(json['description']);
    print(json['datePublication']);
    print(json['lieu']);
    print(json['quantite']);
    print(json['unite']);
    nommedicament = json['nommedicament'];
    iduser = json['iduser'];
    image = json['image'];
    description = json['description'];
    datePublication = json['datePublication'];
    lieu = json['lieu'];
    quantite = json['quantite'];
    unite=json['unite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nommedicament'] = this.nommedicament;
    data['iduser'] = this.iduser;
    data['image'] = this.image;
    data['description'] = this.description;
    data['datePublication'] = this.datePublication;
    data['lieu'] = this.lieu;
    data['quantite'] = this.quantite;
    data['unite'] = this.unite;
    return data;
  }
}

class Id {
  String oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}