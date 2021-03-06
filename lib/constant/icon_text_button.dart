import 'package:flutter/material.dart';
class TextIconButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  TextIconButton(this.title,this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          IconButton(icon: Icon(Icons.card_travel_outlined),onPressed: onPressed,),
          Positioned(
            bottom: 5,
            right: 10,
            child: Container(
              height: 15,
              width: 15,
              decoration:BoxDecoration(
            color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
              child: Center(
                  child: Text(title)
              ),
            ),
          )
        ],
      ),
    );
  }
}
