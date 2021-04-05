abstract class DB {
  Stream getData();
  Future<void> saveData(value);
  Future<void> updateData(value);
  Future<void> deleteData(value);
  getId();
}
