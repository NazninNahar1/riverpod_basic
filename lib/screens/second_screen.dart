import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic/main.dart';

class SecondScreen extends ConsumerWidget {
  const SecondScreen({Key? key}) : super(key: key);


  void onsubmitname (WidgetRef ref , String textValue ){
    ref.read(nameProvider.notifier).updateName(textValue);
    ref.refresh(nameProvider);

  }
  void onsubmitAge (WidgetRef ref , String textValue ){
    ref.read(nameProvider.notifier).updateAgee(int.parse(textValue));

  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(nameProvider);
    return Scaffold(
      appBar: AppBar(
        title:  Text('StateProvider ${user.age.toString()}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                TextField(
                  onChanged: (textValue)=>onsubmitname(ref,textValue),
                ),
                TextField(
                  onChanged:(textValue)=>onsubmitAge(ref,textValue) ,
                ),
              ],
            ),

          ),
          Expanded(child: Column(
            children: [
              Text(user.name.toString()),
              Text(user.age.toString())
            ],
          )),
        ],
      ),
    );
  }
}
