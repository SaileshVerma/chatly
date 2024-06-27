import 'package:chatly/bloc/SignUp/SignUp_event.dart';
import 'package:bloc/bloc.dart';
import 'package:chatly/bloc/signup/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignupState> {
  SignUpBloc() : super(SignupState()) {
    on<SignUpPhoneNumberChanged>(_onPhoneNumberChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpNameChanged>(_onNameChanged);
    on<SignUpSubmitted>(_onSubmitted);
  }

  void _onPhoneNumberChanged(
    SignUpPhoneNumberChanged event,
    Emitter<SignupState> emit,
  ) {}

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignupState> emit,
  ) {}

  void _onNameChanged(
    SignUpNameChanged event,
    Emitter<SignupState> emit,
  ) {}

  void _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignupState> emit,
  ) {}
}
