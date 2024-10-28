// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodEntityAdapter extends TypeAdapter<MoodEntity> {
  @override
  final int typeId = 1;

  @override
  MoodEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodEntity(
      id: fields[0] as String,
      triggers: (fields[1] as List).cast<ETriggersType>(),
      emotion: fields[2] as EEmotions,
      note: fields[3] as String,
      date: fields[4] as DateTime,
      customTriggers: (fields[5] as Map).cast<int, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MoodEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.triggers)
      ..writeByte(2)
      ..write(obj.emotion)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.customTriggers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
