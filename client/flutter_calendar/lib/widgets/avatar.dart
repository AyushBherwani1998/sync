import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/ens/ens_avatar.dart';
import 'package:random_avatar/random_avatar.dart';

class Avatar extends StatefulWidget {
  final String ens;
  const Avatar({
    super.key,
    required this.ens,
  });

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EnsAvatar.getENSAvatar(widget.ens),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            return ClipOval(
              child: CachedNetworkImage(
                imageUrl: snapshot.data!,
                height: 64,
                width: 64,
                fit: BoxFit.fill,
              ),
            );
          }
        }
        return randomAvatar(widget.ens, height: 64, width: 64);
      },
    );
  }
}
