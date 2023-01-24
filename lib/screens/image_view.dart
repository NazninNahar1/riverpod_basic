import 'package:flutter/material.dart';
import 'dart:io';
class ImageView extends StatefulWidget {
  final File? value;
   ImageView({Key? key, this.value}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  @override
  Widget build(BuildContext context) {
    final File file = File(widget.value!.path);
    return Center(
      child: Container(
        height: 400,
        width: 380,
        child:  Image.file(file,fit: BoxFit.cover,),
      ),
    );
  }
}
