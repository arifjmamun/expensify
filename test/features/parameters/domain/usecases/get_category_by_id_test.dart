import 'package:dartz/dartz.dart';
import 'package:expensify/features/parameters/domain/entities/category.dart';
import 'package:expensify/features/parameters/domain/repositories/category_repository.dart';
import 'package:expensify/features/parameters/domain/usecases/get_category_by_id.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {

}

void main() {
  GetCategoryById usecase;
  MockCategoryRepository mockCategoryRepository;

  setUp(() {
    mockCategoryRepository = new MockCategoryRepository();
    usecase = GetCategoryById(mockCategoryRepository);
  });

  final categoryId = '573945739457934';
  final category = Category(name: 'Test category', id: '3534534');

  test('should get category by categoryId from the repository', () async {
    // arrange
    when(mockCategoryRepository.getCategoryById(any)).thenAnswer((_) async => Right(category));
    // act
    final result = await usecase(Params(categoryId: categoryId));
    // assert
    expect(result, Right(category));
    verify(mockCategoryRepository.getCategoryById(categoryId));
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}