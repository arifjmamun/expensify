import 'package:dartz/dartz.dart';
import 'package:expensify/features/parameters/domain/entities/category.dart';
import 'package:expensify/features/parameters/domain/repositories/category_repository.dart';
import 'package:expensify/features/parameters/domain/usecases/get_category_by_name.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {

}

void main() {
  GetCategoryByName usecase;
  MockCategoryRepository mockCategoryRepository;

  setUp(() {
    mockCategoryRepository = new MockCategoryRepository();
    usecase = GetCategoryByName(mockCategoryRepository);
  });

  final categoryName = 'test name';
  final category = Category(name: 'test name', id: '3534534');

  test('should get category by category name from the repository', () async {
    // arrange
    when(mockCategoryRepository.getCategoryName(any)).thenAnswer((_) async => Right(category));
    // act
    final result = await usecase(Params(categoryName: categoryName));
    // assert
    expect(result, Right(category));
    verify(mockCategoryRepository.getCategoryName(categoryName));
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}