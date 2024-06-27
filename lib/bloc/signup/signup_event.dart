import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupPhoneNumberChanged extends SignupEvent {
  final String phoneNumber;

  const SignupPhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SignupPasswordChanged extends SignupEvent {
  final String password;

  const SignupPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignupNameChanged extends SignupEvent {
  final String name;

  const SignupNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}

class SignupClearFieldOnNavigation extends SignupEvent {
  const SignupClearFieldOnNavigation();
}
