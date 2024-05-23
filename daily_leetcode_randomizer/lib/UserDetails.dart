import 'package:isar/isar.dart';
part 'UserDetails.g.dart';

@Collection()
class UserDetails {
  Id id = Isar.autoIncrement;
  String username = "";
  String password = "";
}
