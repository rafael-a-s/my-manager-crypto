import 'package:my_app/features/domain/entities/assets.dart';
import 'package:my_app/features/domain/entities/coin.dart';

class CoinModel extends Coin {
  const CoinModel({
    required String symbol,
    required double price,
  }) : super(
          symbol: symbol,
          price: price,
        );

  factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
        symbol: json['symbol'],
        price: double.parse(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'price': price,
      };
}
