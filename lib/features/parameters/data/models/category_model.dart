import 'package:meta/meta.dart';

import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    @required String name,
    @required String id,
  }) : super(name: name, id: id);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}
