import 'package:equatable/equatable.dart';

class Price extends Equatable {
  final int id;
  final String price;

  const Price({required this.id, required this.price});

  @override
  List<Object?> get props => [id, price];

  static List<Price> prices = [
    const Price(id: 1, price: "ANY"),
    const Price(id: 2, price: "FREE"),
    const Price(id: 3, price: "\$\$\$"),
  ];
}
