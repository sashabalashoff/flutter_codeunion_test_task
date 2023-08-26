import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../res/svg.dart' as svg;

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.transparent,
        child: SvgPicture.string(svg.profileAvatar),
      ),
    );
  }
}
