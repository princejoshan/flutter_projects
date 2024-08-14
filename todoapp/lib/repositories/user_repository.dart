import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/model/user_model.dart';

class UserRepository {
  UserRepository._privateConstructor();

  static final UserRepository _instance = UserRepository._privateConstructor();

  factory UserRepository() {
    return _instance;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;

  Future<List<UserModel>> getUsers() async {
    final querySnapshot = await store.collection('users').get();
    final users = querySnapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
    return users;
  }

  Future<void> updateUserRole(String userId, String newRole) async {
    try {
      await store.collection('users').doc(userId).update({
        'role': newRole,
      });
    } catch (e) {
      print('Failed to update user role: $e');
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();
    final currentUser = UserModel.fromDocumentSnapshot(docSnapshot);
    setCurrentUser(currentUser);
    return currentUser;
  }

  Future<UserCredential> signUp(
      {required String email,
      required String password,
      required String role}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'uid': userCredential.user!.uid,
      'email': email,
      'role': role,
      'pwd':password
    });
    return userCredential;
  }

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  void setCurrentUser(UserModel user) {
    _currentUser = user;
  }
}
