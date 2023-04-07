import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_app/features/data/datasources/endpoints/bn_endpoints.dart';
import 'package:my_app/features/data/datasources/coin/i_coin_datasource.dart';
import 'package:my_app/features/data/models/coin_model.dart';
import '../../../../core/usecase/erros/exceptions.dart';

class CoinDataSource implements ICoinDataSource {
  final http.Client client;

  CoinDataSource({
    required this.client,
  });

  @override
  Future<CoinModel> getCoinSymbol(String symbol) async {
    print(BnEndPoints.getCoinSymbol('BTCUSDT').toString());
    final response = await client.get(BnEndPoints.getCoinSymbol(symbol));
    print(response.body);

    return response.statusCode == 200
        ? CoinModel.fromJson(json.decode(response.body))
        : throw ServerException();
  }
}
