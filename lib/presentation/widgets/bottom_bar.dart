import 'package:flutter/material.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/presentation/pages/mood/pages/mood_list_view.dart';
import 'package:tt_5/presentation/pages/settings_view.dart';
import 'package:tt_5/presentation/pages/stats_view.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    required this.page,
  });
  final EPageOnSelect page;

  @override
  State<BottomBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteNames.main,
                (route) => false,
              );
              setState(() {});
            },
            child: SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.page == EPageOnSelect.homePage
                          ? 'assets/main1.png'
                          : 'assets/main2.png',
                    ),
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MoodListView()),
                  (route) => false);
              setState(() {});
            },
            child: SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.page == EPageOnSelect.listPage
                          ? 'assets/list1.png'
                          : 'assets/list2.png',
                    ),
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const StatsView()),
                  (route) => false);
              setState(() {});
            },
            child: SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.page == EPageOnSelect.statistics
                          ? 'assets/stats1.png'
                          : 'assets/stats2.png',
                    ),
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsView()),
                  (route) => false);
              setState(() {});
            },
            child: SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.page == EPageOnSelect.settingsPage
                          ? 'assets/settings1.png'
                          : 'assets/settings2.png',
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
