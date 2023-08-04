class User {
  final int id;
  final String phoneNumber;
  final String name;
  final String email;
  final int status;
  final int balance;
  final String gender;
  final String job;

  final int addressRefID;
  final int identityRefID;

  User.name(
      this.id,
      this.phoneNumber,
      this.name,
      this.email,
      this.status,
      this.balance,
      this.gender,
      this.job,
      this.addressRefID,
      this.identityRefID);
}
