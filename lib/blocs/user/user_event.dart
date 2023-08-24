part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

final class UserUpdatePhoneNumber extends UserEvent {
  UserUpdatePhoneNumber(this.phoneNumber);

  final String phoneNumber;
}

final class UserUpdateStatus extends UserEvent {}

final class UserUpdateName extends UserEvent {
  UserUpdateName(this.name);

  final String name;
}

final class UserUpdatePIN extends UserEvent {
  UserUpdatePIN(this.pin);

  final int pin;
}

final class UserUpdateAfterRegister extends UserEvent {}

final class UserClearOnLogout extends UserEvent {}
