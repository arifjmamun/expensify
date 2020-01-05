import 'dart:convert';

import 'package:expensify/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../domain/entities/category.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  /// Calls the http://localhost:3333/api/categories/{id}
  ///
  /// Throws a [ServerException] for all error codes
  Future<CategoryModel> getCategoryById(String id);

  /// Calls the http://localhost:3333/api/categories/{categoryName}
  ///
  /// Throws a [ServerException] for all error codes
  Future<Category> getCategoryName(String categoryName);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl({@required this.client});

  @override
  Future<CategoryModel> getCategoryById(String id) =>
      _getCategoryFromUrl('http://localhost:3000/api/category/id/$id');

  @override
  Future<Category> getCategoryName(String categoryName) => _getCategoryFromUrl(
      'http://localhost:3000/api/category/name/$categoryName');

  Future<CategoryModel> _getCategoryFromUrl(String url) async {
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
