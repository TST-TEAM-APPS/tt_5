import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt_5/business/helpers/arguments.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/model/user.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/presentation/pages/user/controllers/user_controller.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';
import 'package:uuid/uuid.dart';

class ChooseTriggersView extends StatefulWidget {
  const ChooseTriggersView({super.key, required this.args});
  final ChooseTriggersViewArgs args;

  @override
  State<ChooseTriggersView> createState() => _ChooseTriggersViewState();
}

class _ChooseTriggersViewState extends State<ChooseTriggersView> {
  late final UserController _userController;
  List<ETriggersType> selectedTriggers = [];
  void _init() {
    _userController = UserController();
    if (widget.args.isEdit) {
      selectedTriggers.addAll(_userController.value.users.first.triggers);
    }
  }

  Future<void> _save() async {
    final newUser = User(
        id: const Uuid().v1(),
        triggers: selectedTriggers,
        customTriggers: const {});
    await _userController.create(newUser);

    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.main,
      (route) => false,
    );
  }

  Future<void> _edit() async {
    final newUser = User(
        id: _userController.value.users.first.id,
        triggers: selectedTriggers,
        customTriggers: _userController.value.users.first.customTriggers);
    await _userController.edit(_userController.value.users.first, newUser);

    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteNames.settings,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 65, 16, 30),
                child: Row(
                  children: [
                    Image.asset('assets/small_cloud.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    const Flexible(
                        child: Text(
                      'Select the triggers you want to monitor',
                      style: AppTextStyle.displayMedium,
                    ))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [getTriggers()],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              right: 16,
              bottom: 30,
              child: InkWell(
                  onTap: widget.args.isEdit ? _edit : _save,
                  child: Image.asset('assets/next.png'))),
        ],
      ),
    );
  }

  Widget getTriggers() {
    List<Widget> list = [];
    var triggersMap = groupBy(
      ETriggersType.values,
      (e) {
        return e.position;
      },
    );
    triggersMap.forEach(
      (key, value) {
        list.add(InkWell(
          onTap: () {
            if (selectedTriggers.contains(value.firstWhere(
              (element) => element.position == key,
            ))) {
              selectedTriggers.removeWhere(
                (element) => element.position == key,
              );
            } else {
              selectedTriggers.addAll(value);
            }
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.secondary,
                border: Border.all(
                    width: 2,
                    color: selectedTriggers.contains(value.firstWhere(
                      (element) => element.position == key,
                    ))
                        ? AppColors.outline3
                        : AppColors.outline4),
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
    if (_userController.value.users.isNotEmpty) {
      _userController.value.users.first.customTriggers.forEach(
        (key, value1) {
          if (key == position) {
            list.add(Column(
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
            ));
          }
        },
      );
    }
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: list,
    );
  }
}
