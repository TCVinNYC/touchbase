// let poster choose category
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [name];

  static List<Category> categories = [
    const Category(id: 1, name: "tech"),
    const Category(id: 2, name: "startup"),
    const Category(id: 3, name: "new friends"),
    const Category(id: 4, name: "college"),
    const Category(id: 5, name: "art"),
    const Category(id: 6, name: "acting"),
    const Category(id: 7, name: "reading"),
    const Category(id: 8, name: "marketing"),
    const Category(id: 9, name: "finance"),
  ];
}
