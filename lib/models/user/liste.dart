class Liste {
 String iId;
  String id_client;
  String date_creation;
  String nom;
  String iV;
  List<String> a ;
  Liste(
      {this.iId,
        this.id_client,
        this.date_creation,
        this.nom,
        this.a,
        this.iV});

  Liste.fromJson(Map<String, dynamic> json) {
    iId = json['id'] ;
    nom = json['nom'];
    date_creation = json['date_creation'];
    id_client = json['id_client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['id'] = this.iId;
    }
    data['nom'] = this.nom;
    data['category'] = this.id_client;
    data['image'] = this.date_creation;
    data['__v'] = this.iV;
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