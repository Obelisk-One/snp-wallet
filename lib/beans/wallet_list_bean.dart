/*
 * @Project:        snp
 * @Package:        ui.base
 * @FileName:       wallet_list_bean
 * @Create:         2020/9/14 2:45 PM
 * @Description:    
 * @author          dt
*/

import 'package:json_annotation/json_annotation.dart';

part 'wallet_list_bean.g.dart';


List<WalletListBean> getWalletListBeanList(List<dynamic> list){
  List<WalletListBean> result = [];
  list.forEach((item){
    result.add(WalletListBean.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class WalletListBean extends Object {

  @JsonKey(name: 'token_id')
  String tokenId;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'balance')
  String balance;

  @JsonKey(name: 'token_ico')
  String tokenIco;

  WalletListBean(this.tokenId,this.address,this.balance,this.tokenIco,);

  factory WalletListBean.fromJson(Map<String, dynamic> srcJson) => _$WalletListBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WalletListBeanToJson(this);

}

  
