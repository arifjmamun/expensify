import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategoryById implements UseCase<Category, Params> {
  final CategoryRepository repository;
  GetCategoryById(this.repository);

  @override
  Future<Either<Failure, Category>> call(Params params) async {
    return await repository.getCategoryById(params.categoryId);
  }
}

class Params extends Equatable {
  final String categoryId;

  Params({@required this.categoryId}): super([categoryId]);
}
