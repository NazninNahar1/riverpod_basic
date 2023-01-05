import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../service/fetchapi_provider.dart';


class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);


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
            itemCount: data.records.length,

                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(

                        height: MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.width * 1,

                        child: Card(
                          margin: EdgeInsets.all(8),
                          color:  Colors.white,
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
                                      '  ${data.records[index].moduleName
                                          .toString()}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '  ${DateFormat('yyyy-MM-dd').format(data.records[index].startDate)}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              //Expanded(child: CircularProgressIndicator())
                            ],
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
