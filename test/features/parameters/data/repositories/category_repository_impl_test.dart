import 'package:dartz/dartz.dart';
import 'package:expensify/core/platform/network_info.dart';
import 'package:expensify/features/parameters/data/datasources/category_local_data_source.dart';
import 'package:expensify/features/parameters/data/datasources/category_remote_data_source.dart';
import 'package:expensify/features/parameters/data/models/category_model.dart';
import 'package:expensify/features/parameters/data/repsitories/category_repository_impl.dart';
import 'package:expensify/features/parameters/domain/entities/category.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock implements CategoryRemoteDataSource {}

class MockLocalDataSource extends Mock implements CategoryLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  CategoryRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CategoryRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getCategoryById', () {
    final categoryId = '573945345jdsflfsdf';
    final categoryModel = CategoryModel(id: categoryId, name: 'food');
    final Category category = categoryModel;

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getCategoryById(categoryId);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call to the remote data source is success', () async {
        // arrange
        when(mockRemoteDataSource.getCategoryById(any)).thenAnswer((_) async => categoryModel);
        // act
        final result = repository.getCategoryById(categoryId);
        // assert
        verify(mockRemoteDataSource.getCategoryById(categoryId));
        expect(result, equals(Right(category)));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
