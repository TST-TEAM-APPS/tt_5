import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/model/mood.dart';

class PieChartSample extends StatefulWidget {
  const PieChartSample({super.key, required this.points});
  final List<Mood> points;

  @override
  State<StatefulWidget> createState() => _PieChartState();
}

class _PieChartState extends State<PieChartSample> {
  int touchedIndex = -1;
  double totalCost = 0.0;
  int savedDateTime = 0;

  @override
  Widget build(BuildContext context) {
    totalCost = 0.0;
    return AspectRatio(
      aspectRatio: 3,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> list = [];
    List<Mood> hobbyMap = [];
    List<Mood> hobbyMap2 = [];
    List<Mood> hobbyMap3 = [];
    List<Mood> hobbyMap4 = [];
    List<Mood> hobbyMap5 = [];
    hobbyMap = widget.points
        .where(
          (element) => element.emotion == EEmotions.cry,
        )
        .toList();
    hobbyMap2 = widget.points
        .where(
          (element) => element.emotion == EEmotions.happy,
        )
        .toList();
    hobbyMap3 = widget.points
        .where(
          (element) => element.emotion == EEmotions.lovely,
        )
        .toList();
    hobbyMap4 = widget.points
        .where(
          (element) => element.emotion == EEmotions.neutral,
        )
        .toList();
    hobbyMap5 = widget.points
        .where(
          (element) => element.emotion == EEmotions.sad,
        )
        .toList();
    list.add(PieChartSectionData(
      color: hobbyMap.isNotEmpty
          ? hobbyMap.first.emotion.color
          : Colors.transparent,
      value: hobbyMap.length.toDouble(),
      radius: 10.0,
      showTitle: false,
      titleStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ));
    list.add(PieChartSectionData(
      color: hobbyMap2.isNotEmpty
          ? hobbyMap2.first.emotion.color
          : Colors.transparent,
      value: hobbyMap2.length.toDouble(),
      radius: 10.0,
      showTitle: false,
      titleStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ));
    list.add(PieChartSectionData(
      color: hobbyMap3.isNotEmpty
          ? hobbyMap3.first.emotion.color
          : Colors.transparent,
      value: hobbyMap3.length.toDouble(),
      radius: 10.0,
      showTitle: false,
      titleStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ));
    list.add(PieChartSectionData(
      color: hobbyMap4.isNotEmpty
          ? hobbyMap4.first.emotion.color
          : Colors.transparent,
      value: hobbyMap4.length.toDouble(),
      radius: 10.0,
      showTitle: false,
      titleStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ));
    list.add(PieChartSectionData(
      color: hobbyMap5.isNotEmpty
          ? hobbyMap5.first.emotion.color
          : Colors.transparent,
      value: hobbyMap5.length.toDouble(),
      radius: 10.0,
      showTitle: false,
      titleStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ));

    return list;
  }
}
