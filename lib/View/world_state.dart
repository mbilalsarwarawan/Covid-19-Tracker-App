import 'package:covid_tracker/Modal/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_servies.dart';
import 'package:covid_tracker/View/countryList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            FutureBuilder(
                future: stateServices.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        size: 50.0,
                        color: Colors.white,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Flexible(
                      child: Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                snapshot.data!.cases.toString(),
                              ),
                              "Recoverd": double.parse(
                                snapshot.data!.recovered.toString(),
                              ),
                              "Death": double.parse(
                                snapshot.data!.deaths.toString(),
                              )
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            colorList: colorList,
                            chartType: ChartType.ring,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            child: Card(
                                child: Column(
                              children: [
                                Reusable(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                                Reusable(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                Reusable(
                                    title: 'Critical Condition',
                                    value: snapshot.data!.critical.toString()),
                                Reusable(
                                    title: 'Death',
                                    value: snapshot.data!.deaths.toString()),
                                Reusable(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                Reusable(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CountryListScreen()));
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class Reusable extends StatelessWidget {
  String title, value;
  Reusable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Divider(),
        ],
      ),
    );
  }
}
