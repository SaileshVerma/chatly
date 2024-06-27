import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpPhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  const SignUpPhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpNameChanged extends SignUpEvent {
  final String name;

  const SignUpNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}

class SignUpClearFieldOnNavigation extends SignUpEvent {
  const SignUpClearFieldOnNavigation();
}
