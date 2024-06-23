import 'package:bloc/bloc.dart';
import 'package:frist_pages/dataLayer/dataBase.dart';
import 'package:frist_pages/dataLayer/model/user.dart';
import 'package:meta/meta.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  int? userId;
  DataBaseHandler db=DataBaseHandler();

   UserCubit() : super(UserInitialState());

  Future<void> signUp(User user) async {
    try {
      User signedUpUser = await db.signUp(user);
      emit(UserSingUpState());
    } catch (e) {
      emit(UserErrorState('Failed to sign up (May this Email Already Exist)'));
    }
  }


  Future<void>login(String email, String password) async {
    try {
      this.userId = await db.login(email, password);
      if (userId != 0) {
        emit(UserLoginDoneState(this.userId));
      } else {
        emit(UserLoginFailedState());
      }
    } catch (e) {
      emit(UserErrorState('Failed to log in'));
    }
  }
  
}
