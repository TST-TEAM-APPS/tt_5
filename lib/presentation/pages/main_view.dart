import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tt_5/business/helpers/arguments.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/model/mood.dart';
import 'package:tt_5/business/model/user.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/presentation/pages/mood/controllers/mood_controller.dart';
import 'package:tt_5/presentation/pages/user/controllers/user_controller.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';
import 'package:tt_5/presentation/widgets/bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  DateTime selectedDate = DateTime.now();
  late final MoodController _moodController;
  late final UserController _userController;
  Mood? mood;
  void _init() {
    _moodController = MoodController();
    _userController = UserController();
    currentMood();
  }

  void currentMood() {
    if (_moodController.value.moods.isNotEmpty) {
      mood = _moodController.value.moods.firstWhereOrNull(
        (element) =>
            element.date.day == selectedDate.day &&
            element.date.month == selectedDate.month,
      );
    } else {
      mood = null;
    }
  }

  Future<void> _deleteGoal(Mood mood) async {
    await _moodController.delete(mood);
    currentMood();
    setState(() {});
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 65),
                      child: TableCalendar(
                        selectedDayPredicate: (day) =>
                            isSameDay(day, selectedDate),
                        onDaySelected: (date, datetime) {
                          selectedDate = date;
                          currentMood();
                          setState(() {});
                        },
                        daysOfWeekHeight: 30,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: AppTextStyle.bodyMedium
                              .copyWith(color: AppColors.onBackground),
                          weekendStyle: AppTextStyle.bodyMedium
                              .copyWith(color: AppColors.onBackground),
                        ),
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                            if (_moodController.value.moods
                                .where(
                                  (element) =>
                                      element.date.day == day.day &&
                                      element.date.month == day.month,
                                )
                                .isNotEmpty) {
                              return Image.asset(
                                _moodController.value.moods
                                    .firstWhere(
                                      (element) =>
                                          element.date.day == day.day &&
                                          element.date.month == day.month,
                                    )
                                    .emotion
                                    .assetFull,
                                height: 25,
                              );
                            } else {
                              return InkWell(
                                  onTap: () => Navigator.of(context).pushNamed(
                                      RouteNames.addMoodView,
                                      arguments: AddMoodViewArgs(
                                          userController: _userController,
                                          isEdit: false,
                                          moodController: _moodController,
                                          null,
                                          day)),
                                  child: Image.asset('assets/add_mood.png'));
                            }

                            // if (dates.contains(day)) {
                            //   return Image.asset('assets/full_check.png');
                            // } else {
                            //   return Image.asset('assets/empty_check.png');
                            // }
                          },
                        ),
                        rowHeight: 65,
                        headerStyle: HeaderStyle(
                            decoration: const BoxDecoration(),
                            formatButtonVisible: false,
                            rightChevronIcon: Icon(
                              Icons.chevron_right,
                              color: AppColors.outline1,
                            ),
                            leftChevronIcon: Icon(
                              Icons.chevron_left,
                              color: AppColors.outline1,
                            ),
                            titleCentered: true,
                            titleTextStyle: AppTextStyle.displayMedium),
                        calendarStyle: const CalendarStyle(
                          markersAlignment: Alignment.topCenter,
                          outsideDaysVisible: false,
                          weekendTextStyle: AppTextStyle.bodyMedium,
                          selectedTextStyle: AppTextStyle.bodyMedium,
                          selectedDecoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle),
                          todayTextStyle: AppTextStyle.bodyMedium,
                          defaultTextStyle: AppTextStyle.bodyMedium,
                          todayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
                        ),
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: selectedDate,
                        locale: 'en_US',
                      ),
                    ),
                    if (mood == null)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Image.asset('assets/empty.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    'You haven\'t added any records',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.bodyMedium.copyWith(
                                        color: AppColors.onBackground),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    if (mood != null)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  DateFormat("dd MMMM").format(mood!.date),
                                  style: AppTextStyle.bodyLarge,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          deleteDialog(context);
                                        },
                                        child:
                                            Image.asset('assets/delete.png')),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(RouteNames.addMoodView,
                                                arguments: AddMoodViewArgs(
                                                    userController:
                                                        _userController,
                                                    isEdit: true,
                                                    moodController:
                                                        _moodController,
                                                    mood,
                                                    null)),
                                        child: Image.asset('assets/edit.png'))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Image.asset(
                              mood!.emotion.assetFull,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: getAllTriggers(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AppColors.background,
                                  border: Border.all(color: AppColors.outline4),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                mood!.note,
                                style: AppTextStyle.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              const BottomBar(
                page: EPageOnSelect.homePage,
              ),
              Positioned(
                top: -40,
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      RouteNames.addMoodView,
                      arguments: AddMoodViewArgs(
                          userController: _userController,
                          isEdit: false,
                          moodController: _moodController,
                          null,
                          selectedDate)),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 10, color: AppColors.background)),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dialog(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'Are you sure you want to delete the notes that day?',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyLarge,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    'No',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.bodyLarge
                                        .copyWith(color: AppColors.secondary),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  await _deleteGoal(mood!);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    'Yes',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.bodyLarge
                                        .copyWith(color: AppColors.secondary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: -20,
                    child: Image.asset('assets/delete_dialog.png'),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget getAllTriggers() {
    List<Widget> list = [];
    for (var trigger in mood!.triggers) {
      list.add(Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Image.asset(trigger.asset),
          ),
          SizedBox(
            width: 60,
            child: Text(
              trigger.label,
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium,
            ),
          )
        ],
      ));
    }
    mood!.customTriggers.forEach(
      (key, value) {
        list.add(Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.asset('assets/custom_trigger.png'),
            ),
            SizedBox(
              width: 60,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyMedium,
              ),
            )
          ],
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
