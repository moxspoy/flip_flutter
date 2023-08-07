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
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    String phoneNumber = json['phoneNumber'] as String;
    return UserDataState(phoneNumber: phoneNumber);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserDataState) {
      return {'phoneNumber': state.phoneNumber};
    }
    return {'phoneNumber': '0'};
  }
}
