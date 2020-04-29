import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.text, this.iconData, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                size: 32,
                color: pageController.page.round() == page
                    ? Colors.white
                    : Colors.grey[700],
              ),
              //SizedBox(width: 32,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: pageController.page.round() == page
                          ? Colors.white
                          : Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
