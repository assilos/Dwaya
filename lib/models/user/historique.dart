class Historique {
  String iId;
  String id_client;
  String tva;
  String remise;
  String montantfinal;
  String date;
  var produits ;

  Historique(
      {this.iId,
        this.id_client,
        this.tva,
        this.remise,
        this.montantfinal,
        this.date,
      this.produits});

  Historique.fromJson(Map<String, dynamic> json) {
    iId = json['id'] ;
    id_client = json['id_client'];
    tva = json['tva'];
    remise = json['remise'];
    montantfinal = json['montantfinal'];
    date=json['date'];
    produits=json['produits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['id'] = this.iId;
    }
    data['id_client'] = this.id_client;
    data['tva'] = this.tva;
    data['remise'] = this.remise;
    data['montantfinal'] = this.montantfinal;
    data["date"]=this.date ;
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