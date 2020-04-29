import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String text;

  DrawerTile(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ()
        {
          
        },
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                size: 32,
                color: Colors.white,
              ),
              //SizedBox(width: 32,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
