import 'dart:convert';

import 'package:expensify/features/parameters/data/models/category_model.dart';
import 'package:expensify/features/parameters/domain/entities/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final categoryModel = CategoryModel(id: '573945345jdsflfsdf', name: 'food');

  test('should be subclass of category entity', () async {
    // assert
    expect(categoryModel, isA<Category>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('category.json'));
      // act
      final result = CategoryModel.fromJson(jsonMap);
      // assert
      expect(result, equals(categoryModel));
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = categoryModel.toJson();
      // assert
      final expectedMap = {"id": "573945345jdsflfsdf", "name": "food"};
      expect(result, expectedMap);
    });
  });
}
