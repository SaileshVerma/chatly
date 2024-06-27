import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/models/user.dart';
import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/utils/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignupEvent, SignupState> {
  final HiveService hiveService;

  SignUpBloc()
      : hiveService = HiveService(),
        super(SignupState()) {
    on<SignupPhoneNumberChanged>(_onPhoneNumberChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupNameChanged>(_onNameChanged);
    on<SignupSubmitted>(_onSubmitted);
    on<SignupClearFieldOnNavigation>(_onClearFields);
  }

  void _onClearFields(
    SignupClearFieldOnNavigation event,
    Emitter<SignupState> emit,
  ) {
    emit(const SignupState());
  }

  void _onPhoneNumberChanged(
    SignupPhoneNumberChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        number: event.phoneNumber,
      ),
    );
  }

  void _onPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _onNameChanged(
    SignupNameChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.name,
      ),
    );
  }

  void _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(
      state.copyWith(
        formStatus: FormStatus.inProgress,
      ),
    );

    //checking existing user
    final existingUser = await hiveService.getUser(state.number);

    if (existingUser != null) {
      emit(
        state.copyWith(
          formStatus: FormStatus.failure,
          errorMessage: 'User already exists',
        ),
      );

      return;
    }

    final user = User(
      number: state.number,
      name: state.name,
      password: state.password,
    );

    await hiveService.addUser(user);

    emit(
      state.copyWith(
        formStatus: FormStatus.success,
      ),
    );
  }
}
