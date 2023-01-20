import 'package:bloc/bloc.dart';

import '../../../../core/platfoms/platfoms.dart';
import '../../../../injection/locator.dart';

class OrderCubit extends Cubit<bool> {
  OrderCubit() : super(false);

  Future<void> getValueOrder() async {
    final v = await locator.get<SharedPreferencesManager>().getOrderValue();
    emit(v);
  }

  void setOrder(bool v) async {
    await locator.get<SharedPreferencesManager>().setOrderValue(v);
    emit(v);
  }
}
