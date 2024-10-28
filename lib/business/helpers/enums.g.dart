// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ETriggersTypeAdapter extends TypeAdapter<ETriggersType> {
  @override
  final int typeId = 52;

  @override
  ETriggersType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ETriggersType.friend;
      case 1:
        return ETriggersType.family;
      case 2:
        return ETriggersType.lonelines;
      case 3:
        return ETriggersType.lover;
      case 4:
        return ETriggersType.temperature;
      case 5:
        return ETriggersType.disease;
      case 6:
        return ETriggersType.pressure;
      case 7:
        return ETriggersType.medication;
      case 8:
        return ETriggersType.sunny;
      case 9:
        return ETriggersType.cloudy;
      case 10:
        return ETriggersType.hot;
      case 11:
        return ETriggersType.rainy;
      case 12:
        return ETriggersType.snowy;
      case 13:
        return ETriggersType.cold;
      case 14:
        return ETriggersType.nutrition;
      case 15:
        return ETriggersType.sweet;
      case 16:
        return ETriggersType.snack;
      case 17:
        return ETriggersType.fatty;
      case 18:
        return ETriggersType.fatsfood;
      case 19:
        return ETriggersType.tea;
      case 20:
        return ETriggersType.coffee;
      case 21:
        return ETriggersType.alcohol;
      case 22:
        return ETriggersType.cigarettes;
      case 23:
        return ETriggersType.gadgets;
      case 24:
        return ETriggersType.music;
      case 25:
        return ETriggersType.shopping;
      case 26:
        return ETriggersType.sports;
      default:
        return ETriggersType.friend;
    }
  }

  @override
  void write(BinaryWriter writer, ETriggersType obj) {
    switch (obj) {
      case ETriggersType.friend:
        writer.writeByte(0);
        break;
      case ETriggersType.family:
        writer.writeByte(1);
        break;
      case ETriggersType.lonelines:
        writer.writeByte(2);
        break;
      case ETriggersType.lover:
        writer.writeByte(3);
        break;
      case ETriggersType.temperature:
        writer.writeByte(4);
        break;
      case ETriggersType.disease:
        writer.writeByte(5);
        break;
      case ETriggersType.pressure:
        writer.writeByte(6);
        break;
      case ETriggersType.medication:
        writer.writeByte(7);
        break;
      case ETriggersType.sunny:
        writer.writeByte(8);
        break;
      case ETriggersType.cloudy:
        writer.writeByte(9);
        break;
      case ETriggersType.hot:
        writer.writeByte(10);
        break;
      case ETriggersType.rainy:
        writer.writeByte(11);
        break;
      case ETriggersType.snowy:
        writer.writeByte(12);
        break;
      case ETriggersType.cold:
        writer.writeByte(13);
        break;
      case ETriggersType.nutrition:
        writer.writeByte(14);
        break;
      case ETriggersType.sweet:
        writer.writeByte(15);
        break;
      case ETriggersType.snack:
        writer.writeByte(16);
        break;
      case ETriggersType.fatty:
        writer.writeByte(17);
        break;
      case ETriggersType.fatsfood:
        writer.writeByte(18);
        break;
      case ETriggersType.tea:
        writer.writeByte(19);
        break;
      case ETriggersType.coffee:
        writer.writeByte(20);
        break;
      case ETriggersType.alcohol:
        writer.writeByte(21);
        break;
      case ETriggersType.cigarettes:
        writer.writeByte(22);
        break;
      case ETriggersType.gadgets:
        writer.writeByte(23);
        break;
      case ETriggersType.music:
        writer.writeByte(24);
        break;
      case ETriggersType.shopping:
        writer.writeByte(25);
        break;
      case ETriggersType.sports:
        writer.writeByte(26);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ETriggersTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EEmotionsAdapter extends TypeAdapter<EEmotions> {
  @override
  final int typeId = 53;

  @override
  EEmotions read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EEmotions.cry;
      case 1:
        return EEmotions.sad;
      case 2:
        return EEmotions.neutral;
      case 3:
        return EEmotions.happy;
      case 4:
        return EEmotions.lovely;
      default:
        return EEmotions.cry;
    }
  }

  @override
  void write(BinaryWriter writer, EEmotions obj) {
    switch (obj) {
      case EEmotions.cry:
        writer.writeByte(0);
        break;
      case EEmotions.sad:
        writer.writeByte(1);
        break;
      case EEmotions.neutral:
        writer.writeByte(2);
        break;
      case EEmotions.happy:
        writer.writeByte(3);
        break;
      case EEmotions.lovely:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EEmotionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EPageOnSelectAdapter extends TypeAdapter<EPageOnSelect> {
  @override
  final int typeId = 54;

  @override
  EPageOnSelect read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EPageOnSelect.homePage;
      case 1:
        return EPageOnSelect.statistics;
      case 2:
        return EPageOnSelect.settingsPage;
      case 3:
        return EPageOnSelect.listPage;
      default:
        return EPageOnSelect.homePage;
    }
  }

  @override
  void write(BinaryWriter writer, EPageOnSelect obj) {
    switch (obj) {
      case EPageOnSelect.homePage:
        writer.writeByte(0);
        break;
      case EPageOnSelect.statistics:
        writer.writeByte(1);
        break;
      case EPageOnSelect.settingsPage:
        writer.writeByte(2);
        break;
      case EPageOnSelect.listPage:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EPageOnSelectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ESortAdapter extends TypeAdapter<ESort> {
  @override
  final int typeId = 55;

  @override
  ESort read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ESort.date;
      case 1:
        return ESort.mood;
      default:
        return ESort.date;
    }
  }

  @override
  void write(BinaryWriter writer, ESort obj) {
    switch (obj) {
      case ESort.date:
        writer.writeByte(0);
        break;
      case ESort.mood:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ESortAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ERecentAdapter extends TypeAdapter<ERecent> {
  @override
  final int typeId = 56;

  @override
  ERecent read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ERecent.firstRecent;
      case 1:
        return ERecent.firstPast;
      case 2:
        return ERecent.firstGood;
      case 3:
        return ERecent.firstBad;
      default:
        return ERecent.firstRecent;
    }
  }

  @override
  void write(BinaryWriter writer, ERecent obj) {
    switch (obj) {
      case ERecent.firstRecent:
        writer.writeByte(0);
        break;
      case ERecent.firstPast:
        writer.writeByte(1);
        break;
      case ERecent.firstGood:
        writer.writeByte(2);
        break;
      case ERecent.firstBad:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ERecentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
