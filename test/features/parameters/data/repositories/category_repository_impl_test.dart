import 'package:dartz/dartz.dart';
import 'package:expensify/core/error/exceptions.dart';
import 'package:expensify/core/error/failures.dart';
import 'package:expensify/core/network/network_info.dart';
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

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

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

    runTestsOnline(() {
      test(
          'should return remote data when call to the remote data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getCategoryById(any))
            .thenAnswer((_) async => categoryModel);
        // act
        final result = await repository.getCategoryById(categoryId);
        // assert
        verify(mockRemoteDataSource.getCategoryById(categoryId));
        expect(result, equals(Right(category)));
      });

      test(
          'should cache the data locally when call to the remote data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getCategoryById(any))
            .thenAnswer((_) async => categoryModel);
        // act
        await repository.getCategoryById(categoryId);
        // assert
        verify(mockRemoteDataSource.getCategoryById(categoryId));
        verify(mockLocalDataSource.cacheCategory(categoryModel));
      });

      test(
          'should return server failure when the call to the remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getCategoryById(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getCategoryById(categoryId);
        // assert
        verify(mockRemoteDataSource.getCategoryById(categoryId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastCategory())
            .thenAnswer((_) async => categoryModel);
        // act
        final result = await repository.getCategoryById(categoryId);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastCategory());
        expect(result, equals(Right(categoryModel)));
      });

      test('should return cache failure when no cached data present', () async {
        // arrange
        when(mockLocalDataSource.getLastCategory()).thenThrow(CacheException());
        // act
        final result = await repository.getCategoryById(categoryId);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastCategory());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getCategoryByName', () {
    final categoryId = '573945345jdsflfsdf';
    final categoryName = 'food';
    final categoryModel = CategoryModel(id: categoryId, name: categoryName);
    final Category category = categoryModel;

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getCategoryName(categoryName);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when call to the remote data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getCategoryName(any))
            .thenAnswer((_) async => categoryModel);
        // act
        final result = await repository.getCategoryName(categoryName);
        // assert
        verify(mockRemoteDataSource.getCategoryName(categoryName));
        expect(result, equals(Right(category)));
      });

      test(
          'should cache the data locally when call to the remote data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getCategoryName(any))
            .thenAnswer((_) async => categoryModel);
        // act
        await repository.getCategoryName(categoryName);
        // assert
        verify(mockRemoteDataSource.getCategoryName(categoryName));
        verify(mockLocalDataSource.cacheCategory(categoryModel));
      });

      test(
          'should return server failure when the call to the remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getCategoryName(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getCategoryName(categoryName);
        // assert
        verify(mockRemoteDataSource.getCategoryName(categoryName));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastCategory())
            .thenAnswer((_) async => categoryModel);
        // act
        final result = await repository.getCategoryName(categoryName);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastCategory());
        expect(result, equals(Right(categoryModel)));
      });

      test('should return cache failure when no cached data present', () async {
        // arrange
        when(mockLocalDataSource.getLastCategory()).thenThrow(CacheException());
        // act
        final result = await repository.getCategoryName(categoryName);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastCategory());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
