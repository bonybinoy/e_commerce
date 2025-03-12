// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishListModelAdapter extends TypeAdapter<WishListModel> {
  @override
  final int typeId = 2;

  @override
  WishListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishListModel(
      description: fields[4] as String?,
      imgUrl: fields[0] as String,
      index: fields[1] as int?,
      text: fields[2] as String?,
      details: fields[3] as String?,
      offer: fields[5] as int?,
      offerPrice: fields[6] as int?,
      price: fields[7] as int?,
      rating: fields[8] as String?,
      star: fields[9] as String?,
      people: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WishListModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.imgUrl)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.details)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.offer)
      ..writeByte(6)
      ..write(obj.offerPrice)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.star)
      ..writeByte(10)
      ..write(obj.people);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
