class Product {
  String name;
  double tax;
  double price;
  bool isPaidwithCreditCard;
  String urlPhoto;

  //Construtor da classe que aceita os parâmetros e os atribui aos respectivos campos da classe

  Product(this.name, this.tax, this.price, this.isPaidwithCreditCard, this.urlPhoto);

  // Converte um produto em um Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tax': tax,
      'price': price,
      'isPaidwithCreditCard': isPaidwithCreditCard,
      'urlPhoto': urlPhoto,
    };
  }

  // Converte um Map em um produto
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      json['name'],
      json['tax'],
      json['price'],
      json['isPaidwithCreditCard'],
      json['urlPhoto'],
    );
  }
}