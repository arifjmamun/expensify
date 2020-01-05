import 'dart:convert';

import 'package:expensify/core/error/exceptions.dart';
import 'package:expensify/features/parameters/data/datasources/category_remote_data_source.dart';
import 'package:expensify/features/parameters/data/models/category_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  CategoryRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = CategoryRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('category.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getCategoryById', () {
    final tCategoryId = '573945345jdsflfsdf';
    final tCategoryModel =
        CategoryModel.fromJson(json.decode(fixture('category.json')));

    test('''should perform a GET request on a URL with ID 
    being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getCategoryById(tCategoryId);
      // assert
      verify(mockHttpClient.get(
          'http://localhost:3000/api/category/id/$tCategoryId',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return Category when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getCategoryById(tCategoryId);
      // assert
      expect(result, equals(tCategoryModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getCategoryById;
      // assert
      expect(() => call(tCategoryId), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('getCategoryByName', () {
    final tCategoryName = 'food';
    final tCategoryModel =
        CategoryModel.fromJson(json.decode(fixture('category.json')));

    test('''should perform a GET request on a URL with ID 
    being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getCategoryName(tCategoryName);
      // assert
      verify(mockHttpClient.get(
          'http://localhost:3000/api/category/name/$tCategoryName',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return Category when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getCategoryName(tCategoryName);
      // assert
      expect(result, equals(tCategoryModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getCategoryName;
      // assert
      expect(() => call(tCategoryName), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
