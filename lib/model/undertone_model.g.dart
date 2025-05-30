// Hive adapter to serialize and deserialize UndertoneModel for local storage.

part of 'undertone_model.dart';

class UndertoneModelAdapter extends TypeAdapter<UndertoneModel> {
  @override
  final int typeId = 0;

  @override
  UndertoneModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UndertoneModel(
      season: fields[0] as String,
      image: fields[1] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, UndertoneModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.season)
      ..writeByte(1)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UndertoneModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
