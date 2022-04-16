import 'package:equatable/equatable.dart';

class Price extends Equatable {
  final int id;
  final String price;

  Price({required this.id, required this.price});

  @override
  List<Object?> get props => [id, price];

  static List<Price> prices = [
    Price(id: 1, price: "ANY"),
    Price(id: 2, price: "FREE"),
    Price(id: 3, price: "\$\$\$"),
  ];
}
