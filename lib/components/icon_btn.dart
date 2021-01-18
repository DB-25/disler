import 'package:flutter/material.dart';
import 'package:qirana_app/constants.dart';
import 'package:qirana_app/size_config.dart';

class IconBtn extends StatelessWidget {
  const IconBtn({
    Key key,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final Icon icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: icon,
            //child: Image.asset(svgSrc),
          ),
        ],
      ),
    );
  }
}
