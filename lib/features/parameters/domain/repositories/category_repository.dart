import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, Category>> getCategoryById(String id);
  Future<Either<Failure, Category>> getCategoryName(String categoryName);
}
