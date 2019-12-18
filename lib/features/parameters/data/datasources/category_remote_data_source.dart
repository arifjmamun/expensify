import '../../domain/entities/category.dart';

abstract class CategoryRemoteDataSource {
  /// Calls the http://localhost:3333/api/categories/{id}
  /// 
  /// Throws a [ServerException] for all error codes
  Future<Category> getCategoryById(String id);
  
  /// Calls the http://localhost:3333/api/categories/{categoryName}
  /// 
  /// Throws a [ServerException] for all error codes
  Future<Category> getCategoryName(String categoryName);
}
