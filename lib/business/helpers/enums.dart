import 'dart:ui';

import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 52)
enum ETriggersType {
  @HiveField(0)
  friend(asset: 'assets/Friend.png', label: 'Friend', position: 1),
  @HiveField(1)
  family(asset: 'assets/Family.png', label: 'Family', position: 1),
  @HiveField(2)
  lonelines(asset: 'assets/Lonelines.png', label: 'Lonelines', position: 1),
  @HiveField(3)
  lover(asset: 'assets/Lover.png', label: 'Lover', position: 1),
  @HiveField(4)
  temperature(
      asset: 'assets/Temperature.png', label: 'Temperature', position: 2),
  @HiveField(5)
  disease(asset: 'assets/Disease.png', label: 'Disease', position: 2),
  @HiveField(6)
  pressure(asset: 'assets/Pressure.png', label: 'Pressure', position: 2),
  @HiveField(7)
  medication(asset: 'assets/Medication.png', label: 'Medication', position: 2),
  @HiveField(8)
  sunny(asset: 'assets/Sunny.png', label: 'Sunny', position: 3),
  @HiveField(9)
  cloudy(asset: 'assets/Cloudy.png', label: 'Cloudy', position: 3),
  @HiveField(10)
  hot(asset: 'assets/Hot.png', label: 'Hot', position: 3),
  @HiveField(11)
  rainy(asset: 'assets/Rainy.png', label: 'Rainy', position: 3),
  @HiveField(12)
  snowy(asset: 'assets/Snowy.png', label: 'Snowy', position: 3),
  @HiveField(13)
  cold(asset: 'assets/Cold.png', label: 'Cold', position: 3),
  @HiveField(14)
  nutrition(
      asset: 'assets/Propernutrition.png',
      label: 'Proper nutrition',
      position: 4),
  @HiveField(15)
  sweet(asset: 'assets/Sweet.png', label: 'Sweet', position: 4),
  @HiveField(16)
  snack(asset: 'assets/Nightsnack.png', label: 'Night snack', position: 4),
  @HiveField(17)
  fatty(asset: 'assets/Fattyfood.png', label: 'Fatty food', position: 4),
  @HiveField(18)
  fatsfood(asset: 'assets/FastFood.png', label: 'Fast Food', position: 4),
  @HiveField(19)
  tea(asset: 'assets/Tea.png', label: 'Tea', position: 4),
  @HiveField(20)
  coffee(asset: 'assets/Coffee.png', label: 'Coffee', position: 4),
  @HiveField(21)
  alcohol(asset: 'assets/Alcohol.png', label: 'Alcohol', position: 5),
  @HiveField(22)
  cigarettes(asset: 'assets/Cigarettes.png', label: 'Cigarettes', position: 5),
  @HiveField(23)
  gadgets(asset: 'assets/Gadgets.png', label: 'Gadgets', position: 5),
  @HiveField(24)
  music(asset: 'assets/Music.png', label: 'Music', position: 5),
  @HiveField(25)
  shopping(asset: 'assets/Shopping.png', label: 'Shopping', position: 5),
  @HiveField(26)
  sports(asset: 'assets/Sports.png', label: 'Sports', position: 5),
  ;

  final String label;
  final String asset;
  final int position;

  const ETriggersType(
      {required this.asset, required this.label, required this.position});
}

@HiveType(typeId: 53)
enum EEmotions {
  @HiveField(0)
  cry(
      assetEmpty: 'assets/cry_empty.png',
      assetFull: 'assets/cry_full.png',
      color: Color(0xFF916248),
      position: 5),
  @HiveField(1)
  sad(
      assetEmpty: 'assets/sad_empty.png',
      assetFull: 'assets/sad_full.png',
      color: Color(0xFFA18FFF),
      position: 4),
  @HiveField(2)
  neutral(
      assetEmpty: 'assets/neutral_empty.png',
      assetFull: 'assets/neutral_full.png',
      color: Color(0xFFFE814B),
      position: 3),
  @HiveField(3)
  happy(
      assetEmpty: 'assets/happy_empty.png',
      assetFull: 'assets/happy_full.png',
      color: Color(0xFF9AB16A),
      position: 2),
  @HiveField(4)
  lovely(
      assetEmpty: 'assets/lovely_empty.png',
      assetFull: 'assets/lovely_full.png',
      color: Color(0xFFFCCD5C),
      position: 1),
  ;

  final Color color;
  final String assetEmpty;
  final String assetFull;
  final int position;

  const EEmotions(
      {required this.assetEmpty,
      required this.assetFull,
      required this.color,
      required this.position});
}

@HiveType(typeId: 54)
enum EPageOnSelect {
  @HiveField(0)
  homePage,
  @HiveField(1)
  statistics,
  @HiveField(2)
  settingsPage,
  @HiveField(3)
  listPage
}

@HiveType(typeId: 55)
enum ESort {
  @HiveField(0)
  date,
  @HiveField(1)
  mood,
}

@HiveType(typeId: 56)
enum ERecent {
  @HiveField(0)
  firstRecent,
  @HiveField(1)
  firstPast,
  @HiveField(2)
  firstGood,
  @HiveField(3)
  firstBad;
}
