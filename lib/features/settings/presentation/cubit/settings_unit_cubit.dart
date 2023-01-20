import 'package:bloc/bloc.dart';

import '../../../../core/platfoms/platfoms.dart';
import '../../../../injection/locator.dart';

class UnitCubit extends Cubit<bool> {
  UnitCubit() : super(false);

  Future<void> getValue() async {
    final v = await locator.get<SharedPreferencesManager>().getUnitValue();
    emit(v);
  }

  void setUnit(bool v) async {
    await locator.get<SharedPreferencesManager>().setUnitValue(v);
    emit(v);
  }
}
