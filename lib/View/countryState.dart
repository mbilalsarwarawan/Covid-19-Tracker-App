import 'package:flutter/material.dart';

class CountryState extends StatefulWidget {
  String image, name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayDeaths,
      test;

  CountryState(
      {Key? key,
      required this.active,
      required this.image,
      required this.critical,
      required this.name,
      required this.test,
      required this.todayDeaths,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered})
      : super(key: key);

  @override
  State<CountryState> createState() => _CountryStateState();
}

class _CountryStateState extends State<CountryState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.name.toString()),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.067),
                child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06),
                        Reusable(
                            title: 'Total Cases',
                            value: widget.totalCases.toString()),
                        Reusable(
                            title: 'Active', value: widget.active.toString()),
                        Reusable(
                            title: 'Critical Condition',
                            value: widget.critical.toString()),
                        Reusable(
                            title: 'Death',
                            value: widget.totalDeaths.toString()),
                        Reusable(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString()),
                        Reusable(
                            title: 'Today Deaths',
                            value: widget.todayDeaths.toString()),
                        Reusable(title: 'Test', value: widget.test.toString()),
                      ],
                    )),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          )
        ],
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
            height: 8,
          ),
          Divider(),
        ],
      ),
    );
  }
}
