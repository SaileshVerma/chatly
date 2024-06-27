import 'package:chatly/utils/constants/enums.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final FormStatus formStatus;
  final String number;
  final String password;
  final String errorMessage;

  const LoginState({
    this.formStatus = FormStatus.initial,
    this.number = '',
    this.password = '',
    this.errorMessage = "",
  });

  LoginState copyWith({
    String? number,
    FormStatus? formStatus,
    String? password,
    String? errorMessage,
  }) {
    return LoginState(
      number: number ?? this.number,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        formStatus,
        number,
        password,
        errorMessage,
      ];
}
