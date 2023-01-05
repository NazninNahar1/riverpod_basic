import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_basic/main.dart';
import '../service/fetchapi_provider.dart';

class SecondScreen extends ConsumerWidget {
   SecondScreen({Key? key}) : super(key: key);
  ScrollController _controller= ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        body: Container(
          child: Column(
            children:  [
              Expanded(
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




                            child: Center(
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
                          ),
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
