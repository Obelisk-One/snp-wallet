/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       user_list_view
 * @Create:         2020/9/21 7:29 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snp/beans/user_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/pages/news/store/user_list.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';
import 'package:snp/ui/widgets/user_cell_view.dart';

class UserListView extends StatelessWidget {
  final bool selection;
  final int maxSelection;
  final List selected;

  UserListView({
    Key key,
    this.selection = false,
    this.maxSelection = 0,
    this.selected,
  }) : super(key: key);

  final _store = UserListStore();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _store.setSelected(selected);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: sInsetsHV(10, 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CColor.bgGrayColor,
                      contentPadding: sInsetsHV(15, 0),
                      hintText: '输入关键词检索用户',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CColor.bgGrayColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CColor.bgGrayColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIcon: Observer(
                        builder: (_) => Visibility(
                          visible: _store.didInput,
                          child: GestureDetector(
                            onTap: () {
                              _controller.text = '';
                              _store.onInput('');
                            },
                            child: Padding(
                              padding: sInsetsAll(15, sc: false),
                              child: ClipOval(
                                child: Container(
                                  color: CColor.coverColor,
                                  child: Icon(
                                    Icons.close,
                                    size: 15,
                                    color: CColor.overMainTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) => _store.onInput(value),
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    '完成',
                    style: Font.light,
                  ),
                  onPressed: () =>
                      RouteUtil.popWithData(_store.selected, context),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Observer(
              builder: (_) => SListView(
                apiPath: API.userList,
                params: {'search': _store.searchString},
                separated: true,
                itemView: (index, item) {
                  UserBean bean = UserBean.fromJson(item);
                  return Observer(
                    builder: (_) {
                      bool _selected =
                          _store.selected.any((e) => e.id == bean.id);
                      return UserCell(
                        bean,
                        selection: selection,
                        selected: _selected,
                        onTap: () {
                          if (_store.selected.length >= maxSelection &&
                              maxSelection > 0 &&
                              !_selected)
                            toast('最多可选择$maxSelection位用户');
                          else
                            _store.onItemClick(bean);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
