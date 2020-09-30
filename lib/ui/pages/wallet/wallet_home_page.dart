/*
 * @Project:        snp
 * @Package:        ui.pages.wallet
 * @FileName:       wallet_home_page
 * @Create:         2020/8/27 2:18 PM
 * @Description:    
 * @author          dt
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snp/beans/wallet_list_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';

class WalletHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('口袋'),
        elevation: 2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: sInsetsAll(10),
            child: Text(
              '令牌',
              style: Font.title,
            ),
          ),
          Expanded(
            child: SListView(
              apiPath: API.wallet,
              separated: true,
              itemView: (index, item) =>
                  _renderCell(WalletListBean.fromJson(item)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderCell(WalletListBean item) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.tokenId),
          Text(
            item.balance,
            style: Font.normalS,
          ),
        ],
      ),
      leading: CachedNetworkImage(
        imageUrl: item.tokenIco,
        fit: BoxFit.cover,
        width: sWidth(40),
        height: sWidth(40),
      ),
      onTap: () {
        toast(item.tokenId);
      },
    );
  }
}
