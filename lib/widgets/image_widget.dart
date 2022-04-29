import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageWidget extends StatelessWidget {
  final File? image;
  final AssetImage? imageAsset;
  final ValueChanged<ImageSource> onClicked;
  final double width;
  final double height;
  final bool enableEditButton;

  const ImageWidget({
    Key? key,
    this.image,
    this.imageAsset,
    required this.onClicked,
    required this.width,
    required this.height,
    required this.enableEditButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        image != null
            ? buildImage(context, width, height)
            : buildImageAsset(context, width, height),
        Positioned(
          bottom: 4,
          right: 5,
          child: enableEditButton == true
              ? buildEditIcon(Colors.orange, context)
              : Container(),
        ),
      ],
    ));
  }

  Widget buildImage(BuildContext context, double width, double height) {
    final imagePath = this.image!.path;
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image as ImageProvider,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }

  Widget buildImageAsset(BuildContext context, double width, double height) {
    return Material(
      color: Colors.transparent,
      child: Ink.image(
        image: imageAsset!,
        fit: BoxFit.cover,
        width: width,
        height: height,
        child: InkWell(onTap: () async {
          final source = await showImageSource(context);
          if (source == null) return;

          onClicked(source);
        }),
      ),
    );
  }

  Widget buildEditIcon(Color color, context) => buildCircle(
        context: context,
        color: Colors.orange,
        all: 8,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      );

  Widget buildCircle(
          {required Widget child,
          required double all,
          required Color color,
          required context}) =>
      Material(
          color: Colors.transparent.withOpacity(0),
          child: ClipOval(
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () async {
                final source = await showImageSource(context);
                if (source == null) return;

                onClicked(source);
              },
              child: Container(
                padding: EdgeInsets.all(all),
                color: color,
                child: child,
              ),
            ),
          ));

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () =>
                          Navigator.of(context).pop(ImageSource.camera),
                      child: const Text('Camera')),
                  CupertinoActionSheetAction(
                      onPressed: () =>
                          Navigator.of(context).pop(ImageSource.gallery),
                      child: const Text('Gallery')),
                ],
              ));
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Camera'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      );
    }
  }
}
