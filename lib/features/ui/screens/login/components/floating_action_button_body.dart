import 'package:expatrio_tax_task/core/core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class FloatingActionButtonBody extends StatelessWidget {
  const FloatingActionButtonBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () async {
        final Uri url = Uri.parse('https://www.expatrio.com');
        await launchUrl(url);
      },
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(Icons.question_mark_outlined, color: Theme.of(context).colors.primary, size: 16),
          Text(
            getTranslatedValue(context, 'help'),
            style: TextStyle(fontSize: 12, color: Theme.of(context).colors.primary),
          ),
        ],
      ),
    );
  }
}
