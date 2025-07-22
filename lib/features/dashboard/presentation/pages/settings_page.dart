import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';
import 'package:sinflix/core/extensions.dart';
import 'package:sinflix/core/navigation/app_router.dart' show LoginRoute;
import '/features/auth/presentation/bloc/auth_bloc.dart';
import '/features/theme/presentation/bloc/theme_cubit.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: Text('settings.theme'.tr()),
              trailing: CupertinoSwitch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (val) {
                  final cubit = context.read<ThemeCubit>();
                  cubit.changeTheme(val ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text('settings.language'.tr()),
              subtitle: Text(context.locale.languageCode == 'tr' ? 'Türkçe' : 'English'),
              onTap: () async {
                final selectedLocale = await showModalBottomSheet<Locale>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    final supportedLocales = context.supportedLocales;
                    final currentLocale = context.locale;
                    return ListView(
                      shrinkWrap: true,
                      children: supportedLocales.map((locale) {
                        final isSelected = locale == currentLocale;
                        return ListTile(
                          leading: Icon(isSelected ? Icons.check_circle : Icons.circle_outlined),
                          title: Text(locale.languageCode == 'tr' ? 'Türkçe' : 'English'),
                          onTap: () {
                            Navigator.of(context).pop(locale);
                          },
                        );
                      }).toList(),
                    );
                  },
                );
                if (selectedLocale != null && selectedLocale != context.locale) {
                  await context.setLocale(selectedLocale);
                  setState(() {});
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('settings.logout'.tr()),
              onTap: () {
                context.read<AuthBloc>().add(const LogoutEvent());
                context.router.replace(LoginRoute());
              },
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SinFlix 2025'.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(color: context.textTheme.bodyMedium?.color?.withValues(alpha: 0.7)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
