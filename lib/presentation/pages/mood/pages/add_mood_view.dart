import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tt_5/business/helpers/arguments.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/model/mood.dart';
import 'package:tt_5/business/model/user.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/presentation/pages/user/controllers/user_controller.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';
import 'package:tt_5/presentation/widgets/app_text_field.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class AddMoodView extends StatefulWidget {
  const AddMoodView({super.key, required this.args});
  final AddMoodViewArgs args;

  @override
  State<AddMoodView> createState() => _AddMoodViewState();
}

class _AddMoodViewState extends State<AddMoodView> {
  DateTime selectedDate = DateTime.now();
  DateTime changeDate = DateTime.now();
  late final UserController _userController;
  EEmotions? selectedEmotion;
  List<ETriggersType> selectedTriggers = [];
  late final TextEditingController _note;
  late final TextEditingController _triggerName;
  bool _buttonState = false;
  Map<int, String> customTrigger = {};
  Map<int, String> selectedCustomTrigger = {};
  void _init() {
    _note = TextEditingController()..addListener(_updateButton);
    _triggerName = TextEditingController();
    _userController = UserController();
    customTrigger.addAll(_userController.value.users.first.customTriggers);
    if (!widget.args.isEdit) {
      selectedDate = widget.args.date!;
    } else {
      selectedDate = widget.args.mood!.date;
      selectedEmotion = widget.args.mood!.emotion;
      selectedTriggers.addAll(widget.args.mood!.triggers);
      _note.text = widget.args.mood!.note;
    }
  }

