import 'package:flutter/material.dart';

class AddBtnWidget extends StatelessWidget {
  const AddBtnWidget({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage('assets/images/add.png'))
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/$path')
      ),
    );
  }
}