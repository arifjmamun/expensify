import 'package:expensify/core/platform/network_info.dart';
import 'package:expensify/features/parameters/data/datasources/category_local_data_source.dart';
import 'package:expensify/features/parameters/data/datasources/category_remote_data_source.dart';
import 'package:expensify/features/parameters/data/repsitories/category_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock implements CategoryRemoteDataSource {}

class MockLocalDataSource extends Mock implements CategoryLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CategoryRepositoryImpl repository;
  MockRemoteDataSource remoteDataSource;
  MockLocalDataSource localDataSource;
  MockNetworkInfo networkInfo;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    localDataSource = MockLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = CategoryRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
  });
}
