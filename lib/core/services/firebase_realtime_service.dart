import 'package:controle_de_abastecimento_e_veiculos/features/auth/repository/auth_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeService {
  final db = FirebaseDatabase.instance.ref();
  final AuthRepository auth;

  FirebaseRealtimeService(this.auth);

  String get userId => auth.service.currentUser!.uid;

  DatabaseReference ref(String path) {
    return db.child("users/$userId/$path");
  }

  Future<String> create(String path, Map<String, dynamic> data) async {
    final newRef = ref(path).push();
    await newRef.set(data);
    return newRef.key!;
  }

  Future<Map<String, dynamic>?> readAll(String path) async {
    final snapshot = await ref(path).get();
    if (!snapshot.exists) return null;

    return Map<String, dynamic>.from(snapshot.value as Map);
  }

  Future<void> update(String path, Map<String, dynamic> data) async {
    await ref(path).update(data);
  }

  Future<void> delete(String path, String id) async {
    await ref("$path/$id").remove();
  }
}
