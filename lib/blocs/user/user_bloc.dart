import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserDataState()) {
    on<UserUpdatePhoneNumber>((event, emit) {
      emit(UserDataState(phoneNumber: event.phoneNumber));
    });
    on<UserUpdatePIN>((event, emit) {
      emit(UserDataState(pin: event.pin));
    });
    on<UserUpdateName>((event, emit) {
      emit(UserDataState(name: event.name));
    });
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    String phoneNumber = json['phoneNumber'] as String;
    String name = json['name'] as String;
    int pin = json['pin'] as int;
    return UserDataState(phoneNumber: phoneNumber, pin: pin, name: name);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserDataState) {
      return {
        'phoneNumber': state.phoneNumber,
        'pin': state.pin,
        'name': state.name
      };
    }
    return {'phoneNumber': '0'};
  }
}
