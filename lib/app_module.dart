import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_app/core/utils/date_input_converter.dart';
import 'package:my_app/features/data/datasources/coin/coin_datasource.dart';
import 'package:my_app/features/data/datasources/example/example_datasource.dart';
import 'package:my_app/features/data/repositories/coin_repository.dart';
import 'package:my_app/features/data/repositories/example_repository.dart';
import 'package:my_app/features/domain/usecases/coin_usecase.dart';
import 'package:my_app/features/domain/usecases/get_example_from_username_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/features/presenter/controllers/home_store.dart';
import 'package:my_app/features/presenter/controllers/trade_store.dart';
import 'package:my_app/features/presenter/pages/about_page.dart';
import 'package:my_app/features/presenter/pages/home_page.dart';
import 'package:my_app/features/presenter/widgets/trade/new_trade.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CoinUseCase(i())),
    Bind.lazySingleton((i) => CoinRepository(i())),
    Bind.lazySingleton((i) => CoinDataSource(client: i())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => DateInputConverter()),
    Bind.factory((i) => HomeStore(i())),
    Bind.factory((i) => TradeStore(i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const HomePage()),
        ChildRoute('/new-trade', child: (_, __) => const Trade()),
      ];
}
