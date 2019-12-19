import 'dart:convert';

import 'package:expensify/core/error/exceptions.dart';
import 'package:expensify/features/parameters/data/datasources/category_local_data_source.dart';
import 'package:expensify/features/parameters/data/models/category_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  CategoryLocalDataSourceImpl datasource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = CategoryLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastCategory', () {
    final tCategoryModel =
        CategoryModel.fromJson(json.decode(fixture('category_cached.json')));

    test(
        'should return Category from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('category_cached.json'));
      // act
      final result = await datasource.getLastCategory();
      // assert
      verify(mockSharedPreferences.getString('CACHED_CATEGORY'));
      expect(result, equals(tCategoryModel));
    });

    test('should throw CacheException when there is not a cache value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = datasource.getLastCategory;
      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheCategory', () {
    final tCategoryModel = CategoryModel(id: '543573495349', name: 'food');
    test('should call SharedPreferences to cache the data', () async {
      // act
      datasource.cacheCategory(tCategoryModel);
      // assert
      final expectedJsonString = json.encode(tCategoryModel.toJson());
      verify(mockSharedPreferences.setString(
        CACHED_CATEGORY,
        expectedJsonString,
      ));
    });
  });
}
