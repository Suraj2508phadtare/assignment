import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import '../constant_variable/constant_var.dart';

class _AZItem extends ISuspensionBean {
  final String title;
  final String tag;
  final String image;

  _AZItem({required this.tag, required this.title, required this.image});

  @override
  String getSuspensionTag() => tag;
}

class AlphabetScrollPage extends StatefulWidget {
  final List<String> items;
  final List<String> images;
  final ValueChanged<String> onClickedItem;

  const AlphabetScrollPage({
    Key? key,
    required this.items,
    required this.images,
    required this.onClickedItem,
  }) : super(key: key);

  @override
  State<AlphabetScrollPage> createState() => _AlphabetScrollPageState();
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage> {
  List<_AZItem> items = [];
  List<_AZItem> images = [];

  @override
  void initState() {
    super.initState();

    initList(widget.items, widget.images);
  }

  @override
  void didUpdateWidget(covariant AlphabetScrollPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    initList(widget.items, widget.images);
  }

  void initList(List<String> items, List<String> images) {
    final theMap = Map.fromIterables(items, images);

    this.items = theMap.entries.map((entry) =>
    _AZItem(title: entry.key, tag: entry.key[0].toUpperCase(), image: entry.value))
    .toList();       

    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => AzListView(
        padding: const EdgeInsets.all(16),
        data: items,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildListItem(item, index);
        },
        indexHintBuilder: (context, tag) => Container(
          alignment: Alignment.center,
          width: 60,
          height: 60,
          child: Text(
            tag,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        indexBarOptions: const IndexBarOptions(
            needRebuild: true,
            selectTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            selectItemDecoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            indexHintAlignment: Alignment.centerRight,
            indexHintOffset: Offset(-20, 0)),
      );

  Widget _buildListItem(_AZItem item, int index) {
    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;
    return Column(
      children: [
        Offstage(offstage: offstage, child: buildHeader(tag)),
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: ListTile(
            leading: Image.network(item.image),
            title: Text(item.title),
            onTap: () {

              String s = item.title;
              int idx = s.indexOf(":");
              List parts = [s.substring(0,idx).trim(), s.substring(idx+2).trim()];
              
              print("debugidx : "+parts[1].toString());
              int idx2 = int.parse(parts[1]);
              if(idx2 == 000){
                ConstantVar.indexCont =999;
              }else
              ConstantVar.indexCont = idx2 - 1;
              print("debugidx : "+ConstantVar.indexCont.toString());
              widget.onClickedItem(item.title);
            } 
          ),
        ),
      ],
    );
  }

  Widget buildHeader(String tag) => Container(
        height: 50,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.only(left: 3),
        color: Colors.grey.shade300,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/user.png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '$tag',
              softWrap: false,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
