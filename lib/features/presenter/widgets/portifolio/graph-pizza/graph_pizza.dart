import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/features/domain/entities/portifolio.dart';
import 'package:my_app/features/domain/entities/portifolio/portifolio_info.dart';
import 'package:my_app/features/presenter/root.dart';

class GraphPortifolio extends StatefulWidget {
  List<Portifolio> portifolio;
  PortifolioInfo infoGeral;
  GraphPortifolio({
    super.key,
    required this.portifolio,
    required this.infoGeral,
  });

  @override
  State<GraphPortifolio> createState() => _GraphPortifolioState();
}

class _GraphPortifolioState extends State<GraphPortifolio> {
  int index = 0;
  double total = 0;
  String portifolioLabel = '';
  double graficoValor = 0;
  final formatCurrency = NumberFormat.simpleCurrency(
    locale: "en_US",
    decimalDigits: 2,
  );

  setGraphData(index) {
    if (index < 0) return;

    if (index == widget.portifolio.length) {
      portifolioLabel = 'Saldo';
      graficoValor = widget.infoGeral.totalUpdated;
    } else {
      portifolioLabel = widget.portifolio[index].coin;
      graficoValor = widget.portifolio[index].totalPriceActual;
    }
  }

  List<PieChartSectionData> loadData() {
    setGraphData(index);
    int tamanhoLista = widget.portifolio.length;

    return List.generate(tamanhoLista, (i) {
      final isTouched = i == index;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final color = isTouched ? Colors.tealAccent : Colors.tealAccent[400];
      var value = widget.portifolio[i].totalPriceActual;
      return PieChartSectionData(
        color: color,
        value: value,
        title: formatCurrency.format(value),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sectionsSpace: 5,
              centerSpaceRadius: 120,
              sections: loadData(),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) =>
                    setState(() {
                  if (event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    index = -1;
                    setGraphData(index);
                    return;
                  }
                  index = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  setGraphData(index);
                }),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Text(
              portifolioLabel,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.teal,
              ),
            ),
            Text(
              formatCurrency.format(graficoValor),
              style: const TextStyle(
                fontSize: 30,
                color: Colors.teal,
              ),
            ),
          ],
        )
      ],
    );
  }
}
