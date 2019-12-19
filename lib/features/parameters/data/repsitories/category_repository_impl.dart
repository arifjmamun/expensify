import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';
import '../datasources/category_remote_data_source.dart';

typedef Future<Category> _GetCategoryChooser();

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Category>> getCategoryById(String id) async {
    return await _getCategory(() {
      return remoteDataSource.getCategoryById(id);
    });
  }

  @override
  Future<Either<Failure, Category>> getCategoryName(String categoryName) async {
    return await _getCategory(() {
      return remoteDataSource.getCategoryName(categoryName);
    });
  }

  Future<Either<Failure, Category>> _getCategory(_GetCategoryChooser getCategory) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategory = await getCategory();
        localDataSource.cacheCategory(remoteCategory);
        return Right(remoteCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCategory = await localDataSource.getLastCategory();
        return Right(localCategory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
