import 'package:chatly/utils/constants/enums.dart';
import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final FormStatus formStatus;
  final String number;
  final String password;
  final String name;
  final String errorMessage;

  const SignupState({
    this.formStatus = FormStatus.initial,
    this.number = '',
    this.password = '',
    this.name = '',
    this.errorMessage = "",
  });

  SignupState copyWith({
    String? number,
    FormStatus? formStatus,
    String? password,
    String? name,
    String? errorMessage,
  }) {
    return SignupState(
      number: number ?? this.number,
      password: password ?? this.password,
      name: name ?? this.name,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        number,
        name,
        formStatus,
        password,
        errorMessage,
      ];
}
