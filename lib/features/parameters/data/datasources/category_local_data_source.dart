import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  /// Gets the cached [Category] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<CategoryModel> getLastCategory();

  Future<void> cacheCategory(CategoryModel categoryToCache);
}

const CACHED_CATEGORY = 'CACHED_CATEGORY';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<CategoryModel> getLastCategory() {
    final jsonString = sharedPreferences.getString(CACHED_CATEGORY);
    if (jsonString != null) {
      return Future.value(CategoryModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCategory(CategoryModel categoryToCache) {
    return sharedPreferences.setString(
      CACHED_CATEGORY,
      json.encode(categoryToCache.toJson()),
    );
  }
}
