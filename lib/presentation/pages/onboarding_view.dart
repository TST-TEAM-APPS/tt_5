import 'package:flutter/material.dart';
import 'package:tt_5/business/helpers/arguments.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  ValueNotifier page = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              if (page.value == 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      'assets/wheel.png'),
                ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        if (page.value == 0)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Welcome to MoodMonitor',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.displayMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (page.value == 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: Text(
                                  'your personalized emotion management assistant',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.displaySmall
                                      .copyWith(color: AppColors.onBackground),
                                )),
                              ],
                            ),
                          ),
                        if (page.value == 1)
                          Padding(
                            padding: const EdgeInsets.only(top: 65, bottom: 10),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  border: Border.all(color: AppColors.outline4),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Text(
                                'Regular mood fixation',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.displayMedium,
                              ),
                            ),
                          ),
                        if (page.value == 1)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 108,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                'Analyzing emotional patterns and triggers',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.displayMedium
                                    .copyWith(color: AppColors.secondary),
                              ),
                            ),
                          ),
                        if (page.value == 2)
                          Padding(
                            padding: const EdgeInsets.only(top: 65, bottom: 88),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  border: Border.all(color: AppColors.outline4),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Text(
                                'Start taking control of your mood and work on improving your emotional well-being today!',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.displayMedium,
                              ),
                            ),
                          ),
                        Image.asset(page.value == 0
                            ? 'assets/onboarding1.png'
                            : page.value == 1
                                ? 'assets/onboarding2.png'
                                : 'assets/onboarding3.png')
                      ],
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
                onTap: () => next(), child: Image.asset('assets/next.png')),
          ),
        ],
      ),
    );
  }

  void next() {
    if (page.value < 2) {
      page.value++;
      setState(() {});
    } else {
      Navigator.of(context).pushNamed(RouteNames.chooseTriggersView,
          arguments: ChooseTriggersViewArgs(isEdit: false));
    }
  }
}
