part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserDataState extends UserState {
  final int? id;
  final String? phoneNumber;
  final String? name;
  final String? email;
  final int? status;
  final int? balance;
  final String? gender;
  final String? job;

  final String? address;
  final String? identityPhotoUrl;

  UserDataState({
    this.id,
    this.phoneNumber,
    this.name,
    this.email,
    this.status,
    this.balance,
    this.gender,
    this.job,
    this.address,
    this.identityPhotoUrl,
  });
}
