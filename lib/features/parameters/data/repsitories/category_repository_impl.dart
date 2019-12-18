import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../datasources/category_local_data_source.dart';
import '../datasources/category_remote_data_source.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

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
    networkInfo.isConnected;
    return null;
  }

  @override
  Future<Either<Failure, Category>> getCategoryName(String categoryName) async {
    // TODO: implement getCategoryName
    return null;
  }
}
