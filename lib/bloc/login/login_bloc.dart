import 'package:bloc/bloc.dart';
import 'package:chatly/bloc/login/login_event.dart';
import 'package:chatly/bloc/login/login_state.dart';
import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/utils/constants/enums.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final HiveService hiveService;
  LoginBloc()
      : hiveService = HiveService(),
        super(const LoginState()) {
    on<LoginPhoneNumberChanged>(_onPhoneNumberChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginClearFieldOnNavigation>(_onClearFields);
  }

  void _onClearFields(
    LoginClearFieldOnNavigation event,
    Emitter<LoginState> emit,
  ) {
    emit(const LoginState());
  }

  void _onPhoneNumberChanged(
    LoginPhoneNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        number: event.phoneNumber,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.inProgress,
      ),
    );

    final user = await hiveService.getUser(state.number);

    if (user == null || user.password != state.password) {
      print("USER PSSWD ${user?.password}   staet passwd ${state.password}");
      emit(state.copyWith(
        formStatus: FormStatus.failure,
        errorMessage: 'Invalid username or password',
      ));
      return;
    }

    emit(state.copyWith(formStatus: FormStatus.success));
  }
}
