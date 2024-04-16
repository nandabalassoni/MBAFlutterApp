class Product {
  final int? id;
  final String name;
  final double tax;
  final double price;
  final bool isPaidWithCreditCard;
  final String urlPhoto;

  //Construtor da classe que aceita os parâmetros e os atribui aos respectivos campos da classe

  //Product(this.name, this.tax, this.price, this.isPaidwithCreditCard, this.urlPhoto);
  Product(this.id, this.name, this.tax, this.price, this.isPaidWithCreditCard, this.urlPhoto);

  Product.fromMap(Map<String, dynamic> item):
      id=item["id"], name=item["name"], tax=item["tax"], price=item["price"], isPaidWithCreditCard=item["isPaidWithCreditCard"] == 1, urlPhoto=item["urlPhoto"];

  Map<String, Object> toMap(){
    return {'name': name, 'tax': tax,'price': price,'isPaidWithCreditCard': isPaidWithCreditCard ? 1 : 0, 'urlPhoto': urlPhoto};
  }

  // Converte um produto em um Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tax': tax,
      'price': price,
      'isPaidwithCreditCard': isPaidWithCreditCard,
      'urlPhoto': urlPhoto,
    };
  }

  // Converte um Map em um produto
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['name'],
      json['tax'],
      json['price'],
      json['isPaidwithCreditCard'],
      json['urlPhoto'],
    );
  }
}