  Future<void> _save() async {
    final newMood = Mood(
        id: const Uuid().v1(),
        date: selectedDate,
        triggers: selectedTriggers,
        emotion: selectedEmotion!,
        note: _note.text,
        customTriggers: selectedCustomTrigger);
    final newUser = User(
        id: _userController.value.users.first.id,
        triggers: _userController.value.users.first.triggers,
        customTriggers: customTrigger);
    await _userController.edit(_userController.value.users.first, newUser);
    await widget.args.moodController.create(newMood);

    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.main,
      (route) => false,
    );
  }

  Future<void> _edit() async {
    final newMood = Mood(
        id: widget.args.mood!.id,
        date: selectedDate,
        triggers: selectedTriggers,
        emotion: selectedEmotion!,
        note: _note.text,
        customTriggers: selectedCustomTrigger);
    final newUser = User(
        id: _userController.value.users.first.id,
        triggers: _userController.value.users.first.triggers,
        customTriggers: customTrigger);
    await _userController.edit(_userController.value.users.first, newUser);
    await widget.args.moodController.edit(widget.args.mood!, newMood);

    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.main,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _updateButton() {
    if (_note.text.isNotEmpty &&
        selectedEmotion != null &&
        selectedTriggers.isNotEmpty) {
      setState(() {
        _buttonState = true;
      });
    } else {
      setState(() {
        _buttonState = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 65, 16, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset('assets/back.png')),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder: (contex, setstate) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          TableCalendar(
                                            selectedDayPredicate: (day) =>
                                                isSameDay(day, changeDate),
                                            daysOfWeekHeight: 30,
                                            daysOfWeekStyle: DaysOfWeekStyle(
                                              weekdayStyle: AppTextStyle
                                                  .bodyMedium
                                                  .copyWith(
                                                      color: AppColors
                                                          .onBackground),
                                              weekendStyle: AppTextStyle
                                                  .bodyMedium
                                                  .copyWith(
                                                      color: AppColors
                                                          .onBackground),
                                            ),
                                            onDaySelected:
                                                (selectedDay, focusedDay) {
                                              changeDate = selectedDay;
                                              setstate(
                                                () {},
                                              );
                                            },
                                            rowHeight: 35,
                                            headerStyle: HeaderStyle(
                                                decoration:
                                                    const BoxDecoration(),
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
                                                titleTextStyle:
                                                    AppTextStyle.displayMedium),
                                            calendarStyle: const CalendarStyle(
                                              markersAlignment:
                                                  Alignment.topCenter,
                                              outsideDaysVisible: false,
                                              weekendTextStyle:
                                                  AppTextStyle.bodyMedium,
                                              selectedTextStyle:
                                                  AppTextStyle.bodyMedium,
                                              selectedDecoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  shape: BoxShape.circle),
                                              todayTextStyle:
                                                  AppTextStyle.bodyMedium,
                                              defaultTextStyle:
                                                  AppTextStyle.bodyMedium,
                                              todayDecoration: BoxDecoration(
                                                  shape: BoxShape.circle),
                                            ),
                                            firstDay:
                                                DateTime.utc(2010, 10, 16),
                                            lastDay: DateTime.utc(2030, 3, 14),
                                            focusedDay: changeDate,
                                            locale: 'en_US',
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: InkWell(
                                              onTap: () {
                                                selectedDate = changeDate;
                                                setState(
                                                  () {
                                                    Navigator.pop(contex);
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Text(
                                                  'Apply',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle.bodyLarge
                                                      .copyWith(
                                                          color: AppColors
                                                              .secondary),
                                                ),
                                              ),
                                            ),
                                          )
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
                      child: Row(
                        children: [
                          Image.asset('assets/calendar.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateFormat("dd MMMM").format(selectedDate),
                            style: AppTextStyle.bodyLarge
                                .copyWith(color: AppColors.primary),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    )
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
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Text(
                                    'How was your day?',
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
                                        return InkWell(
                                          onTap: () {
                                            selectedEmotion =
                                                EEmotions.values[index];
                                            _updateButton();
                                            setState(() {});
                                          },
                                          child: Image.asset(selectedEmotion ==
                                                  EEmotions.values[index]
                                              ? EEmotions
                                                  .values[index].assetFull
                                              : EEmotions
                                                  .values[index].assetEmpty),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'Mark the triggers for the day',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: getTriggers(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'Add notes',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: AppTextField(
                            controller: _note,
                            maxLines: 4,
                            placeholder:
                                'What was the condition, what did you experience, what made you....',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          if (_buttonState)
            Positioned(
              right: 16,
              bottom: 30,
              child: InkWell(
                  onTap: widget.args.isEdit ? _edit : _save,
                  child: Image.asset('assets/next.png')),
            ),
        ],
      ),
    );
  }

  Widget getTriggers() {
    List<Widget> list = [];
    var triggersMap = groupBy(
      widget.args.userController.value.users.first.triggers,
      (e) {
        return e.position;
      },
    );
    triggersMap.forEach(
      (key, value) {
        list.add(Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.secondary,
              border: Border.all(width: 2, color: AppColors.outline4),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  key == 1
                      ? 'People'
                      : key == 2
                          ? 'Health'
                          : key == 3
                              ? 'Weather'
                              : key == 4
                                  ? 'Meals'
                                  : 'Habits',
                  style: AppTextStyle.displaySmall,
                ),
              ),
              getAllTriggers(value, key)
            ],
          ),
        ));

        list.add(const SizedBox(
          height: 10,
        ));
      },
    );
    return Column(
      children: list,
    );
  }

  Widget getAllTriggers(List<ETriggersType> triggers, int position) {
    List<Widget> list = [];
    for (var trigger in triggers) {
      list.add(InkWell(
        onTap: () {
          if (selectedTriggers.contains(trigger)) {
            selectedTriggers.removeWhere(
              (element) => element == trigger,
            );
          } else {
            selectedTriggers.add(trigger);
          }
          _updateButton();
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: selectedTriggers.contains(trigger)
              ? const BoxDecoration(
                  color: AppColors.background, shape: BoxShape.circle)
              : null,
          child: Column(
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
          ),
        ),
      ));
    }
    customTrigger.forEach(
      (key, value1) {
        if (key == position) {
          list.add(InkWell(
            onTap: () {
              if (selectedCustomTrigger.containsValue(value1)) {
                selectedCustomTrigger.removeWhere(
                  (key, value) {
                    return value == value1;
                  },
                );
              } else {
                selectedCustomTrigger.addAll({key: value1});
              }
              _updateButton();
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: selectedCustomTrigger.containsValue(value1)
                  ? const BoxDecoration(
                      color: AppColors.background, shape: BoxShape.circle)
                  : null,
              child: Column(
                children: [
                  Image.asset('assets/custom_trigger.png'),
                  SizedBox(
                    width: 60,
                    child: Text(
                      value1,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
          ));
        }
      },
    );
    list.add(
      InkWell(
        onTap: () {
          _triggerName.text = '';
          showDialog(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Dialog(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                      decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text(
                              'Add trigger',
                              style: AppTextStyle.displaySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: AppTextField(
                              controller: _triggerName,
                              placeholder: 'Name',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              customTrigger
                                  .addAll({position: _triggerName.text});
                              setState(() {});
                              print(customTrigger);
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
                  )
                ],
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: AppColors.purple, shape: BoxShape.circle),
          child: const Icon(
            Icons.add,
            color: AppColors.background,
          ),
        ),
      ),
    );
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: list,
    );
  }
}
