import '../repository/user_repository.dart';

Future<int> generateUserID() async {
  UserRepository userRepository = UserRepository();
  return await userRepository.getLastUserId() + 1;
}
