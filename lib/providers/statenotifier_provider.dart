
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserNotifier extends StateNotifier<User>{
  UserNotifier() : super(
      User(name: '',age: 0),
  );


  void updateName(String n){
    state=state.copyWith(name: n);
  }

  void updateAgee(int n){
    state=state.copyWith(age: n);
  }




}
