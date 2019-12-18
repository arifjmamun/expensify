import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Category extends Equatable {
  final String name;
  final String id;

  Category({@required this.name, @required this.id});

  @override
  List<Object> get props => [name, id];
}
