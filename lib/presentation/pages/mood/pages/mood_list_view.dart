import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/presentation/pages/mood/controllers/mood_controller.dart';
import 'package:tt_5/presentation/pages/user/controllers/user_controller.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';
import 'package:tt_5/presentation/widgets/bottom_bar.dart';

class MoodListView extends StatefulWidget {
  const MoodListView({super.key});

  @override
  State<MoodListView> createState() => _MoodListViewState();
}

class _MoodListViewState extends State<MoodListView> {
  late final MoodController _moodController;
  late final UserController _userController;
  bool showMoods = false;
  bool showTriggers = false;
  ESort? selectedSort;
  ERecent? selectedRecent;
  List<EEmotions> selectedEmotions = [];
  List<ETriggersType> selectedTriggers = [];
  Map<int, String> selectedCustomTrigger = {};
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 65, 16, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  'List',
                  style: AppTextStyle.displayMedium,
                ),
                InkWell(
                    onTap: () {
                      showFilters(context);
                    },
                    child: Image.asset('assets/filter.png'))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _moodController.value.moods.isNotEmpty
                        ? getMoods()
                        : Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 100, bottom: 20),
                                child: Image.asset('assets/empty.png'),
                              ),
                              Text(
                                'You haven\'t added any records',
                                style: AppTextStyle.bodyMedium
                                    .copyWith(color: AppColors.onBackground),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          const BottomBar(
            page: EPageOnSelect.listPage,
          )
        ],
      ),
    );
  }

  void showFilters(BuildContext context) {
    showMoods = false;
    showTriggers = false;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setstate) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                      decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Filter',
                                  style: AppTextStyle.displaySmall,
                                ),
                                InkWell(
                                    onTap: () {
                                      selectedTriggers.clear();
                                      selectedEmotions.clear();
                                      selectedRecent = null;
                                      selectedSort = null;
                                      setstate(
                                        () {},
                                      );
                                    },
                                    child: Image.asset('assets/delete.png'))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 30),
                            child: Divider(
                              height: 1,
                              color: AppColors.outline4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Mood',
                                      style: AppTextStyle.bodyLarge,
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    ...List.generate(
                                      selectedEmotions.length,
                                      (index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Image.asset(
                                                selectedEmotions[index]
                                                    .assetFull),
                                          ),
                                        );
                                      },
                                    ),
                                    InkWell(
                                        onTap: () {
                                          showMoods = !showMoods;
                                          setstate(
                                            () {},
                                          );
                                        },
                                        child:
                                            Image.asset('assets/add_mood.png'))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Trigger',
                                      style: AppTextStyle.bodyLarge,
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    ...List.generate(
                                      selectedTriggers.length,
                                      (index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Image.asset(
                                                selectedTriggers[index].asset),
                                          ),
                                        );
                                      },
                                    ),
                                    ...List.generate(
                                      selectedCustomTrigger.length,
                                      (index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Image.asset(
                                                'assets/custom_trigger.png'),
                                          ),
                                        );
                                      },
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showTriggers = !showTriggers;
                                        setstate(
                                          () {},
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            color: AppColors.purple,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.add,
                                          color: AppColors.background,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Divider(
                              height: 1,
                              color: AppColors.outline4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sort by',
                                  style: AppTextStyle.bodyLarge,
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectedSort = ESort.date;
                                                setstate(
                                                  () {},
                                                );
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 9, bottom: 9),
                                                decoration: BoxDecoration(
                                                    color: selectedSort ==
                                                            ESort.date
                                                        ? AppColors.primary
                                                        : AppColors.background,
                                                    border: selectedSort ==
                                                            ESort.date
                                                        ? null
                                                        : Border.all(
                                                            color: AppColors
                                                                .outline4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Text(
                                                  'Date',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle.bodyMedium
                                                      .copyWith(
                                                          color: selectedSort ==
                                                                  ESort.date
                                                              ? AppColors
                                                                  .secondary
                                                              : AppColors
                                                                  .surface),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectedSort = ESort.mood;
                                                setstate(
                                                  () {},
                                                );
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 9, bottom: 9),
                                                decoration: BoxDecoration(
                                                    color: selectedSort ==
                                                            ESort.mood
                                                        ? AppColors.primary
                                                        : AppColors.background,
                                                    border: selectedSort ==
                                                            ESort.mood
                                                        ? null
                                                        : Border.all(
                                                            color: AppColors
                                                                .outline4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Text(
                                                  'Mood',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle.bodyMedium
                                                      .copyWith(
                                                          color: selectedSort ==
                                                                  ESort.mood
                                                              ? AppColors
                                                                  .secondary
                                                              : AppColors
                                                                  .surface),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      if (selectedSort == ESort.mood)
                                        InkWell(
                                          onTap: () {
                                            selectedRecent = ERecent.firstGood;
                                            setstate(
                                              () {},
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 9, 30, 9),
                                            decoration: BoxDecoration(
                                                color: selectedRecent ==
                                                        ERecent.firstGood
                                                    ? AppColors.primary
                                                    : AppColors.background,
                                                border: selectedRecent ==
                                                        ERecent.firstGood
                                                    ? null
                                                    : Border.all(
                                                        color:
                                                            AppColors.outline4),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              'First the good',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.bodyMedium
                                                  .copyWith(
                                                      color: selectedRecent ==
                                                              ERecent.firstGood
                                                          ? AppColors.secondary
                                                          : AppColors.surface),
                                            ),
                                          ),
                                        ),
                                      if (selectedSort == ESort.mood)
                                        const SizedBox(
                                          height: 6,
                                        ),
                                      if (selectedSort == ESort.mood)
                                        InkWell(
                                          onTap: () {
                                            selectedRecent = ERecent.firstBad;
                                            setstate(
                                              () {},
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 9, 30, 9),
                                            decoration: BoxDecoration(
                                                color: selectedRecent ==
                                                        ERecent.firstBad
                                                    ? AppColors.primary
                                                    : AppColors.background,
                                                border: selectedRecent ==
                                                        ERecent.firstBad
                                                    ? null
                                                    : Border.all(
                                                        color:
                                                            AppColors.outline4),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              'First the bad',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.bodyMedium
                                                  .copyWith(
                                                      color: selectedRecent ==
                                                              ERecent.firstBad
                                                          ? AppColors.secondary
                                                          : AppColors.surface),
                                            ),
                                          ),
                                        ),
                                      if (selectedSort == ESort.date)
                                        InkWell(
                                          onTap: () {
                                            selectedRecent =
                                                ERecent.firstRecent;
                                            setstate(
                                              () {},
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 9, 30, 9),
                                            decoration: BoxDecoration(
                                                color: selectedRecent ==
                                                        ERecent.firstRecent
                                                    ? AppColors.primary
                                                    : AppColors.background,
                                                border: selectedRecent ==
                                                        ERecent.firstRecent
                                                    ? null
                                                    : Border.all(
                                                        color:
                                                            AppColors.outline4),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              'First, the recent',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.bodyMedium
                                                  .copyWith(
                                                      color: selectedRecent ==
                                                              ERecent
                                                                  .firstRecent
                                                          ? AppColors.secondary
                                                          : AppColors.surface),
                                            ),
                                          ),
                                        ),
                                      if (selectedSort == ESort.date)
                                        const SizedBox(
                                          height: 6,
                                        ),
                                      if (selectedSort == ESort.date)
                                        InkWell(
                                          onTap: () {
                                            selectedRecent = ERecent.firstPast;
                                            setstate(
                                              () {},
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 9, 30, 9),
                                            decoration: BoxDecoration(
                                                color: selectedRecent ==
                                                        ERecent.firstPast
                                                    ? AppColors.primary
                                                    : AppColors.background,
                                                border: selectedRecent ==
                                                        ERecent.firstPast
                                                    ? null
                                                    : Border.all(
                                                        color:
                                                            AppColors.outline4),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              'First, the past',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.bodyMedium
                                                  .copyWith(
                                                      color: selectedRecent ==
                                                              ERecent.firstPast
                                                          ? AppColors.secondary
                                                          : AppColors.surface),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                'Apply',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.bodyLarge
                                    .copyWith(color: AppColors.secondary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showMoods)
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            border: Border.all(color: AppColors.outline4),
                            borderRadius: BorderRadius.circular(30)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              EEmotions.values.length,
                              (index) {
                                return InkWell(
                                  onTap: () {
                                    if (selectedEmotions
                                        .contains(EEmotions.values[index])) {
                                      selectedEmotions.removeWhere(
                                        (element) =>
                                            element == EEmotions.values[index],
                                      );
                                    } else {
                                      selectedEmotions
                                          .add(EEmotions.values[index]);
                                    }
                                    setstate(
                                      () {},
                                    );
                                  },
                                  child: Image.asset(selectedEmotions
                                          .contains(EEmotions.values[index])
                                      ? EEmotions.values[index].assetFull
                                      : EEmotions.values[index].assetEmpty),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    if (showTriggers)
                      Positioned(
                        bottom: -20,
                        child: Container(
                            width: 300,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.secondary,
                                border: Border.all(color: AppColors.outline4),
                                borderRadius: BorderRadius.circular(30)),
                            child: getAllTriggers(
                                _userController.value.users.first.triggers, () {
                              setstate(
                                () {},
                              );
                            },
                                _userController
                                    .value.users.first.customTriggers)),
                      )
                  ],
                ),
              )
            ],
          );
        });
      },
    );
  }

  Widget getMoods() {
    List<Widget> list = [];
    if (selectedSort == ESort.date) {
      if (selectedRecent == ERecent.firstPast) {
        _moodController.value.moods.sort((a, b) {
          return a.date.compareTo(b.date);
        });
      } else {
        _moodController.value.moods.sort((a, b) {
          return b.date.compareTo(a.date);
        });
      }
    } else if (selectedSort == ESort.mood) {
      if (selectedRecent == ERecent.firstGood) {
        _moodController.value.moods.sort((a, b) {
          return a.emotion.position.compareTo(b.emotion.position);
        });
      } else {
        _moodController.value.moods.sort((a, b) {
          return b.emotion.position.compareTo(a.emotion.position);
        });
      }
    }
    if (selectedEmotions.isNotEmpty && selectedTriggers.isNotEmpty) {
      for (var mood in _moodController.value.moods.where(
        (element) =>
            selectedEmotions.contains(element.emotion) &&
            getTriggersContains(element.triggers),
      )) {
        list.add(Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(color: AppColors.outline4),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      DateFormat("dd MMM, yyyy").format(mood.date),
                      style: AppTextStyle.bodySmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 22, 10, 22),
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      mood.emotion.assetFull,
                      width: 75,
                      height: 45,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getAllTriggers(mood.triggers, () {}, mood.customTriggers),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            mood.note,
                            style: AppTextStyle.bodySmall,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
        list.add(const SizedBox(
          height: 10,
        ));
      }
    } else if (selectedEmotions.isNotEmpty) {
      for (var mood in _moodController.value.moods
          .where((element) => selectedEmotions.contains(element.emotion))) {
        list.add(Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(color: AppColors.outline4),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      DateFormat("dd MMM, yyyy").format(mood.date),
                      style: AppTextStyle.bodySmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 22, 10, 22),
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      mood.emotion.assetFull,
                      width: 75,
                      height: 45,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getAllTriggers(mood.triggers, () {}, mood.customTriggers),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            mood.note,
                            style: AppTextStyle.bodySmall,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
        list.add(const SizedBox(
          height: 10,
        ));
      }
    } else if (selectedTriggers.isNotEmpty ||
        selectedCustomTrigger.isNotEmpty) {
      for (var mood in _moodController.value.moods.where((element) =>
          getTriggersContains(element.triggers) ||
          getCustomTriggersContains(element.customTriggers))) {
        list.add(Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(color: AppColors.outline4),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      DateFormat("dd MMM, yyyy").format(mood.date),
                      style: AppTextStyle.bodySmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 22, 10, 22),
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      mood.emotion.assetFull,
                      width: 75,
                      height: 45,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getAllTriggers(mood.triggers, () {}, mood.customTriggers),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            mood.note,
                            style: AppTextStyle.bodySmall,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
        list.add(const SizedBox(
          height: 10,
        ));
      }
    } else {
      for (var mood in _moodController.value.moods) {
        list.add(Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(color: AppColors.outline4),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      DateFormat("dd MMM, yyyy").format(mood.date),
                      style: AppTextStyle.bodySmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 22, 10, 22),
                    decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      mood.emotion.assetFull,
                      width: 75,
                      height: 45,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getAllTriggers(mood.triggers, () {}, mood.customTriggers),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            mood.note,
                            style: AppTextStyle.bodySmall,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
        list.add(const SizedBox(
          height: 10,
        ));
      }
    }
    if (list.isEmpty) {
      list.add(Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 100),
        child: Image.asset('assets/empty_list.png'),
      ));
      list.add(Container(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        decoration: BoxDecoration(
          color: AppColors.purple,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          'Nothing found by your filters',
          style: AppTextStyle.bodyMedium,
        ),
      ));
    }
    return Column(
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
              if (selectedTriggers.contains(trigger)) {
                selectedTriggers.removeWhere(
                  (element) => element == trigger,
                );
              } else {
                selectedTriggers.add(trigger);
              }
              callBack();
            },
            child: Image.asset(trigger.asset)),
      ));
    }
    customTriggers.forEach(
      (key, value1) {
        list.add(InkWell(
          onTap: () {
            if (selectedCustomTrigger.containsValue(value1)) {
              selectedCustomTrigger.removeWhere(
                (key, value) => value == value1,
              );
            } else {
              selectedCustomTrigger.addAll({key: value1});
            }
            callBack();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/custom_trigger.png'),
              ),
            ],
          ),
        ));
      },
    );
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: list,
    );
  }

  bool getTriggersContains(List<ETriggersType> triggers) {
    List<bool> isContains = [];
    for (var trigger in triggers) {
      if (selectedTriggers.contains(trigger)) {
        isContains.add(true);
      } else {
        isContains.add(false);
      }
    }
    return isContains.contains(true);
  }

  bool getCustomTriggersContains(Map<int, String> triggers) {
    List<bool> isContains = [];
    triggers.forEach(
      (key, value) {
        if (selectedCustomTrigger.containsValue(value)) {
          isContains.add(true);
        } else {
          isContains.add(false);
        }
      },
    );

    return isContains.contains(true);
  }
}
