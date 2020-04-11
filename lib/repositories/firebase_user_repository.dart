import 'package:firebase_auth/firebase_auth.dart';
import 'package:spending_tracker/models/user_entity.dart';
import 'package:spending_tracker/repositories/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth auth;

  const FirebaseUserRepository(this.auth);

  @override
  Future<UserEntity> login() async {
    final firebaseUser = await auth.signInAnonymously();

    return UserEntity(
      id: firebaseUser.user.uid,
      displayName: firebaseUser.user.displayName,
      photoUrl: firebaseUser.user.photoUrl,
    );
  }
}
