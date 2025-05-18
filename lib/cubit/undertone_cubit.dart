import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:p13/model/undertone_model.dart';

part 'undertone_state.dart';

class UndertoneCubit extends Cubit<UndertoneState> {
  UndertoneCubit() : super(UndertoneInitial());

 
  var hiveData = Hive.box<UndertoneModel>("undertone");  // Open a local Hive database (box) to store undertone data locally on the device
  fun(UndertoneModel undertone) async {
    try {
      await hiveData.add(undertone);
      emit(UndertoneSuccessed());
    } catch (e) {
      emit(UndertoneFailed());
    }
  }
}
