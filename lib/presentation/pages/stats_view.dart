import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/presentation/pages/mood/controllers/mood_controller.dart';
import 'package:tt_5/presentation/pages/user/controllers/user_controller.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';
import 'package:tt_5/presentation/widgets/bottom_bar.dart';
import 'package:tt_5/presentation/widgets/pie_chart_widget.dart';

class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  DateTime selectedDate = DateTime.now();
  late final MoodController _moodController;
  late final UserController _userController;
  ETriggersType? selectedTrigger;
  String selectedCustomTrigger = '';
  bool showTriggers = false;
  void _init() {
    _moodController = MoodController();
    _userController = UserController();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 65, 16, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Analytics',
                  style: AppTextStyle.displayMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(72, 0, 72, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month - 1,
                      );
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColors.brown,
                    )),
                Text(
                  DateFormat("MMMM").format(selectedDate),
                  style: AppTextStyle.displaySmall,
                ),
                InkWell(
                    onTap: () {
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month + 1,
                      );
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.chevron_right,
                      color: AppColors.brown,
                    ))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: AppColors.secondary,
                              border: Border.all(color: AppColors.outline4),
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Mood change chart',
                                  style: AppTextStyle.bodyLarge,
                                ),
                              ),
                              if (_moodController.value.moods
                                  .where(
                                    (element) =>
                                        element.date.month ==
                                        selectedDate.month,
                                  )
                                  .isEmpty)
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Image.asset(
                                        'assets/empty_list.png',
                                        width: 99,
                                        height: 78,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: AppColors.purple,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Text(
                                        'No data for this month',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.bodyMedium,
                                      ),
                                    )
                                  ],
                                ),
                              if (_moodController.value.moods
                                  .where(
                                    (element) =>
                                        element.date.month ==
                                        selectedDate.month,
                                  )
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: PieChartSample(
                                      points: _moodController.value.moods
                                          .where(
                                            (element) =>
                                                element.date.month ==
                                                selectedDate.month,
                                          )
                                          .toList()),
                                ),
                              if (_moodController.value.moods
                                  .where(
                                    (element) =>
                                        element.date.month ==
                                        selectedDate.month,
                                  )
                                  .isNotEmpty)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      EEmotions.values.length,
                                      (index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Image.asset(
                                              width: 40,
                                              height: 25,
                                              fit: BoxFit.cover,
                                              EEmotions
                                                  .values[index].assetFull),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            border: Border.all(color: AppColors.outline4),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Mood scale',
                                style: AppTextStyle.bodyLarge,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  EEmotions.values.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 5,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Image.asset(
                                                width: 40,
                                                height: 25,
                                                fit: BoxFit.cover,
                                                EEmotions
                                                    .values[index].assetFull),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                9, 3, 9, 3),
                                            decoration: BoxDecoration(
                                                color: AppColors.background,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              '${((_moodController.value.moods.where(
                                                    (element) =>
                                                        element.date.month ==
                                                            selectedDate
                                                                .month &&
                                                        element.emotion ==
                                                            EEmotions
                                                                .values[index],
                                                  ).length / _moodController.value.moods.length) * 100).toStringAsFixed(0)}%',
                                              style: AppTextStyle.bodyMedium,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            border: Border.all(color: AppColors.outline4),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Trigger Rating',
                                style: AppTextStyle.bodyLarge,
                              ),
                            ),
                            if (_moodController.value.moods
                                .where(
                                  (element) =>
                                      element.date.month == selectedDate.month,
                                )
                                .isNotEmpty)
                              getMostTriggers(),
                            if (_moodController.value.moods
                                .where(
                                  (element) =>
                                      element.date.month == selectedDate.month,
                                )
                                .isEmpty)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Image.asset(
                                      'assets/empty_list.png',
                                      width: 99,
                                      height: 78,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: AppColors.purple,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: const Text(
                                      'No data for this month',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.bodyMedium,
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.secondary,
                                border: Border.all(color: AppColors.outline4),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      const Text(
                                        'Trigger Analysis',
                                        style: AppTextStyle.bodyLarge,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                  builder: (context, setstate) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Dialog(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .secondary,
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .outline4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          10),
                                                              child: Container(
                                                                  width: 300,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                          10),
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .secondary,
                                                                      border: Border.all(
                                                                          color: AppColors
                                                                              .outline4),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  child: getAllTriggers(
                                                                      _userController
                                                                          .value
                                                                          .users
                                                                          .first
                                                                          .triggers,
                                                                      () {
                                                                    setstate(
                                                                        () {});
                                                                  },
                                                                      _userController
                                                                          .value
                                                                          .users
                                                                          .first
                                                                          .customTriggers)),
                                                            ),
                                                            InkWell(
                                                              onTap: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20),
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .primary,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                                child: Text(
                                                                  'Apply',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: AppTextStyle
                                                                      .bodyLarge
                                                                      .copyWith(
                                                                          color:
                                                                              AppColors.secondary),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                            },
                                          );
                                        },
                                        child: selectedTrigger != null
                                            ? Image.asset(
                                                selectedTrigger!.asset)
                                            : selectedCustomTrigger.isNotEmpty
                                                ? Image.asset(
                                                    'assets/custom_trigger.png')
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: AppColors
                                                                .purple,
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color:
                                                          AppColors.background,
                                                    ),
                                                  ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (_moodController.value.moods
                                          .where(
                                            (element) =>
                                                element.date.month ==
                                                selectedDate.month,
                                          )
                                          .isNotEmpty)
                                        Text(
                                          'The dependence of your mood on',
                                          style: AppTextStyle.bodyMedium
                                              .copyWith(
                                                  color:
                                                      AppColors.onBackground),
                                        ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          selectedTrigger != null
                                              ? selectedTrigger!.label
                                              : selectedCustomTrigger.isNotEmpty
                                                  ? selectedCustomTrigger
                                                  : '',
                                          style: AppTextStyle.bodyMedium
                                              .copyWith(
                                                  color: AppColors.primary),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      EEmotions.values.length,
                                      (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 5,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Image.asset(
                                                    width: 40,
                                                    height: 25,
                                                    fit: BoxFit.cover,
                                                    EEmotions.values[index]
                                                        .assetFull),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        9, 3, 9, 3),
                                                decoration: BoxDecoration(
                                                    color: AppColors.background,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Text(
                                                  'x${_moodController.value.moods.where(
                                                        (element) =>
                                                            element.date
                                                                    .month ==
                                                                selectedDate
                                                                    .month &&
                                                            element.emotion ==
                                                                EEmotions
                                                                        .values[
                                                                    index] &&
                                                            (element.triggers
                                                                    .contains(
                                                                        selectedTrigger) ||
                                                                element
                                                                    .customTriggers
                                                                    .containsValue(
                                                                        selectedCustomTrigger)),
                                                      ).length}',
                                                  style:
                                                      AppTextStyle.bodyMedium,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const BottomBar(page: EPageOnSelect.statistics)
        ],
      ),
    );
  }

  Widget getMostTriggers() {
    List<Widget> list = [];
    List<ETriggersType> allTriggers = [];
    for (var mood in _moodController.value.moods.where(
      (element) => element.date.month == selectedDate.month,
    )) {
      allTriggers.addAll(mood.triggers);
    }
    var allTriggersMap = groupBy(
      allTriggers,
      (e) {
        return e.label;
      },
    );
    allTriggersMap.forEach(
      (key, value) {},
    );
    var mapValues = allTriggersMap.values.toList();
    mapValues.sort(((a, b) => b.length.compareTo(a.length)));

    for (var i = 0; i < 3; i++) {
      list.add(Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.outline4),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                '${i + 1}',
                style: AppTextStyle.displaySmall.copyWith(
                    color: i == 0
                        ? AppColors.primary
                        : i == 1
                            ? AppColors.orange
                            : AppColors.yellow),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.asset(mapValues[i].first.asset),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                mapValues[i].first.label,
                style: AppTextStyle.bodyMedium,
              ),
            ),
            Text(
              'x${mapValues[i].length.toString()}',
              style: AppTextStyle.bodyMedium
                  .copyWith(color: AppColors.onBackground),
            )
          ],
        ),
      ));
      if (i != 2) {
        list.add(const SizedBox(
          width: 18,
        ));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }

  Widget getAllTriggers(List<ETriggersType> triggers, Function() callBack,
      Map<int, String> customTriggers) {
    List<Widget> list = [];
    for (var trigger in triggers) {
      list.add(Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 5),
        child: InkWell(
            onTap: () {
              selectedTrigger = trigger;
              selectedCustomTrigger = '';
              callBack();
              setState(() {});
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: selectedTrigger == trigger
                    ? const BoxDecoration(
                        color: AppColors.background, shape: BoxShape.circle)
                    : null,
                child: Image.asset(trigger.asset))),
      ));
    }
    customTriggers.forEach(
      (key, value1) {
        list.add(InkWell(
          onTap: () {
            selectedCustomTrigger = value1;
            selectedTrigger = null;
            callBack();
            setState(() {});
          },
          child: Container(
              decoration: selectedCustomTrigger == value1
                  ? const BoxDecoration(
                      color: AppColors.background, shape: BoxShape.circle)
                  : null,
              child: Image.asset('assets/custom_trigger.png')),
        ));
      },
    );
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: list,
    );
  }
}
