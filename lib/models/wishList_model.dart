class WishList {
  final String courseId;

  WishList(this.courseId);

  WishList.fromJson(Map<String, dynamic> json)
      : courseId = json['courseId'];

  Map<String, dynamic> toJson() => {
    'courseId': courseId,
  };
}