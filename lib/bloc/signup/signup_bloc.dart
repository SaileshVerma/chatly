import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/utils/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignupEvent, SignupState> {
  SignUpBloc() : super(SignupState()) {
    on<SignupPhoneNumberChanged>(_onPhoneNumberChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupNameChanged>(_onNameChanged);
    on<SignupSubmitted>(_onSubmitted);
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
  ) {
    state.copyWith(formStatus: FormStatus.inProgress);

    //add this data to the hive

    state.copyWith(formStatus: FormStatus.success);
  }
}
