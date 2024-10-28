import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tt_5/business/helpers/email_helper.dart';
import 'package:tt_5/business/helpers/text_helper.dart';
import 'package:tt_5/business/services/navigation/route_names.dart';
import 'package:tt_5/presentation/widgets/app_button.dart';

enum AgreementType {
  privacy,
  terms,
}

class AgreementView extends StatefulWidget {
  final AgreementViewArguments arguments;

  const AgreementView({super.key, required this.arguments});

  factory AgreementView.create(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as AgreementViewArguments;
    return AgreementView(arguments: arguments);
  }

  @override
  State<AgreementView> createState() => _AgreementViewState();
}

class _AgreementViewState extends State<AgreementView> {
  AgreementType get _agreementType => widget.arguments.agreementType;

  bool get _usePrivacyAgreement => widget.arguments.usePrivacyAgreement;

  String get _agreementText => _agreementType == AgreementType.privacy
      ? TextHelper.privacy
      : TextHelper.terms;

  String get _title => _agreementType == AgreementType.privacy
      ? 'Privacy Policy'
      : 'Terms Of Use';

  void _accept() {
    Navigator.of(context).pushReplacementNamed(RouteNames.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_usePrivacyAgreement)
                      Text(
                        _title,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.onSurface),
                      )
                    else
                      Row(
                        children: [
                          CupertinoButton(
                            minSize: 10,
                            padding: EdgeInsets.zero,
                            child: const Icon(Icons.chevron_left),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const Spacer(),
                          Text(
                            _agreementType == AgreementType.privacy
                                ? 'Privacy Policy'
                                : 'Terms of Use',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                          const Spacer(),
                          const SizedBox(width: 30),
                        ],
                      ),
                    const SizedBox(height: 13),
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom: _usePrivacyAgreement ? 90 : 60,
                          ),
                          physics: const BouncingScrollPhysics(),
                          child: MarkdownBody(
                            styleSheet: MarkdownStyleSheet(
                              p: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              a: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              code: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              checkbox: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              em: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              del: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              listBullet: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              h1: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              h2: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                              h3: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                              h4: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                            data: _agreementText,
                            onTapLink: (text, href, title) =>
                                EmailHelper.launchEmailSubmission(
                              toEmail: 'omelshs7368ksgdu@icloud.com',
                              subject: '',
                              body: '',
                              errorCallback: () {},
                              doneCallback: () {},
                            ),
                            selectable: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_usePrivacyAgreement)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AppButton(
                      label: 'Accept app privacy',
                      callback: _accept,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AgreementViewArguments {
  final AgreementType agreementType;
  final bool usePrivacyAgreement;

  AgreementViewArguments({
    required this.agreementType,
    this.usePrivacyAgreement = false,
  });
}
