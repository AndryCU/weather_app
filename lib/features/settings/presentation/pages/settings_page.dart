import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/const/colors.dart';
import 'package:weather_app/features/settings/presentation/cubit/settings_order_cubit.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import '../../../../injection/locator.dart';
import '../cubit/settings_unit_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool unitValue, orderValue;
  @override
  void initState() {
    unitValue =
        locator.get<SharedPreferences>().getBool('units_value') ?? false;
    orderValue =
        locator.get<SharedPreferences>().getBool('order_days') ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppLocalizations.of(context)!.appBarSettings,
              style: TextStyle(
                color: textTitleColor,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
        backgroundColor: scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: iconColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: cardBackgroundColor,
                      title: Text(
                        AppLocalizations.of(context)!.appVersion('1.0.0'),
                        style: TextStyle(
                          color: textTitleColor,
                          fontSize: 13.sp,
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 80.w,
                            height: 10.h,
                            child: ListTile(
                              title: Text(
                                AppLocalizations.of(context)!.animationText,
                                style: TextStyle(
                                  color: textTitleColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                'https://lottiefiles.com/',
                                style: TextStyle(
                                  color: cardSubtitleColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80.w,
                            height: 10.h,
                            child: ListTile(
                              title: Text(
                                AppLocalizations.of(context)!.iconText,
                                style: TextStyle(
                                  color: textTitleColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                'https://www.flaticon.com/free-icons/sunset',
                                style: TextStyle(
                                  color: cardSubtitleColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.closedButtonText,
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.info_outline))
        ],
      ),
      backgroundColor: scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                color: cardBackgroundColor,
                shadowColor: Colors.white24,
                child: BlocBuilder<UnitCubit, bool>(
                  builder: (context, state) {
                    return SwitchListTile(
                      title: Text(
                        AppLocalizations.of(context)!.switchGradesTitle,
                        style: _titleTextStyle(),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context)!.switchGradeSubtitle,
                        style: _subTitleTextStyle(),
                        textAlign: TextAlign.left,
                      ),
                      activeColor: switchActivateColor,
                      value: unitValue,
                      onChanged: (value) {
                        unitValue = value;
                        context.read<UnitCubit>().setUnit(value);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                elevation: 40,
                color: cardBackgroundColor,
                //shadowColor: Colors.white24,
                child: BlocBuilder<OrderCubit, bool>(
                  builder: (context, state) {
                    return SwitchListTile(
                      title: Text(
                        AppLocalizations.of(context)!.switchInvertDaysTitle,
                        style: _titleTextStyle(),
                      ),
                      subtitle: Text(
                        style: _subTitleTextStyle(),
                        AppLocalizations.of(context)!.switchInvertSubtitle,
                      ),
                      activeColor: switchActivateColor,
                      value: orderValue,
                      onChanged: (value) {
                        orderValue = value;
                        context.read<OrderCubit>().setOrder(value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _subTitleTextStyle() {
    return TextStyle(
      color: textTitleColor,
      fontSize: 13.sp,
    );
  }

  TextStyle _titleTextStyle() {
    return TextStyle(
      color: textTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 15.sp,
    );
  }
}
