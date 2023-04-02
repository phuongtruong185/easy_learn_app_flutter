class AddToCart {
  final String courseId;

  AddToCart(this.courseId);

  AddToCart.fromJson(Map<String, dynamic> json)
      : courseId = json['courseId'];

  Map<String, dynamic> toJson() => {
    'courseId': courseId,
  };
}