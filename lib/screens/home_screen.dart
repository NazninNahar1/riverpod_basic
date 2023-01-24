import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../service/fetchapi_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


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

          ),
              Container(
                width: 500,
                height: 500,
                child: _MyChart(),


              ),

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
class _MyChart extends StatefulWidget {
  const _MyChart({Key? key}) : super(key: key);

  @override
  State<_MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<_MyChart> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Half yearly sales analysis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].year,
                yValueMapper: (int index) => data[index].sales,
                dataCount: 5,
              ),
            ),
          )
        ]));
  }
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

