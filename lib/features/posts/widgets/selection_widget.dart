import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';
import 'package:onegid/services/fetchCategories.dart';
import 'package:onegid/features/posts/posts.dart';

class Selection extends StatefulWidget{
  const Selection({super.key, required this.children});
  final List<PostWidget> children;

  State<Selection> createState() => _Selection();
}

class _Selection extends State<Selection>{
  _Selection();

  final PostsRepository posts_repository = GetIt.I<PostsRepository>();

  Map<String, String>? categories;
  String selectedCat = '0';

  void getData() async {
    categories = await posts_repository.getCategories();
    setState(() {});
  }
 
  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: categories == null ?
              SizedBox.shrink() :
              Builder(builder: (BuildContext context) {
                final List<Widget> children = [];
                categories?.forEach((key, value) {
                  children.add(CatItem(title: value, value: key, selectedCat: selectedCat, onClick: () => setState(() => selectedCat = key)));
                });
                return Row(children: children);
              })
        
          ),
        ),
        Builder(
          builder: (BuildContext context) {
            final List<PostWidget> children = [];
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
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.primaryColor, width: 2),
          color: value == selectedCat ? theme.primaryColor : Colors.transparent,
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
              child: Text(title, style: TextStyle(fontSize: 18, color: value == selectedCat ? Colors.white : theme.primaryColor))
            ),
          )
        )
      )
    );
  }
}