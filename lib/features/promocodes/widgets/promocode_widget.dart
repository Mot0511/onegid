import 'package:flutter/material.dart';
import 'package:onegid/features/promocodes/promocodes.dart';

class PromocodeWidget extends StatefulWidget {
  const PromocodeWidget({super.key, required this.promocode});
  final Promocode promocode;

  @override
  State<PromocodeWidget> createState() => _PromocodeWidgetState();
}

class _PromocodeWidgetState extends State<PromocodeWidget> {

  bool isCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    final Promocode promocode = widget.promocode;
    final theme = Theme.of(context);
    return Container(
      width: 250,
      height: 500,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: theme.canvasColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black)]
      ),
      child: Column(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/promocodes/${promocode.name}.png'), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(promocode.title, style: theme.textTheme.titleLarge),
                SizedBox(height: 10),
                Text(promocode.description, style: theme.textTheme.bodyMedium),
                SizedBox(height: 40),
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(isCodeVisible ? promocode.code : '***', style: theme.textTheme.titleLarge),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ButtonTheme(
                    minWidth: 230,
                    child: ElevatedButton(
                      onPressed: () => setState(() => isCodeVisible = true),
                      child: Text('Получить', style: theme.textTheme.labelLarge),
                    ),
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
}