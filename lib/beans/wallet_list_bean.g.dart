// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletListBean _$WalletListBeanFromJson(Map<String, dynamic> json) {
  return WalletListBean(
    json['token_id'] as String,
    json['address'] as String,
    json['balance'] as String,
    json['token_ico'] as String,
  );
}

Map<String, dynamic> _$WalletListBeanToJson(WalletListBean instance) =>
    <String, dynamic>{
      'token_id': instance.tokenId,
      'address': instance.address,
      'balance': instance.balance,
      'token_ico': instance.tokenIco,
    };
