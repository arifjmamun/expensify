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
}