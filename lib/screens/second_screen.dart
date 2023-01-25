
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../service/fetchapi_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'image_view.dart';
class Second extends ConsumerStatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  ConsumerState<Second> createState() => _SecondState();
}

class _SecondState extends  ConsumerState<Second> {
  final ScrollController _controller= ScrollController();
  List images= [];
  late File? _currentimg;

  // bool imageSelect = false;
  Future  cameraImage() async {
   final image = (await ImagePicker().pickImage(source: ImageSource.camera));
   final File? file = File(image!.path);
    setState(() {
      images.add(file);
      print(images.length);
      print(file);
    });
  }
  Future galleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final File? file = File(image!.path);
    setState(() {
      images.add(file);
      print(images.length);
      print(file);
    });
  }





  @override
  Widget build(BuildContext context) {
    return ref.watch(fetchapiProvider).when(data: (data) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Riverpod Api Fetch'),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/second');
            }, icon: Icon(Icons.arrow_forward_outlined),)
          ],
        ),
        body: Column(
          children:  [
            Expanded(
              flex: 1,
              child: ListView.builder(
                  controller: _controller,
                  itemCount: data.records.length,
                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .15,
                          width: MediaQuery.of(context).size.width * .4,


                          child: InkWell(

                            child: Card(
                              margin: EdgeInsets.all(8),
                              color:  Color(0xff005981),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(

                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '  ${data.records[index].responsibleName
                                              .toString()}',
                                          style: const TextStyle(fontSize: 25,color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '  ${DateFormat('yyyy-MM-dd').format(data.records[index].startDate)}',
                                          style: const TextStyle(fontSize: 25,color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Expanded(child: CircularProgressIndicator())
                                ],
                              ),
                            ),
                            onTap: (){
                              double changedPosition = _controller.position.pixels + 100.0 ;
                              _controller.position.jumpTo(changedPosition);
                              print('Tapped');


                            },
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Expanded(
                flex: 3,
                child : Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){
                          cameraImage();
                        }, icon:const Icon(Icons.add_a_photo)),
                        const SizedBox(width: 15,),
                        IconButton(onPressed: (){}, icon:const Icon(Icons.photo_library_outlined)),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,

                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  _currentimg=images[index];
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ImageView(
                                        value:  _currentimg,
                                      )));


                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,

                                  child: Image.file(images[index],fit: BoxFit.cover,),
                                ),
                              )
                            ],
                          );
                        },

                      ),
                    ),

                  ],
                ),


            ),

          ],
        ),

      );
    }, error: (Object error, StackTrace stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}


