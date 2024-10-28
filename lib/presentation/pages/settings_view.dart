import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:tt_5/business/helpers/arguments.dart';
import 'package:tt_5/business/helpers/contact_dialog.dart';
import 'package:tt_5/business/helpers/dialog_helper.dart';
import 'package:tt_5/business/helpers/enums.dart';
import 'package:tt_5/business/services/config_service.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/presentation/themes/app_colors.dart';
import 'package:tt_5/presentation/themes/app_text_style.dart';
import 'package:tt_5/presentation/widgets/bottom_bar.dart';
import 'package:tt_5/presentation/widgets/settings_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _configService = GetIt.instance<ConfigService>();

  void _showAppVersionDialog(BuildContext context) =>
      DialogHelper.showAppVersionDialog(context);

  Future<void> _rate() async {
    if (await InAppReview.instance.isAvailable()) {
      await InAppReview.instance.requestReview();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 65, 16, 34),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Settings',
                  style: AppTextStyle.displayMedium,
                ),
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
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushNamed(
                            RouteNames.chooseTriggersView,
                            arguments: ChooseTriggersViewArgs(isEdit: true)),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Image.asset('assets/small_cloud.png'),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Trigger Categories',
                                style: AppTextStyle.bodyLarge
                                    .copyWith(color: AppColors.secondary),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SettingsWidget(
                          label: 'Contact us',
                          callback: () => showCupertinoDialog(
                                context: context,
                                builder: (context) => const ContactDialog(),
                              )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SettingsWidget(
                          label: 'Rate us', callback: () => _rate()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SettingsWidget(
                        label: 'Version',
                        callback: () => _showAppVersionDialog(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SettingsWidget(
                        label: 'Terms of Use',
                        callback: () => launchUrl(
                          Uri.parse(_configService.termsLink),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SettingsWidget(
                        label: 'Privacy Policy',
                        callback: () => launchUrl(
                          Uri.parse(_configService.privacyLink),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const BottomBar(
            page: EPageOnSelect.settingsPage,
          )
        ],
      ),
    );
  }
}
