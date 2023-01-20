import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/const/text_styles.dart';
import 'package:weather_app/features/settings/presentation/cubit/settings_order_cubit.dart';

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
          children: [
            Text('Settings'),
            Icon(Icons.settings),
          ],
        ),
        backgroundColor: Colors.white60,
        leading: IconButton(
            onPressed: () {
              context.go('/main');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Color.fromRGBO(32, 35, 41, 1),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                color: Colors.grey.shade400,
                shadowColor: Colors.white24,
                child: BlocBuilder<UnitCubit, bool>(
                  builder: (context, state) {
                    return SwitchListTile(
                      title: const Text(
                        'Receive values in °C?',
                        style: testBold,
                      ),
                      subtitle: const Text(
                          style: test1,
                          textAlign: TextAlign.left,
                          'If it is activated, it receives the temperature values in degrees Celsius, otherwise it receives them in Fahrenheit.'),
                      activeColor: Colors.white,
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
                color: Colors.grey.shade400,
                shadowColor: Colors.white24,
                child: BlocBuilder<OrderCubit, bool>(
                  builder: (context, state) {
                    return SwitchListTile(
                      title: const Text(
                        'Ascending/Descending',
                        style: testBold,
                      ),
                      subtitle: const Text(
                          style: test1,
                          'If you activate this option, you will see the forecast for the next few days in ascending or descending order.'),
                      activeColor: Colors.green,
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
}