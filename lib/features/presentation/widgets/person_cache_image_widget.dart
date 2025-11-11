import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonCacheImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height;

  const PersonCacheImageWidget({
     this.width = 166,
     this.height = 166,
    required this.imageUrl,
    super.key,
  });

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,

      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      imageUrl: imageUrl ?? '',
      placeholder: (context, utl) {
        return Center(child: CircularProgressIndicator());
      },

      errorWidget: (context, url, error) {
        return _imageWidget(AssetImage('assets/image/noimage.jpg'));
      },
    );
  }
}
