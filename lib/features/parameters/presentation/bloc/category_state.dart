import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  CategoryState([List props = const <dynamic>[]]) : super(props);
}

class InitialCategoryState extends CategoryState {}
