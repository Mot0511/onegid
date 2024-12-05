import 'package:flutter/material.dart';
import 'package:onegid/components/post.dart';
import 'package:onegid/services/fetchCategories.dart';

class Selection extends StatefulWidget{
  const Selection({super.key, required this.children});
  final List<Post> children;

  State<Selection> createState() => _Selection();
}

class _Selection extends State<Selection>{
  _Selection();

  late final categories = getCategories();
  String selectedCat = '0';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(
              future: categories,
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  final List<Widget> children = [];
                  final data = snap.data;
                  data.forEach((key, value) {
                    children.add(CatItem(title: value, value: key, selectedCat: selectedCat, onClick: () => setState(() => selectedCat = key)));
                  });
                  return Row(children: children);
                } else {
                  return SizedBox.shrink();
                }
              },
            )
          ),
        ),
        Builder(
          builder: (BuildContext context) {
            final List<Post> children = [];
            widget.children.forEach((child) {
              if (selectedCat == child.post.catId) {
                children.add(child);
              }
            });
            return Wrap(children: children);
          },
        )
      ],
    );
  }
}

class CatItem extends StatelessWidget{
  const CatItem({super.key, required this.title, required this.value, required this.selectedCat, required this.onClick});
  final String title;
  final String value;
  final String selectedCat;
  final onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green, width: 2),
          color: value == selectedCat ? Colors.green : Colors.white,
        ),
        child: InkWell(
          onTap: () {
            print('$value, $selectedCat');
            onClick();
            print('$value, $selectedCat');
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(title, style: TextStyle(fontSize: 18, color: value == selectedCat ? Colors.white : Colors.green))
            ),
          )
        )
      )
    );
  }
}