// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      score: json['score'] as num? ?? 0,
      ratingCount: json['ratingCount'] as num? ?? 0,
      description: json['description'] as String? ?? '',
      categoryCode: (json['categoryCode'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [''],
      isRecommended: json['isRecommended'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'price': instance.price,
      'score': instance.score,
      'ratingCount': instance.ratingCount,
      'description': instance.description,
      'categoryCode': instance.categoryCode,
      'isRecommended': instance.isRecommended,
    };