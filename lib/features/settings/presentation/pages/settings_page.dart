import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/const/colors.dart';
import 'package:weather_app/features/main_ui/presentation/pages/texts_main_ui.dart';
import 'package:weather_app/features/settings/presentation/cubit/settings_order_cubit.dart';

import 'package:sizer/sizer.dart';
import 'package:weather_app/features/settings/presentation/pages/text_settings.dart';
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
              appBarSettings,
              style: TextStyle(
                color: textTitleColor,
                fontSize: 30.sp,
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
                        '$appTitle v1.0.0',
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
                                animationText,
                                style: TextStyle(
                                  color: textTitleColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                animationSource,
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
                                iconText,
                                style: TextStyle(
                                  color: textTitleColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                iconSource,
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
                            closedButtonText,
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
                        switchGradesTitle,
                        style: _titleTextStyle(),
                      ),
                      subtitle: Text(
                        switchGradeSubtitle,
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
                        switchInvertDaysTitle,
                        style: _titleTextStyle(),
                      ),
                      subtitle: Text(
                        style: _subTitleTextStyle(),
                        switchInvertSubtitle,
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
      fontSize: 14.sp,
    );
  }

  TextStyle _titleTextStyle() {
    return TextStyle(
      color: textTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
    );
  }
}
