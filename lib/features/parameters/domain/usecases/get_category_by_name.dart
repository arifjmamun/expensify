import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategoryByName implements UseCase<Category, Params> {
  final CategoryRepository repository;
  GetCategoryByName(this.repository);

  @override
  Future<Either<Failure, Category>> call(Params params) async {
    return await repository.getCategoryName(params.categoryName);
    // return null;
  }
}

class Params extends Equatable {
  final String categoryName;

  Params({@required this.categoryName});

  @override
  List<Object> get props => [categoryName];
}
