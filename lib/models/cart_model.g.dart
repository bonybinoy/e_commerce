// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartModelAdapter extends TypeAdapter<CartModel> {
  @override
  final int typeId = 1;

  @override
  CartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartModel(
      counter: fields[4] as int,
      imgUrl: fields[0] as String,
      text: fields[1] as String,
      details: fields[2] as String?,
      qty: fields[3] as int,
      offer: fields[6] as int?,
      price: fields[7] as int,
      rating: fields[8] as String?,
      index: fields[10] as int,
      star: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.imgUrl)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.details)
      ..writeByte(3)
      ..write(obj.qty)
      ..writeByte(4)
      ..write(obj.counter)

      ..writeByte(6)
      ..write(obj.offer)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.star)
      ..writeByte(10)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
