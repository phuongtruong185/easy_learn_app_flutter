class Checkout {
  final String cartId;

  Checkout(this.cartId);

  Checkout.fromJson(Map<String, dynamic> json)
      : cartId = json['cartId'];

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
  };
}