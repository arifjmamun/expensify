import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  /// Gets the cached [Category] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<CategoryModel> getLastCategory();

  Future<void> cacheCategory(CategoryModel categoryToCache);
}
