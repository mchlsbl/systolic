import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:systolic/components/page_template.dart';
import 'package:systolic/main.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      pageTitle: AppLocalizations.of(context)!.overview,
      pageContent: centerText('Work in Progress.'),
    );
  }
}
