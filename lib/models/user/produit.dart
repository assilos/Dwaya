class Produit {
  String nom;
  String category;
  String image;
  String description;
  String price;
  String quantity;
  String codeaBarres;
  String iV;
  List listes ;

  Produit(
      {
        this.nom,
        this.category,
        this.image,
        this.description,
        this.price,
        this.quantity,
        this.codeaBarres,
        this.listes,
        this.iV});

  Produit.fromJson(Map<String, dynamic> json) {

    nom = json['nom'];
    category = json['category'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    codeaBarres = json['codea_barres'];
    listes=json['listes'];
    print('fil model');
   print(nom);
    print(category);
    print(image);
    print(description);
    print(price);
    print(quantity);
    print(codeaBarres);
    print(listes);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['category'] = this.category;
    data['image'] = this.image;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['CodeaBarres'] = this.codeaBarres;
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