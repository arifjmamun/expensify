import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  CategoryEvent([List props = const <dynamic>[]]) : super(props);
}

class GetCategoryForId extends CategoryEvent {
  final String categoryId;

  GetCategoryForId(this.categoryId);
}

class GetCategoryForName extends CategoryEvent {
  final String categoryName;
  
  GetCategoryForName(this.categoryName);
}
